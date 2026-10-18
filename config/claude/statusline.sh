#!/bin/bash

# Claude Code status line. Claude Code pipes session JSON to stdin, fields:
# https://code.claude.com/docs/en/statusline#available-data
# Line 1: model - effort dir git branch | context bar
# Line 2: git changes (files, staged, unstaged, lines added and deleted)
# The model, effort and branch icons are Nerd Font glyphs.

eval "$(jq -r '@sh "cwd=\(.workspace.current_dir // "")
model=\(.model.display_name // "?")
effort=\(.effort.level // "")
ctx_size=\(.context_window.context_window_size // 0)
ctx_used=\(.context_window.current_usage // {} | (.input_tokens // 0)
  + (.cache_creation_input_tokens // 0) + (.cache_read_input_tokens // 0))"')"

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

# 94400 -> 94.4k, 200000 -> 200k
kilo() {
    local n=$1
    ((n % 1000)) && echo "$((n / 1000)).$((n % 1000 / 100))k" || echo "$((n / 1000))k"
}

line="${CYAN}${ROBOT} ${model}${RST}"
[[ -n $effort ]] && line+="${CYAN} - ${YELLOW}${BRAIN} ${effort}${RST}"
line+=" ${BLUE}📂 ${cwd/#$HOME/\~}${RST}"
branch=$(git -C "$cwd" branch --show-current 2>/dev/null)
[[ -n $branch ]] && line+=" ${MAGENTA}${BRANCH} ${branch}${RST}"

if ((ctx_size > 0)); then
    # Twenty segments, each 5 % of the context window; green below 50 %,
    # yellow below 80 %, red above.
    n=$(((ctx_used * 20 + ctx_size / 2) / ctx_size))
    ((n > 20)) && n=20
    pct=$((ctx_used * 100 / ctx_size))
    ((pct < 50)) && c=$GREEN || { ((pct < 80)) && c=$YELLOW || c=$RED; }
    bar=""
    for ((i = 0; i < 20; i++)); do ((i < n)) && bar+="▰" || bar+="▱"; done
    line+="${SEP}$(kilo "$ctx_used")/$(kilo "$ctx_size") ${c}${bar}${RST}"
fi

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
