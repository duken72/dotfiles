-- █░█░█ █ █▄░█ █▀▄ █▀█ █░█░█   █▀█ █░█ █░░ █▀▀ █▀
-- ▀▄▀▄▀ █ █░▀█ █▄▀ █▄█ ▀▄▀▄▀   █▀▄ █▄█ █▄▄ ██▄ ▄█

-- See https://wiki.hypr.land/Configuring/Window-Rules/

--? ------- WINDOWRULES_HYPRLAND_V_0_53 COMPATIBLE ----------------
--   This Config is compatible with windowrules changes in Hyprland v0.53+
--   Any future breaking changes disables this block and notifies the user to update.
--   User template files will be provided in $XDG_DATA_HOME/hyde/templates/hypr/windowrules.conf for manual update.

-- TODO: `# hyprlang if VAR` maps to a native Lua `if` over a bare-truthy check.
-- WINDOWRULES_HYPRLAND_V_0_53 isn't defined anywhere in these files, so it was
-- presumably an env var set elsewhere by HyDE. Verify/replace as needed.
if os.getenv("WINDOWRULES_HYPRLAND_V_0_53") then

    -- idle_inhibit rules
    -- TODO: the original hyprlang lines carried a trailing "true" after the
    -- idle_inhibit mode (e.g. "idle_inhibit fullscreen true") whose role is
    -- unclear under the new syntax (idle_inhibit only takes a mode string:
    -- none/always/focus/fullscreen). Dropped here — double check against
    -- `hl.window_rule` docs once installed.
    hl.window_rule({
        match = { class = "^(.*celluloid.*)$|^(.*mpv.*)$|^(.*vlc.*)$" },
        idle_inhibit = "fullscreen",
    })
    hl.window_rule({
        match = { class = "^(.*[Ss]potify.*)$" },
        idle_inhibit = "fullscreen",
    })
    hl.window_rule({
        match = { class = "^(.*LibreWolf.*)$|^(.*floorp.*)$|^(.*brave-browser.*)$|^(.*firefox.*)$|^(.*chromium.*)$|^(.*zen.*)$|^(.*vivaldi.*)$" },
        idle_inhibit = "fullscreen",
    })

    -- Picture-in-Picture
    hl.window_rule({
        name = "hyde_picture_in_picture",
        match = { title = "^([Pp]icture[-\\s]?[Ii]n[-\\s]?[Pp]icture)(.*)$" },
        tag = { "+picture-in-picture", "+hyde_picture_in_picture" },
        float = true,
        keep_aspect_ratio = true,
        move = "(monitor_w*0.73) (monitor_h*0.72)",
        size = "(monitor_w*0.25) (monitor_h*0.25)",
        pin = true,
    })

    -- Opacity: active/inactive/fullscreen ("$&" in the old syntax meant
    -- "repeat the previous value", resolved here to its literal number)
    local opacityRules3 = {
        {
            opacity = "0.90 0.90 1",
            classes = { "^(firefox)$", "^(brave-browser)$" },
        },
        {
            opacity = "0.80 0.80 1",
            classes = {
                "^(code-oss)$", "^([Cc]ode)$", "^(code-url-handler)$",
                "^(code-insiders-url-handler)$", "^(kitty)$", "^(org.kde.dolphin)$",
                "^(org.kde.ark)$", "^(nwg-look)$", "^(qt5ct)$", "^(qt6ct)$",
                "^(kvantummanager)$",
            },
        },
        {
            opacity = "0.80 0.70 1",
            classes = {
                "^(org.pulseaudio.pavucontrol)$", "^(blueman-manager)$", "^(nm-applet)$",
                "^(nm-connection-editor)$", "^(org.kde.polkit-kde-authentication-agent-1)$",
                "^(polkit-gnome-authentication-agent-1)$",
                "^(org.freedesktop.impl.portal.desktop.gtk)$",
                "^(org.freedesktop.impl.portal.desktop.hyprland)$",
            },
        },
        {
            opacity = "0.70 0.70 1",
            classes = { "^([Ss]team)$", "^(steamwebhelper)$", "^([Ss]potify)$" },
        },
    }
    for _, group in ipairs(opacityRules3) do
        for _, cls in ipairs(group.classes) do
            hl.window_rule({ match = { class = cls }, opacity = group.opacity })
        end
    end
    for _, title in ipairs({ "^(Spotify Free)$", "^(Spotify Premium)$" }) do
        hl.window_rule({ match = { initial_title = title }, opacity = "0.70 0.70 1" })
    end

    -- Opacity: active/inactive only, per app
    local opacityRules2 = {
        { class = "^(com.github.rafostar.Clapper)$",            opacity = "0.90 0.90" }, -- Clapper-Gtk
        { class = "^(com.github.tchx84.Flatseal)$",             opacity = "0.80 0.80" }, -- Flatseal-Gtk
        { class = "^(hu.kramo.Cartridges)$",                    opacity = "0.80 0.80" }, -- Cartridges-Gtk
        { class = "^(com.obsproject.Studio)$",                  opacity = "0.80 0.80" }, -- Obs-Qt
        { class = "^(gnome-boxes)$",                            opacity = "0.80 0.80" }, -- Boxes-Gtk
        { class = "^(vesktop)$",                                opacity = "0.80 0.80" }, -- Vesktop
        { class = "^(discord)$",                                opacity = "0.80 0.80" }, -- Discord-Electron
        { class = "^(WebCord)$",                                opacity = "0.80 0.80" }, -- WebCord-Electron
        { class = "^(ArmCord)$",                                opacity = "0.80 0.80" }, -- ArmCord-Electron
        { class = "^(app.drey.Warp)$",                          opacity = "0.80 0.80" }, -- Warp-Gtk
        { class = "^(net.davidotek.pupgui2)$",                  opacity = "0.80 0.80" }, -- ProtonUp-Qt
        { class = "^(yad)$",                                    opacity = "0.80 0.80" }, -- Protontricks-Gtk
        { class = "^(Signal)$",                                 opacity = "0.80 0.80" }, -- Signal-Gtk
        { class = "^(io.github.alainm23.planify)$",             opacity = "0.80 0.80" }, -- planify-Gtk
        { class = "^(io.gitlab.theevilskeleton.Upscaler)$",     opacity = "0.80 0.80" }, -- Upscaler-Gtk
        { class = "^(com.github.unrud.VideoDownloader)$",       opacity = "0.80 0.80" }, -- VideoDownloader-Gtk
        { class = "^(io.gitlab.adhami3310.Impression)$",        opacity = "0.80 0.80" }, -- Impression-Gtk
        { class = "^(io.missioncenter.MissionCenter)$",         opacity = "0.80 0.80" }, -- MissionCenter-Gtk
        { class = "^(io.github.flattool.Warehouse)$",           opacity = "0.80 0.80" }, -- Warehouse-Gtk
    }
    for _, r in ipairs(opacityRules2) do
        hl.window_rule({ match = { class = r.class }, opacity = r.opacity })
    end

    -- Float rules
    local floatClasses = {
        "^(Signal)$",                                   -- Signal-Gtk
        "^(com.github.rafostar.Clapper)$",              -- Clapper-Gtk
        "^(app.drey.Warp)$",                            -- Warp-Gtk
        "^(net.davidotek.pupgui2)$",                    -- ProtonUp-Qt
        "^(yad)$",                                      -- Protontricks-Gtk
        "^(eog)$",                                      -- Imageviewer-Gtk
        "^(io.github.alainm23.planify)$",               -- planify-Gtk
        "^(io.gitlab.theevilskeleton.Upscaler)$",       -- Upscaler-Gtk
        "^(com.github.unrud.VideoDownloader)$",         -- VideoDownloader-Gtk
        "^(io.gitlab.adhami3310.Impression)$",          -- Impression-Gtk
        "^(io.missioncenter.MissionCenter)$",           -- MissionCenter-Gtk
    }
    for _, cls in ipairs(floatClasses) do
        hl.window_rule({ match = { class = cls }, float = true })
    end

    -- workaround for jetbrains IDEs dropdowns/popups cause flickering
    hl.window_rule({
        match = { class = "^(.*jetbrains.*)$", title = "^(win[0-9]+)$" },
        no_initial_focus = true,
    })

end
-- hyprlang endif

-- █░░ ▄▀█ █▄█ █▀▀ █▀█   █▀█ █░█ █░░ █▀▀ █▀
-- █▄▄ █▀█ ░█░ ██▄ █▀▄   █▀▄ █▄█ █▄▄ ██▄ ▄█

local layerRules = {
    { namespace = "rofi",                        blur = true, ignore_alpha = 0 },
    { namespace = "notifications",                blur = true, ignore_alpha = 0 },
    { namespace = "swaync-notification-window",   blur = true, ignore_alpha = 0 },
    { namespace = "swaync-control-center",        blur = true, ignore_alpha = 0 },
    { namespace = "logout_dialog",                blur = true },
}
for _, r in ipairs(layerRules) do
    hl.layer_rule({
        match = { namespace = r.namespace },
        blur = r.blur,
        ignore_alpha = r.ignore_alpha,
    })
end
