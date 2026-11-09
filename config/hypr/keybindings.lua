-- █▄▀ █▀▀ █▄█ █▄▄ █ █▄░█ █▀▄ █ █▄░█ █▀▀ █▀
-- █░█ ██▄ ░█░ █▄█ █ █░▀█ █▄▀ █ █░▀█ █▄█ ▄█

--*  Variables
local mainMod = "SUPER" -- super / meta / windows key

-- Assign apps
local terminal = "kitty"
local EDITOR = "nvim"
local EXPLORER = "dolphin"
local BROWSER = "brave"

local srcPath = os.getenv("HOME") .. "/.local/lib/hyde"
-- TODO: $scrPath was never defined in this file in the original config (it's
-- presumably set in the sourced ~/.local/share/hyde/hyprland.conf). Assuming
-- it points at the same HyDE scripts directory as srcPath — confirm this.
local scrPath = os.getenv("HOME") .. "/.local/lib/hyde"

-- ===================== Window Management =====================
local d = "[Window Management]"

hl.bind("SUPER + Q", hl.dsp.window.close(), { description = d .. " close focused window " })
hl.bind("ALT + F4", hl.dsp.window.close(), { description = d .. " close focused window " })
hl.bind(mainMod .. " + Delete", hl.dsp.exit(), { description = d .. " kill hyprland session" })
hl.bind(mainMod .. " + W", hl.dsp.window.float({ action = "toggle" }), { description = d .. " Toggle floating" })
-- hl.bind(mainMod .. " + G", hl.dsp.group.toggle(), { description = d .. " toggle group" })
hl.bind("SHIFT + F11", hl.dsp.window.fullscreen(), { description = d .. " toggle fullscreen" })
hl.bind("SUPER + L", hl.dsp.exec_cmd("hyprlock"), { description = d .. " lock screen " })
-- hl.bind("SUPER + L", hl.dsp.exec_cmd("lockscreen"), { description = d .. " lock screen " })
hl.bind(
	mainMod .. " + SHIFT + F",
	hl.dsp.exec_cmd(scrPath .. "/windowpin.sh"),
	{ description = d .. " toggle pin on focused window" }
)
hl.bind("CONTROL + ALT + Delete", hl.dsp.exec_cmd(scrPath .. "/logoutlaunch.sh"), { description = d .. " logout menu" })
-- hl.bind("ALT_R + CONTROL_R", hl.dsp.exec_cmd("hyde-shell waybar --hide"), { description = d .. " toggle waybar and reload config" })
hl.bind("ALT_R + CONTROL_R", hl.dsp.exec_cmd("killall waybar || waybar"), { description = d .. " toggle waybar" }) -- toggle waybar without reloading, this is faster

-- ----- Group Navigation -----
local dGroupNav = d .. "[Group Navigation]"
-- changegroupactive b/f -> hl.dsp.group.prev() / hl.dsp.group.next() (no-arg dispatchers)
hl.bind(
	mainMod .. " + CONTROL + H",
	hl.dsp.group.prev(),
	{ description = dGroupNav .. " change active group backwards" }
)
hl.bind(
	mainMod .. " + CONTROL + L",
	hl.dsp.group.next(),
	{ description = dGroupNav .. " change active group forwards" }
)

-- ----- Change focus -----
local dFocus = d .. "[Change focus]"
hl.bind(mainMod .. " + Left", hl.dsp.focus({ direction = "l" }), { description = dFocus .. " focus left" })
hl.bind(mainMod .. " + Right", hl.dsp.focus({ direction = "r" }), { description = dFocus .. " focus right" })
hl.bind(mainMod .. " + Up", hl.dsp.focus({ direction = "u" }), { description = dFocus .. " focus up" })
hl.bind(mainMod .. " + Down", hl.dsp.focus({ direction = "d" }), { description = dFocus .. " focus down" })
hl.bind("ALT + Tab", hl.dsp.window.cycle_next(), { description = dFocus .. " Cycle focus" })

-- ----- Resize Active Window (mainMod + Shift + arrows) -----
local dResize = d .. "[Resize Active Window]"
-- TODO: keyboard (non-mouse) resizeactive-by-delta doesn't have a confirmed
-- dispatcher name in the docs I found; hl.dsp.window.resize({x=,y=}) is
-- inferred from the mouse-drag resize examples. Verify the param names.
--

