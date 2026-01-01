local awful = require("awful")
local beautiful = require("beautiful")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")

return function(opts)
    local terminal = opts.terminal
    local browser = opts.browser
    local editor_cmd = opts.editor_cmd

    local myawesomemenu = {
        {
            "hotkeys",
            function()
                hotkeys_popup.show_help(nil, awful.screen.focused())
            end,
        },
        { "manual", terminal .. " -e man awesome" },
        { "edit config", editor_cmd .. " " .. awesome.conffile },
        { "restart", awesome.restart },
        {
            "quit",
            function()
                awesome.quit()
            end,
        },
    }

    local mymainmenu = awful.menu({
        items = {
            { "awesome", myawesomemenu, beautiful.awesome_icon },
            { "open terminal", terminal },
            { "open browser", browser },
        },
    })

    local mylauncher = awful.widget.launcher({
        image = beautiful.awesome_icon,
        menu = mymainmenu,
    })

    menubar.utils.terminal = terminal

    return {
        mainmenu = mymainmenu,
        launcher = mylauncher,
    }
end
