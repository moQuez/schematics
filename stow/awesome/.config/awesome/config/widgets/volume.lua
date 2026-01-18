local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")

return function()
	local vol_tb = wibox.widget.textbox()

	local function update_volume()
		awful.spawn.easy_async_with_shell(
			"pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | head -n1 && pactl get-sink-mute @DEFAULT_SINK@",
			function(stdout)
				local vol, mute = stdout:match("(%d+)%%.*\nMute: (%a+)")
				if not vol then
					vol = "?"
					mute = "no"
				end

				local icon = ""
				if mute == "yes" then
					icon = ""
				elseif tonumber(vol) == 0 then
					icon = ""
				elseif tonumber(vol) < 50 then
					icon = ""
				end

				vol_tb:set_markup(string.format(" %s   %s%% ", icon, vol))
			end
		)
	end

	gears.timer({
		timeout = 5,
		autostart = true,
		call_now = true,
		callback = update_volume,
	})

	return {
		widget = vol_tb,
		update = update_volume,
	}
end