hl.bind(
	mainMod .. " + SHIFT + right",
	hl.dsp.window.resize({ x = 30, y = 0, relative = true }),
	{ repeating = true, description = dResize .. " resize window right" }
)
hl.bind(
	mainMod .. " + SHIFT + left",
	hl.dsp.window.resize({ x = -30, y = 0, relative = true }),
	{ repeating = true, description = dResize .. " resize window left" }
)
hl.bind(
	mainMod .. " + SHIFT + up",
	hl.dsp.window.resize({ x = 0, y = -30, relative = true }),
	{ repeating = true, description = dResize .. " resize window up" }
)
hl.bind(
	mainMod .. " + SHIFT + down",
	hl.dsp.window.resize({ x = 0, y = 30, relative = true }),
	{ repeating = true, description = dResize .. " resize window down" }
)

-- ----- Move active window across workspace (mainMod + Shift + Control + arrows) -----
local dMoveActive = d .. "[Move active window across workspace]"
local moveActiveWindow =
	'grep -q "true" <<< $(hyprctl activewindow -j | jq -r .floating) && hyprctl dispatch moveactive'
hl.bind(
	mainMod .. " + SHIFT + CONTROL + Left",
	hl.dsp.exec_cmd(moveActiveWindow .. " -30 0 || hyprctl dispatch movewindow l"),
	{ repeating = true, description = "Move active window to the left" }
)
hl.bind(
	mainMod .. " + SHIFT + CONTROL + Right",
	hl.dsp.exec_cmd(moveActiveWindow .. " 30 0 || hyprctl dispatch movewindow r"),
	{ repeating = true, description = "Move active window to the right" }
)
hl.bind(
	mainMod .. " + SHIFT + CONTROL + Up",
	hl.dsp.exec_cmd(moveActiveWindow .. " 0 -30 || hyprctl dispatch movewindow u"),
	{ repeating = true, description = "Move active window up" }
)
hl.bind(
	mainMod .. " + SHIFT + CONTROL + Down",
	hl.dsp.exec_cmd(moveActiveWindow .. " 0 30 || hyprctl dispatch movewindow d"),
	{ repeating = true, description = "Move active window down" }
)

-- ----- Move/Resize focused window with mouse -----
local dMouse = d .. "[Move & Resize with mouse]"
hl.bind(
	mainMod .. " + mouse:272",
	hl.dsp.window.drag(),
	{ mouse = true, description = dMouse .. " hold to move window" }
)
hl.bind(
	mainMod .. " + mouse:273",
	hl.dsp.window.resize(),
	{ mouse = true, description = dMouse .. " hold to resize window" }
)
-- NOTE: the original config also bound plain "Z" and "X" (not mouse buttons)
-- to the same mouse-drag dispatchers via the "m" (mouse) bind flag — this is
-- carried over as-is, though Z below collides with the "zotero" launcher
-- bind further down (that collision exists in the source config too).
hl.bind(mainMod .. " + Z", hl.dsp.window.drag(), { mouse = true, description = dMouse .. " hold to move window" })
hl.bind(mainMod .. " + X", hl.dsp.window.resize(), { mouse = true, description = dMouse .. " hold to resize window" })

-- ----- Toggle focused window split -----
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"), { description = d .. " toggle split" })

-- ===================== Launcher =====================
local dLauncher = "[Launcher][Apps]"
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd("prime-run kitty"), { description = dLauncher .. " terminal emulator" })
-- hl.bind(mainMod .. " + ALT + T", hl.dsp.exec_cmd("hyde-shell pypr toggle console"), { description = dLauncher .. " dropdown terminal" })
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(EXPLORER), { description = dLauncher .. " file explorer" })
-- hl.bind(mainMod .. " + C", hl.dsp.exec_cmd(EDITOR), { description = dLauncher .. " text editor" })
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("prime-run " .. BROWSER), { description = dLauncher .. " web browser" })
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd("obsidian"), { description = dLauncher .. " obsidian" })
hl.bind(mainMod .. " + Z", hl.dsp.exec_cmd("zotero"), { description = dLauncher .. " zotero" })
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd("amberol"), { description = dLauncher .. " amberol" })
hl.bind(
	"CONTROL + SHIFT + Escape",
	hl.dsp.exec_cmd(scrPath .. "/sysmonlaunch.sh"),
	{ description = dLauncher .. " system monitor" }
)
hl.bind(mainMod .. " + SHIFT + END", hl.dsp.exec_cmd("shutdown now"), { description = dLauncher .. " shutdown" })
hl.bind(mainMod .. " + SHIFT + BACKSPACE", hl.dsp.exec_cmd("shutdown -r now"), { description = dLauncher .. " reboot" })

