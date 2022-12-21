local awful = require "awful"
local gears = require "gears"
local wibox = require "wibox"
local beautiful = require "beautiful"

local dpi = beautiful.xresources.apply_dpi

function double_click_event_handler(double_click_event)
	if double_click_timer then
            double_click_timer:stop()
            double_click_timer = nil
            return true
        end
    
        double_click_timer = gears.timer.start_new(0.20, function()
            double_click_timer = nil
            return false
        end)
end

----- Titlebar
local get_titlebar = function(c)
  -- Button
    local buttons = gears.table.join(
      awful.button({ }, 1, function()
          c:emit_signal("request::activate", "titlebar", {raise = true})
          if double_click_event_handler() then
              c.maximized = not c.maximized
              c:raise()
          else
              awful.mouse.client.move(c)
          end
      end),
      awful.button({ }, 3, function()
          c:emit_signal("request::activate", "titlebar", {raise = true})
          awful.mouse.client.resize(c)
      end)
  )

  -- Titlebar's decorations
  local left = wibox.widget {
    awful.titlebar.widget.closebutton(c),
    awful.titlebar.widget.minimizebutton(c),
    awful.titlebar.widget.maximizedbutton(c),
    spacing = dpi(6),
    layout = wibox.layout.fixed.horizontal,
  }

  local middle = wibox.widget {
    buttons = buttons,
    layout = wibox.layout.fixed.horizontal,
  }

  local right = wibox.widget {
    buttons = buttons,
    layout = wibox.layout.fixed.horizontal,
  }

  local container = wibox.widget {
    bg = beautiful.bg,
    widget = wibox.container.background,
  }

  c:connect_signal("focus", function() container.bg = beautiful.bg end)
  c:connect_signal("unfocus", function() container.bg = beautiful.bg end)

  return wibox.widget {
    {
      {
        left,
        middle,
        right,
        layout = wibox.layout.align.horizontal,
      },
      margins = { top = dpi(9), bottom = dpi(9), left = dpi(10), right = dpi(10) },
      widget = wibox.container.margin,
    },
    widget = container,
  }
end

local function top(c)
  local titlebar = awful.titlebar(c, {
    position = 'top',
    size = dpi(32),
  })

  titlebar:setup {
    widget = get_titlebar(c)
  }
end

client.connect_signal("request::titlebars", function(c)
  if c.class == "feh" then
    awful.titlebar.hide(c)
  else
    top(c)
  end
end)
