local awful = require("awful")

if awesome.startup then
    awful.spawn.once("xrdb -merge ~/.Xresources")
    awful.spawn.once(os.getenv("HOME") .. "/.local/bin/autorandr-select")
    awful.spawn.once("picom")
    awful.spawn.once("xscreensaver -no-splash")
    awful.spawn.once("xss-lock -- xscreensaver-command -lock")
end