-- ----- Rofi menus -----
local dRofi = "[Launcher][Rofi menus]"
local rofiLaunch = scrPath .. "/rofilaunch.sh"
hl.bind(
	mainMod .. " + Space",
	hl.dsp.exec_cmd("pkill -x rofi || " .. rofiLaunch .. " d"),
	{ description = dRofi .. " application finder" }
)
hl.bind(
	mainMod .. " + TAB",
	hl.dsp.exec_cmd("pkill -x rofi || " .. rofiLaunch .. " w"),
	{ description = dRofi .. " window switcher" }
)
hl.bind(
	mainMod .. " + SHIFT + E",
	hl.dsp.exec_cmd("pkill -x rofi || " .. rofiLaunch .. " f"),
	{ description = dRofi .. " file finder" }
)
hl.bind(
	mainMod .. " + slash",
	-- hl.dsp.exec_cmd("hyde-shell keybinds_hint"),
	-- hl.dsp.exec_cmd(hyde.sh.keybinds_hint()),
	hl.dsp.exec_cmd(scrPath .. "/keybinds_hint.sh"),

	-- hl.dsp.exec_cmd(scrPath .. "/keybinds_hint.sh"),
	{ description = dRofi .. " keybindings hint" }
) -- launch keybinds hint
hl.bind(
	mainMod .. " + comma",
	hl.dsp.exec_cmd(scrPath .. "/emoji-picker.sh"),
	-- hl.dsp.exec_cmd("pkill -x rofi || " .. scrPath .. "/emoji-picker.sh"),
	{ description = dRofi .. " emoji picker" }
) -- launch emoji picker
hl.bind(
	mainMod .. " + period",
	hl.dsp.exec_cmd("pkill -x rofi || " .. scrPath .. "/glyph-picker.sh"),
	{ description = dRofi .. " glyph picker" }
) -- launch glyph picker
hl.bind(
	mainMod .. " + V",
	hl.dsp.exec_cmd("pkill -x rofi || " .. scrPath .. "/cliphist.sh -c"),
	{ description = dRofi .. " clipboard" }
) -- launch clipboard
-- hl.bind(mainMod .. " + SHIFT + V", hl.dsp.exec_cmd("pkill -x rofi || " .. scrPath .. "/cliphist.sh"), { description = dRofi .. " clipboard manager" })
-- hl.bind(mainMod .. " + SHIFT + A", hl.dsp.exec_cmd("pkill -x rofi || " .. scrPath .. "/rofiselect.sh"), { description = dRofi .. " select rofi launcher" })

-- ===================== Hardware Controls =====================
-- Audio
local dAudio = "[Hardware Controls][Audio]"
-- Change volumecontrol.sh: isVolumeBoost="${VOLUME_BOOST:-true}" to increase to 150% audio
-- Find volumecontrol.sh in ~/.local/lib/hyde ("which volumecontrol.sh")
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd(scrPath .. "/volumecontrol.sh -o m"),
	{ locked = true, description = dAudio .. " toggle mute output" }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd(scrPath .. "/volumecontrol.sh -i m"),
	{ locked = true, description = dAudio .. " un/mute microphone" }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd(scrPath .. "/volumecontrol.sh -o d 2 q"),
	{ locked = true, repeating = true, description = dAudio .. " decrease volume" }
)
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd(scrPath .. "/volumecontrol.sh -o i 2 q"),
	{ locked = true, repeating = true, description = dAudio .. " increase volume" }
)

