-- Optional LuaRocks loader (keeps luarocks-managed libs discoverable).
pcall(require, "luarocks.loader")

local awful = require("awful")
require("awful.autofocus")
local beautiful = require("beautiful")

-- Enable hotkeys help widget for VIM and other apps.
require("awful.hotkeys_popup.keys")

-- Error notifications early so module errors are visible.
require("config.error")

-- Centralized defaults (terminal, modkey, layouts, etc).
local vars = require("config.vars")

-- Theme must be initialized before widgets and wibar setup.
beautiful.init("~/.config/awesome/themes/default/theme.lua")

-- Register layouts globally for tag creation.
awful.layout.layouts = vars.layouts

-- Menus and widgets.
local menu = require("config.menu")(vars)
local battery = require("config.widgets.battery")({
	warn_level = vars.battery_warn_level,
	critical_level = vars.battery_critical_level,
})
local volume = require("config.widgets.volume")()
local power = require("config.power")()

-- Screen setup (tags, wallpaper, wibar, widgets).
require("config.wibar")({
	modkey = vars.modkey,
	launcher = menu.launcher,
	battery_widget = battery.widget,
	volume_widget = volume.widget,
	tags = vars.tags,
})

-- Global and client keybindings (plus mouse bindings).
local bindings = require("config.bindings")({
	modkey = vars.modkey,
	terminal = vars.terminal,
	menu = menu.mainmenu,
	update_volume = volume.update,
	show_power_menu = power.show,
})

-- Client rules depend on key/button bindings.
require("config.rules")({
	clientkeys = bindings.clientkeys,
	clientbuttons = bindings.clientbuttons,
})

-- Runtime signals and startup commands.
require("config.signals")
require("config.autostart")
