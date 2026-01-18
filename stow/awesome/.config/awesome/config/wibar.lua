local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")

return function(opts)
	local client = opts.client
	local screen = opts.screen
	local modkey = opts.modkey
	local battery_widget = opts.battery_widget
	local volume_widget = opts.volume_widget
	local tags = opts.tags

	local mytextclock = wibox.widget.textclock("   %H:%M ")

	local taglist_buttons = gears.table.join(
		awful.button({}, 1, function(t)
			t:view_only()
		end),
		awful.button({ modkey }, 1, function(t)
			if client.focus then
				client.focus:move_to_tag(t)
			end
		end),
		awful.button({}, 3, awful.tag.viewtoggle),
		awful.button({ modkey }, 3, function(t)
			if client.focus then
				client.focus:toggle_tag(t)
			end
		end),
		awful.button({}, 4, function(t)
			awful.tag.viewnext(t.screen)
		end),
		awful.button({}, 5, function(t)
			awful.tag.viewprev(t.screen)
		end)
	)

	local tasklist_buttons = gears.table.join(
		awful.button({}, 1, function(c)
			if c == client.focus then
				c.minimized = true
			else
				c:emit_signal("request::activate", "tasklist", { raise = true })
			end
		end),
		awful.button({}, 3, function()
			awful.menu.client_list({ theme = { width = 250 } })
		end),
		awful.button({}, 4, function()
			awful.client.focus.byidx(1)
		end),
		awful.button({}, 5, function()
			awful.client.focus.byidx(-1)
		end)
	)

	local function set_wallpaper(s)
		if beautiful.wallpaper then
			local wallpaper = beautiful.wallpaper
			if type(wallpaper) == "function" then
				wallpaper = wallpaper(s)
			end
			gears.wallpaper.maximized(wallpaper, s)
		end
	end

	screen.connect_signal("property::geometry", set_wallpaper)

	screen.connect_signal("removed", function(s)
		local target = awful.screen.focused()
		if not target then
			return
		end
		for _, t in ipairs(s.tags) do
			awful.tag.setscreen(t, target)
		end
	end)

	awful.screen.connect_for_each_screen(function(s)
		set_wallpaper(s)

		if #s.tags == 0 then
			awful.tag(tags, s, awful.layout.layouts[1])
		end

		s.mypromptbox = awful.widget.prompt()

		s.mytaglist = awful.widget.taglist({
			screen = s,
			filter = awful.widget.taglist.filter.all,
			buttons = taglist_buttons,
		})

		s.mytasklist = awful.widget.tasklist({
			screen = s,
			filter = awful.widget.tasklist.filter.currenttags,
			buttons = tasklist_buttons,
		})

		s.mywibox = awful.wibar({ position = "top", screen = s })

		s.mywibox:setup({
			layout = wibox.layout.align.horizontal,
			{
				layout = wibox.layout.fixed.horizontal,
				s.mytaglist,
				s.mypromptbox,
			},
			s.mytasklist,
			{
				layout = wibox.layout.fixed.horizontal,
				wibox.widget.systray(),
				battery_widget,
				volume_widget,
				mytextclock,
			},
		})
	end)
end