-- Media
local dMedia = "[Hardware Controls][Media]"
hl.bind(
	"XF86AudioPlay",
	hl.dsp.exec_cmd("playerctl play-pause"),
	{ locked = true, description = dMedia .. " play media" }
)
hl.bind(
	"XF86AudioPause",
	hl.dsp.exec_cmd("playerctl play-pause"),
	{ locked = true, description = dMedia .. " pause media" }
)
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true, description = dMedia .. " next media" })
hl.bind(
	"XF86AudioPrev",
	hl.dsp.exec_cmd("playerctl previous"),
	{ locked = true, description = dMedia .. " previous media" }
)

-- Brightness
local dBrightness = "[Hardware Controls][Brightness]"
hl.bind(
	"XF86MonBrightnessUp",
	hl.dsp.exec_cmd(scrPath .. "/brightnesscontrol.sh i"),
	{ locked = true, repeating = true, description = dBrightness .. " increase brightness" }
)
hl.bind(
	"XF86MonBrightnessDown",
	hl.dsp.exec_cmd(scrPath .. "/brightnesscontrol.sh d"),
	{ locked = true, repeating = true, description = dBrightness .. " decrease brightness" }
)

-- ===================== Utilities =====================
local dUtil = "[Utilities]"
hl.bind(
	mainMod .. " + K",
	hl.dsp.exec_cmd(scrPath .. "/keyboardswitch.sh"),
	{ locked = true, description = dUtil .. " toggle keyboard layout" }
) -- switch keyboard layout
-- hl.bind(mainMod .. " + ALT + G", hl.dsp.exec_cmd(scrPath .. "/gamemode.sh"), { description = dUtil .. " game mode" })
-- hl.bind(mainMod .. " + SHIFT + G", hl.dsp.exec_cmd(scrPath .. "/gamelauncher.sh"), { description = dUtil .. " open game launcher" })

-- Screen Capture
local dCapture = "[Utilities][Screen Capture]"
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd("hyprpicker -an"), { description = dCapture .. " color picker" }) -- Pick color (Hex) >> clipboard
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd(scrPath .. "/screenshot.sh s"), { description = dCapture .. " snip screen" }) -- partial screenshot capture
hl.bind(
	mainMod .. " + CONTROL + P",
	hl.dsp.exec_cmd(scrPath .. "/screenshot.sh sf"),
	{ description = dCapture .. " freeze and snip screen" }
) -- partial screenshot capture (frozen screen)
hl.bind(
	mainMod .. " + ALT + P",
	hl.dsp.exec_cmd(scrPath .. "/screenshot.sh m"),
	{ locked = true, description = dCapture .. " print monitor" }
) -- monitor screenshot capture
hl.bind(
	"Print",
	hl.dsp.exec_cmd(scrPath .. "/screenshot.sh p"),
	{ locked = true, description = dCapture .. " print all monitors" }
) -- all monitors screenshot capture

-- ===================== Theming and Wallpaper =====================
-- TODO Make a main rofi menu for these selectors
local dRice = "[Theming and Wallpaper]"
hl.bind(
	mainMod .. " + ALT + Right",
	hl.dsp.exec_cmd(scrPath .. "/wallpaper.sh -Gn"),
	{ description = dRice .. " next global wallpaper" }
)
hl.bind(
	mainMod .. " + ALT + Left",
	hl.dsp.exec_cmd(scrPath .. "/wallpaper.sh -Gp"),
	{ description = dRice .. " previous global wallpaper" }
)
hl.bind(
	mainMod .. " + SHIFT + W",
	hl.dsp.exec_cmd("pkill -x rofi || " .. scrPath .. "/wallpaper.sh -SG"),
	{ description = dRice .. " select a global wallpaper" }
) -- launch wallpaper select menu
-- hl.bind(mainMod .. " + ALT + Up", hl.dsp.exec_cmd(scrPath .. "/wbarconfgen.sh n"), { description = dRice .. " next waybar layout" })
-- hl.bind(mainMod .. " + ALT + Down", hl.dsp.exec_cmd(scrPath .. "/wbarconfgen.sh p"), { description = dRice .. " previous waybar layout" })
-- hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("pkill -x rofi || " .. scrPath .. "/wallbashtoggle.sh -m"), { description = dRice .. " wallbash mode selector" })
hl.bind(
	mainMod .. " + SHIFT + T",
	hl.dsp.exec_cmd("pkill -x rofi || " .. scrPath .. "/themeselect.sh"),
	{ description = dRice .. " select a theme" }
) -- launch theme select menu
-- hl.bind(mainMod .. " + SHIFT + Y", hl.dsp.exec_cmd("pkill -x rofi || " .. scrPath .. "/animations.sh --select"), { description = dRice .. " select animations" })
-- hl.bind(mainMod .. " + SHIFT + U", hl.dsp.exec_cmd("pkill -x rofi || " .. scrPath .. "/hyprlock.sh --select"), { description = dRice .. " select hyprlock layout" })

