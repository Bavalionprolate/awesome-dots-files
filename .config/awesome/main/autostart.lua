local awful = require("awful")
local gears = require("gears")

awful.spawn.with_shell("feh --randomize --bg-fill ~/wallpapers/")
awful.spawn.with_shell("picom --config " .. gears.filesystem.get_configuration_dir() .. "main/picom.conf")
awful.spawn.with_shell("nvidia-settings --assign CurrentMetaMode='nvidia-auto-select +0+0 { ForceFullCompositionPipeline = On }'")
