#!/bin/bash

## script that you cna use before launching cemu to configure it to pickup the active audio channel (add it to the launch)
## to fix annoying issue with ceum (flatpak version) where it doesnt use the current active audio SINK; so when you connec to TV via HDMI, audio continues to come through the steamdeck and not through TV via HDMI
## 

## switch to the current active PA audio SINK
export audioSinkACP=$(paplay /usr/share/sounds/Oxygen-Window-Maximize.ogg && pactl list short sinks | grep -e 'RUNNING' -e 'IDLE' | awk '{print $2}')
echo "Detected active audio sink: ${audioSinkACP}"
if [ ${audioSinkACP} ]; then
  c\p /home/deck/.var/app/info.cemu.Cemu/config/Cemu/settings.xml /home/deck/.var/app/info.cemu.Cemu/config/Cemu/settings.xml.bak
  sed -i ':a;N;$!ba; s|<TVDevice>alsa.*<\/TVDevice>|<TVDevice>'${audioSinkACP}'<\/TVDevice>|g' /home/deck/.var/app/info.cemu.Cemu/config/Cemu/settings.xml
fi