-- ===================== Workspaces =====================
-- Navigation (1-9, 0 -> workspace 10)
local dWsNav = "[Workspaces][Navigation]"
for i = 1, 9 do
	hl.bind(
		mainMod .. " + " .. i,
		hl.dsp.focus({ workspace = i }),
		{ description = dWsNav .. " navigate to workspace " .. i }
	)
end
hl.bind(mainMod .. " + 0", hl.dsp.focus({ workspace = 10 }), { description = dWsNav .. " navigate to workspace 10" })

-- Relative workspace
local dWsRel = "[Workspaces][Navigation][Relative workspace]"
hl.bind(
	mainMod .. " + CONTROL + Right",
	hl.dsp.focus({ workspace = "r+1" }),
	{ description = dWsRel .. " change active workspace forwards" }
)
hl.bind(
	mainMod .. " + CONTROL + Left",
	hl.dsp.focus({ workspace = "r-1" }),
	{ description = dWsRel .. " change active workspace backwards" }
)

hl.bind(
	mainMod .. " + CONTROL + Down",
	hl.dsp.focus({ workspace = "empty" }),
	{ description = dWsNav .. " navigate to the nearest empty workspace" }
)

-- Move focused window to a workspace
local dWsMove = "[Workspaces][Move window to workspace]"
for i = 1, 9 do
	hl.bind(
		mainMod .. " + SHIFT + " .. i,
		hl.dsp.window.move({ workspace = i }),
		{ description = dWsMove .. " move to workspace " .. i }
	)
end
hl.bind(
	mainMod .. " + SHIFT + 0",
	hl.dsp.window.move({ workspace = 10 }),
	{ description = dWsMove .. " move to workspace 10" }
)

-- Move focused window to a relative workspace
hl.bind(
	mainMod .. " + CONTROL + ALT + Right",
	hl.dsp.window.move({ workspace = "r+1" }),
	{ description = "[Workspaces] move window to next relative workspace" }
)
hl.bind(
	mainMod .. " + CONTROL + ALT + Left",
	hl.dsp.window.move({ workspace = "r-1" }),
	{ description = "[Workspaces] move window to previous relative workspace" }
)

-- Scroll through existing workspaces
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }), { description = dWsNav .. " next workspace" })
hl.bind(
	mainMod .. " + mouse_up",
	hl.dsp.focus({ workspace = "e-1" }),
	{ description = dWsNav .. " previous workspace" }
)

-- Move/Switch to special workspace (scratchpad)
-- hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special" }), { description = "[Workspaces][Navigation][Special workspace] move to scratchpad" })
-- hl.bind(mainMod .. " + ALT + S", hl.dsp.window.move({ workspace = "special", silent = true }), { description = "[Workspaces][Navigation][Special workspace] move to scratchpad (silent)" })
-- hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special(), { description = "[Workspaces][Navigation][Special workspace] toggle scratchpad" })

-- Move focused window to a workspace silently
-- TODO: `silent = true` on hl.dsp.window.move is inferred (mirrors the old
-- "movetoworkspacesilent" dispatcher) — verify the actual param name.
local dWsSilent = "[Workspaces][Navigation][Move window silently]"
for i = 1, 9 do
	hl.bind(
		mainMod .. " + ALT + " .. i,
		hl.dsp.window.move({ workspace = i, silent = true }),
		{ description = dWsSilent .. " move to workspace " .. i .. " (silent)" }
	)
end
hl.bind(
	mainMod .. " + ALT + 0",
	hl.dsp.window.move({ workspace = 10, silent = true }),
	{ description = dWsSilent .. " move to workspace 10 (silent)" }
)
