local awful = require("awful")
local gears = require("gears")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")

return function(opts)
    local modkey = opts.modkey
    local terminal = opts.terminal
    local menu = opts.menu
    local update_volume = opts.update_volume
    local show_power_menu = opts.show_power_menu

    root.buttons(gears.table.join(
        awful.button({}, 3, function()
            menu:toggle()
        end),
        awful.button({}, 4, awful.tag.viewnext),
        awful.button({}, 5, awful.tag.viewprev)
    ))

    local globalkeys = gears.table.join(
        awful.key({ modkey }, "s", hotkeys_popup.show_help, { description = "show help", group = "awesome" }),
        awful.key({ modkey }, "Left", awful.tag.viewprev, { description = "view previous", group = "tag" }),
        awful.key({ modkey }, "Right", awful.tag.viewnext, { description = "view next", group = "tag" }),
        awful.key({ modkey }, "Escape", awful.tag.history.restore, { description = "go back", group = "tag" }),

        awful.key({ modkey }, "j", function()
            awful.client.focus.byidx(1)
        end, { description = "focus next by index", group = "client" }),
        awful.key({ modkey }, "k", function()
            awful.client.focus.byidx(-1)
        end, { description = "focus previous by index", group = "client" }),
        awful.key({ modkey }, "w", function()
            menu:show()
        end, { description = "show main menu", group = "awesome" }),

        -- Brightness keys
        awful.key({}, "XF86MonBrightnessDown", function()
            awful.spawn("brightnessctl set 10%-")
        end, { description = "decrease brightness", group = "custom" }),

        awful.key({}, "XF86MonBrightnessUp", function()
            awful.spawn("brightnessctl set +10%")
        end, { description = "increase brightness", group = "custom" }),

        -- Keyboard backlight keys
        awful.key({}, "XF86KbdBrightnessDown", function()
            awful.spawn("brightnessctl -d smc::kbd_backlight set 10%-")
        end, { description = "decrease keyboard backlight", group = "custom" }),

        awful.key({}, "XF86KbdBrightnessUp", function()
            awful.spawn("brightnessctl -d smc::kbd_backlight set +10%")
        end, { description = "increase keyboard backlight", group = "custom" }),

        -- Volume control keys
        awful.key({}, "XF86AudioLowerVolume", function()
            awful.spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%")
            update_volume()
        end, { description = "lower volume", group = "media" }),

        awful.key({}, "XF86AudioRaiseVolume", function()
            awful.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%")
            update_volume()
        end, { description = "raise volume", group = "media" }),

        awful.key({}, "XF86AudioMute", function()
            awful.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle")
            update_volume()
        end, { description = "mute/unmute volume", group = "media" }),

        -- Media keys
        awful.key({}, "XF86AudioPlay", function()
            awful.spawn("playerctl play-pause", false)
        end, { description = "play/pause media", group = "media" }),

        awful.key({}, "XF86AudioNext", function()
            awful.spawn("playerctl next", false)
        end, { description = "next media track", group = "media" }),

        awful.key({}, "XF86AudioPrev", function()
            awful.spawn("playerctl previous", false)
        end, { description = "previous media track", group = "media" }),

        -- Power menu keybinding
        awful.key({}, "XF86PowerOff", function()
            show_power_menu()
        end, { description = "power menu", group = "system" }),
        awful.key({}, "XF86Eject", function()
            show_power_menu()
        end, { description = "power menu (eject key)", group = "system" }),

        -- Layout manipulation
        awful.key({ modkey, "Shift" }, "j", function()
            awful.client.swap.byidx(1)
        end, { description = "swap with next client by index", group = "client" }),
        awful.key({ modkey, "Shift" }, "k", function()
            awful.client.swap.byidx(-1)
        end, { description = "swap with previous client by index", group = "client" }),
        awful.key({ modkey, "Control" }, "j", function()
            awful.screen.focus_relative(1)
        end, { description = "focus the next screen", group = "screen" }),
        awful.key({ modkey, "Control" }, "k", function()
            awful.screen.focus_relative(-1)
        end, { description = "focus the previous screen", group = "screen" }),
        awful.key({ modkey }, "u", awful.client.urgent.jumpto, { description = "jump to urgent client", group = "client" }),
        awful.key({ modkey }, "Tab", function()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end, { description = "go back", group = "client" }),

        -- Standard program
        awful.key({ modkey }, "Return", function()
            awful.spawn(terminal)
        end, { description = "open a terminal", group = "launcher" }),
        awful.key({ modkey, "Control" }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),
        awful.key({ modkey, "Shift" }, "q", awesome.quit, { description = "quit awesome", group = "awesome" }),
        awful.key({ modkey }, "l", function()
            awful.tag.incmwfact(0.05)
        end, { description = "increase master width factor", group = "layout" }),
        awful.key({ modkey }, "h", function()
            awful.tag.incmwfact(-0.05)
        end, { description = "decrease master width factor", group = "layout" }),
        awful.key({ modkey, "Shift" }, "h", function()
            awful.tag.incnmaster(1, nil, true)
        end, { description = "increase the number of master clients", group = "layout" }),
        awful.key({ modkey, "Shift" }, "l", function()
            awful.tag.incnmaster(-1, nil, true)
        end, { description = "decrease the number of master clients", group = "layout" }),
        awful.key({ modkey, "Control" }, "h", function()
            awful.tag.incncol(1, nil, true)
        end, { description = "increase the number of columns", group = "layout" }),
        awful.key({ modkey, "Control" }, "l", function()
            awful.tag.incncol(-1, nil, true)
        end, { description = "decrease the number of columns", group = "layout" }),
        awful.key({ modkey }, "space", function()
            awful.layout.inc(1)
        end, { description = "select next", group = "layout" }),
        awful.key({ modkey, "Shift" }, "space", function()
            awful.layout.inc(-1)
        end, { description = "select previous", group = "layout" }),

        awful.key({ modkey, "Control" }, "n", function()
            local c = awful.client.restore()
            if c then
                c:emit_signal("request::activate", "key.unminimize", { raise = true })
            end
        end, { description = "restore minimized", group = "client" }),

        -- Prompt
        awful.key({ modkey }, "r", function()
            awful.screen.focused().mypromptbox:run()
        end, { description = "run prompt", group = "launcher" }),

        awful.key({ modkey }, "x", function()
            awful.prompt.run({
                prompt = "Run Lua code: ",
                textbox = awful.screen.focused().mypromptbox.widget,
                exe_callback = awful.util.eval,
                history_path = awful.util.get_cache_dir() .. "/history_eval",
            })
        end, { description = "lua execute prompt", group = "awesome" }),
        -- Menubar
        awful.key({ modkey }, "p", function()
            menubar.show()
        end, { description = "show the menubar", group = "launcher" })
    )

    local clientkeys = gears.table.join(
        awful.key({ modkey }, "f", function(c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end, { description = "toggle fullscreen", group = "client" }),
        awful.key({ modkey, "Shift" }, "c", function(c)
            c:kill()
        end, { description = "close", group = "client" }),
        awful.key(
            { modkey, "Control" },
            "space",
            awful.client.floating.toggle,
            { description = "toggle floating", group = "client" }
        ),
        awful.key({ modkey, "Control" }, "Return", function(c)
            c:swap(awful.client.getmaster())
        end, { description = "move to master", group = "client" }),
        awful.key({ modkey }, "o", function(c)
            c:move_to_screen()
        end, { description = "move to screen", group = "client" }),
        awful.key({ modkey }, "t", function(c)
            c.ontop = not c.ontop
        end, { description = "toggle keep on top", group = "client" }),
        awful.key({ modkey }, "n", function(c)
            c.minimized = true
        end, { description = "minimize", group = "client" }),
        awful.key({ modkey }, "m", function(c)
            c.maximized = not c.maximized
            c:raise()
        end, { description = "(un)maximize", group = "client" }),
        awful.key({ modkey, "Control" }, "m", function(c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end, { description = "(un)maximize vertically", group = "client" }),
        awful.key({ modkey, "Shift" }, "m", function(c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end, { description = "(un)maximize horizontally", group = "client" })
    )

    for i = 1, 9 do
        globalkeys = gears.table.join(
            globalkeys,
            awful.key({ modkey }, "#" .. i + 9, function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    tag:view_only()
                end
            end, { description = "view tag #" .. i, group = "tag" }),
            awful.key({ modkey, "Control" }, "#" .. i + 9, function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    awful.tag.viewtoggle(tag)
                end
            end, { description = "toggle tag #" .. i, group = "tag" }),
            awful.key({ modkey, "Shift" }, "#" .. i + 9, function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:move_to_tag(tag)
                    end
                end
            end, { description = "move focused client to tag #" .. i, group = "tag" }),
            awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9, function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:toggle_tag(tag)
                    end
                end
            end, { description = "toggle focused client on tag #" .. i, group = "tag" })
        )
    end

    local clientbuttons = gears.table.join(
        awful.button({}, 1, function(c)
            c:emit_signal("request::activate", "mouse_click", { raise = true })
        end),
        awful.button({ modkey }, 1, function(c)
            c:emit_signal("request::activate", "mouse_click", { raise = true })
            awful.mouse.client.move(c)
        end),
        awful.button({ modkey }, 3, function(c)
            c:emit_signal("request::activate", "mouse_click", { raise = true })
            awful.mouse.client.resize(c)
        end)
    )

    root.keys(globalkeys)

    return {
        clientkeys = clientkeys,
        clientbuttons = clientbuttons,
    }
end
