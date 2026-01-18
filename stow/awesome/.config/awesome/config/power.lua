local awful = require("awful")

return function()
	local powermenu = awful.menu({
		items = {
			{
				"Lock",
				function()
					awful.spawn.with_shell("xscreensaver-command -lock")
				end,
			},
			{
				"Suspend",
				function()
					awful.spawn("systemctl suspend")
				end,
			},
			{
				"Hibernate",
				function()
					awful.spawn("systemctl hibernate")
				end,
			},
			{
				"Reboot",
				function()
					awful.spawn("systemctl reboot")
				end,
			},
			{
				"Poweroff",
				function()
					awful.spawn("systemctl poweroff")
				end,
			},
		},
	})

	local function show()
		local s = awful.screen.focused()
		local geo = s.workarea
		powermenu:show({ coords = { x = geo.x + geo.width / 2, y = geo.y + geo.height / 2 } })
	end

	return {
		show = show,
	}
end
