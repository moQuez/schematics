-- Optional LuaRocks loader (keeps luarocks-managed libs discoverable).
pcall(require, "luarocks.loader")

local awful = require("awful")
require("awful.autofocus")
local beautiful = require("beautiful")

local globals = {
	awesome = rawget(_G, "awesome"),
	client = rawget(_G, "client"),
	root = rawget(_G, "root"),
	screen = rawget(_G, "screen"),
}

-- Enable hotkeys help widget for VIM and other apps.
require("awful.hotkeys_popup.keys")

-- Error notifications early so module errors are visible.
require("config.error")({ awesome = globals.awesome })

-- Centralized defaults (terminal, modkey, layouts, etc).
local vars = require("config.vars")

-- Theme must be initialized before widgets and wibar setup.
beautiful.init("~/.config/awesome/themes/default/theme.lua")

-- Register layouts globally for tag creation.
awful.layout.layouts = vars.layouts

-- Menus and widgets.
local menu = require("config.menu")({
	awesome = globals.awesome,
	terminal = vars.terminal,
	browser = vars.browser,
	editor_cmd = vars.editor_cmd,
})
local battery = require("config.widgets.battery")({
	warn_level = vars.battery_warn_level,
	critical_level = vars.battery_critical_level,
	screen = globals.screen,
})
local volume = require("config.widgets.volume")()
local power = require("config.power")()

-- Screen setup (tags, wallpaper, wibar, widgets).
require("config.wibar")({
	modkey = vars.modkey,
	battery_widget = battery.widget,
	volume_widget = volume.widget,
	tags = vars.tags,
	client = globals.client,
	screen = globals.screen,
})

-- Global and client keybindings (plus mouse bindings).
local bindings = require("config.bindings")({
	modkey = vars.modkey,
	terminal = vars.terminal,
	menu = menu.mainmenu,
	update_volume = volume.update,
	show_power_menu = power.show,
	awesome = globals.awesome,
	client = globals.client,
	root = globals.root,
})

-- Client rules depend on key/button bindings.
require("config.rules")({
	clientkeys = bindings.clientkeys,
	clientbuttons = bindings.clientbuttons,
})

-- Runtime signals and startup commands.
require("config.signals")({
	awesome = globals.awesome,
	client = globals.client,
})
require("config.autostart")({ awesome = globals.awesome })
