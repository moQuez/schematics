local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local naughty = require("naughty")
local beautiful = require("beautiful")

return function(opts)
    local warn_level = opts.warn_level or 20
    local critical_level = opts.critical_level or 10

    local bat_tb = wibox.widget.textbox()
    local bat_tt = awful.tooltip({ objects = { bat_tb } })

    local function update_battery()
        awful.spawn.easy_async_with_shell("acpi -b", function(stdout)
            local status, pct = stdout:match("Battery %d+: (%a+), (%d+)%%")
            pct = tonumber(pct or "0")

            -- Choose icon
            local icon = ""
            if pct >= 90 then
                icon = ""
            elseif pct >= 65 then
                icon = ""
            elseif pct >= 40 then
                icon = ""
            elseif pct >= 20 then
                icon = ""
            end
            if status == "Charging" then
                icon = ""
            end

            bat_tb:set_markup(string.format(" %s   %d%% ", icon, pct))

            -- Update bar color based on battery
            local bar_color = beautiful.bg_normal
            if status ~= "Charging" then
                if pct <= critical_level then
                    bar_color = "#8B0000" -- deep red
                elseif pct <= warn_level then
                    bar_color = "#FF8C00" -- orange
                end
            end

            -- apply to all screens
            for s in screen do
                if s.mywibox then
                    s.mywibox.bg = bar_color
                end
            end

            -- show notification at thresholds
            if status ~= "Charging" then
                if pct == warn_level then
                    naughty.notify({
                        title = "Battery low",
                        text = string.format("%d%% remaining", pct),
                        urgency = "normal",
                    })
                elseif pct == critical_level then
                    naughty.notify({
                        title = "Battery critical",
                        text = string.format("Only %d%% left! Plug in now!", pct),
                        urgency = "critical",
                    })
                end
            end
        end)
    end

    gears.timer({
        timeout = 30,
        autostart = true,
        call_now = true,
        callback = update_battery,
    })

    return {
        widget = bat_tb,
        tooltip = bat_tt,
        update = update_battery,
    }
end
