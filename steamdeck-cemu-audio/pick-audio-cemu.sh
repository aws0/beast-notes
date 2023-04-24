#!/bin/bash

#echo "checking if HDMI audio is present"
## if HDMI is detected switch to HDMI SINK - give HDMI priority
# export audioSinkHDMI=$(pactl list short sinks | grep alsa_output | grep hdmi | awk '{print $2}')
# echo "audioSinkHDMI=${audioSinkHDMI}"
# if [ ${audioSinkHDMI} ]; then
#   c\p /home/deck/.var/app/info.cemu.Cemu/config/Cemu/settings.xml /home/deck/.var/app/info.cemu.Cemu/config/Cemu/settings.xml.bak
#   sed -i ':a;N;$!ba; s|<TVDevice>alsa.*<\/TVDevice>|<TVDevice>'${audioSinkHDMI}'<\/TVDevice>|g' /home/deck/.var/app/info.cemu.Cemu/config/Cemu/settings.xml
#   exit 0
# fi

## switch to the current active SINK
export audioSinkACP=$(paplay /usr/share/sounds/Oxygen-Window-Maximize.ogg && pactl list short sinks | grep -e 'RUNNING' -e 'IDLE' | awk '{print $2}')
echo "Detected active audio sink: ${audioSinkACP}"
if [ ${audioSinkACP} ]; then
  c\p /home/deck/.var/app/info.cemu.Cemu/config/Cemu/settings.xml /home/deck/.var/app/info.cemu.Cemu/config/Cemu/settings.xml.bak
  sed -i ':a;N;$!ba; s|<TVDevice>alsa.*<\/TVDevice>|<TVDevice>'${audioSinkACP}'<\/TVDevice>|g' /home/deck/.var/app/info.cemu.Cemu/config/Cemu/settings.xml
fi