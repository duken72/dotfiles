#!/bin/bash

# Claude Code status line. Claude Code pipes session JSON to stdin, fields:
# https://code.claude.com/docs/en/statusline#available-data
# Line 1: dir and git branch, on their own line since both can be long
# Line 2: git changes (files, staged, unstaged, lines added and deleted)
# Line 3: model - effort | context bar | plan usage (5-hour and 7-day limits,
# only on Pro and Max plans)
# The model, effort and branch icons are Nerd Font glyphs.

eval "$(jq -r 'def pct: if type == "number" then round else "" end;
@sh "cwd=\(.workspace.current_dir // "")
model=\(.model.display_name // "?")
effort=\(.effort.level // "")
ctx_size=\(.context_window.context_window_size // 0)
ctx_used=\(.context_window.current_usage // {} | (.input_tokens // 0)
  + (.cache_creation_input_tokens // 0) + (.cache_read_input_tokens // 0))
five=\(.rate_limits.five_hour.used_percentage | pct)
five_reset=\(.rate_limits.five_hour.resets_at // "")
week=\(.rate_limits.seven_day.used_percentage | pct)
week_reset=\(.rate_limits.seven_day.resets_at // "")"')"

RST=$'\e[0m'
DIM=$'\e[90m'
RED=$'\e[31m'
GREEN=$'\e[32m'
YELLOW=$'\e[33m'
BLUE=$'\e[34m'
MAGENTA=$'\e[35m'
CYAN=$'\e[36m'
SEP=" ${DIM}|${RST} "
# Escapes, since editors and tools can strip private-use glyphs.
ROBOT=$'\U000f06a9' # nf-md-robot
BRAIN=$'\U000f09d1' # nf-md-brain
BRANCH=$'\ue0a0'    # powerline branch

model_line="${CYAN}${ROBOT} ${model}${RST}"
[[ -n $effort ]] && model_line+="${CYAN} - ${YELLOW}${BRAIN} ${effort}${RST}"
if ((ctx_size > 0)); then
    # Ten segments, each 10 % of the context window; green below 50 %,
    # yellow below 80 %, red above.
    n=$(((ctx_used * 10 + ctx_size / 2) / ctx_size))
    ((n > 10)) && n=10
    pct=$((ctx_used * 100 / ctx_size))
    ((pct < 50)) && c=$GREEN || { ((pct < 80)) && c=$YELLOW || c=$RED; }
    bar=""
    for ((i = 0; i < 10; i++)); do ((i < n)) && bar+="▰" || bar+="▱"; done
    model_line+="${SEP}${pct}% ${c}${bar}${RST}"
fi

# Plan usage: label, percent, reset epoch, date format. Same bar and colors
# as the context bar. Prints nothing when Claude Code sends no such window.
usage() {
    local pct=$2 n c bar="" i
    [[ -z $pct ]] && return
    n=$(((pct * 10 + 50) / 100))
    ((n > 10)) && n=10
    ((pct < 50)) && c=$GREEN || { ((pct < 80)) && c=$YELLOW || c=$RED; }
    for ((i = 0; i < 10; i++)); do ((i < n)) && bar+="▰" || bar+="▱"; done
    printf '%s' "$1 ${pct}% ${c}${bar}${RST}"
    [[ -n $3 ]] && printf '%s' " ${DIM}$(date -d "@$3" +"$4")${RST}"
}
five_part=$(usage 5h "$five" "$five_reset" %H:%M)
week_part=$(usage 7d "$week" "$week_reset" "%a %H:%M")
usage_line=$five_part
[[ -n $five_part && -n $week_part ]] && usage_line+=$SEP
usage_line+=$week_part
[[ -n $usage_line ]] && model_line+="${SEP}${usage_line}"
# Printed last, also when the git section below exits early.
trap 'printf "%s\n" "$model_line"' EXIT

line="${BLUE}📂 ${cwd/#$HOME/\~}${RST}"
branch=$(git -C "$cwd" branch --show-current 2>/dev/null)
[[ -n $branch ]] && line+=" ${MAGENTA}${BRANCH} ${branch}${RST}"
printf '%s\n' "$line"

# Line 2, in a git repo only: changed files, then lines added and deleted
# since HEAD (staged and unstaged). --no-optional-locks keeps this read-only
# refresh from blocking git commands that run at the same time.
g=(git --no-optional-locks -C "$cwd")
status=$("${g[@]}" status --porcelain 2>/dev/null) || exit 0
if [[ -z $status ]]; then
    printf '%s\n' "${GREEN}clean${RST}"
    exit 0
fi
# Porcelain columns: X = staged, Y = unstaged, "??" = untracked.
read -r files staged unstaged untracked <<<"$(awk '
    { n++ }
    /^\?\?/ { u++; next }
    substr($0, 1, 1) != " " { s++ }
    substr($0, 2, 1) != " " { w++ }
    END { print n + 0, s + 0, w + 0, u + 0 }' <<<"$status")"
# Binary files print "-" in --numstat, which awk counts as 0. In a repo with
# no commits HEAD doesn't exist, so the counts stay 0.
read -r added deleted <<<"$("${g[@]}" diff HEAD --numstat 2>/dev/null |
    awk '{ a += $1; d += $2 } END { print a + 0, d + 0 }')"
((files == 1)) && word=file || word=files
line="${files} ${word} changed${SEP}${GREEN}${staged} staged${RST}"
line+="${SEP}${YELLOW}${unstaged} unstaged${RST}"
((untracked)) && line+="${SEP}${DIM}${untracked} untracked${RST}"
line+="${SEP}${GREEN}+${added}${RST} ${RED}-${deleted}${RST}"
printf '%s\n' "$line"
