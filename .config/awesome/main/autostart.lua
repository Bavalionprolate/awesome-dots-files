local awful = require("awful")
local gears = require("gears")

awful.spawn.easy_async("nitrogen --restore")
awful.spawn.easy_async("picom --config " .. gears.filesystem.get_configuration_dir() .. "main/picom.conf")
awful.spawn.easy_async("nvidia-settings --assign CurrentMetaMode='nvidia-auto-select +0+0 { ForceFullCompositionPipeline = On }'")
