xrandr --output VGA-0 --auto --output VGA1 --auto --right-of VGA-0 &
nvidia-settings --assign CurrentMetaMode="nvidia-auto-select +0+0 { ForceFullCompositionPipeline = On }" &
setxkbmap -layout us,ru , -option grp:alt_shift_toggle &
exec awesome --no-argb
