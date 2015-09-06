require("awful")

keys = root.keys()

soundkeys = awful.util.table.join(keys,
awful.key({ }, "XF86AudioRaiseVolume", function ()
       awful.util.spawn("amixer -- sset Master playback 1500+") end),
   awful.key({ }, "XF86AudioLowerVolume", function ()
       awful.util.spawn("amixer -- sset Master playback 1500-") end),
   awful.key({ }, "XF86AudioMute", function ()
       awful.util.spawn("/home/stephan/.config/awesome/snd_toggle.sh") end)
)
root.keys(soundkeys)
