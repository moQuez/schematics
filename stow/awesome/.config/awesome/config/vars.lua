local awful = require("awful")

local M = {}

M.terminal = "wezterm"
M.browser = "firefox"
M.editor = os.getenv("EDITOR") or "nano"
M.editor_cmd = M.terminal .. " -e " .. M.editor

M.modkey = "Mod4"

M.battery_warn_level = 20
M.battery_critical_level = 10

M.tags = { "term", "web", "ai", "4", "5", "6", "7", "8", "9" }

M.layouts = {
    awful.layout.suit.tile,
}

return M
