#!/bin/bash

## script that you can use before launching cemu (flatpak version) in steam deck to configure it to pickup the active audio channel (you can add it to the launch options)
## I use it to fix an annoying issue with ceum (flatpak version) where it doesnt use the current active audio SINK; so when you connect to TV via HDMI, audio continues to come through the steamdeck and not through TV via HDMI ! then you need to go to desktop mode and set the audio settings manaully to use HDMI
## this script automates this manual step
## TARGET: /usr/bin/bash
## START IN:  /usr/bin
## steam launch option example: -c '/home/deck/audio-sink-cemu.sh && /usr/bin/flatpak "run" "--branch=stable" "--arch=x86_64" "--command=/app/bin/Cemu-wrapper" "info.cemu.Cemu" -f -g "/path/to/game/file"'

## switch to the current active PA audio SINK
export audioSinkACP=$(paplay /usr/share/sounds/Oxygen-Window-Maximize.ogg && pactl list short sinks | grep -e 'RUNNING' -e 'IDLE' | awk '{print $2}')
echo "Detected active audio sink: ${audioSinkACP}"
if [ ${audioSinkACP} ]; then
  c\p /home/deck/.var/app/info.cemu.Cemu/config/Cemu/settings.xml /home/deck/.var/app/info.cemu.Cemu/config/Cemu/settings.xml.bak
  sed -i ':a;N;$!ba; s|<TVDevice>alsa.*<\/TVDevice>|<TVDevice>'${audioSinkACP}'<\/TVDevice>|g' /home/deck/.var/app/info.cemu.Cemu/config/Cemu/settings.xml
fi
