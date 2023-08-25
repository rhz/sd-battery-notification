#!/bin/bash
# This script was inspired by a script shared by Fabby on
# https://forum.manjaro.org/t/battery-limiter-on-kde/27443/10

battery="BAT0"

playSound=paplay # could be aplay
soundToPlay="/usr/share/sounds/Oxygen-Sys-App-Error-Serious-Very.ogg"

tmpFile="battery-notification-sent"

upperBound=.8
lowerBound=.4
upperBoundPercentage=`echo "scale=0; ${upperBound}*100/1" | bc -l`
lowerBoundPercentage=`echo "scale=0; ${lowerBound}*100/1" | bc -l`

currentCharge=`cat /sys/class/power_supply/${battery}/charge_now`
fullCharge=`cat /sys/class/power_supply/${battery}/charge_full`

function batteryNotify() {
  if [ ! -e "$tmpFile" ]; then
    notify-send --urgency="$1" --icon=battery "Battery" "$2"
    $playSound $soundToPlay
    touch "$tmpFile"
  fi
}

if (( $(echo "$currentCharge/$fullCharge >= $upperBound" | bc -l) )); then
  batteryNotify "critical" \
    "Hey, this is your battery talking: I'm charged above ${upperBoundPercentage}%"
elif (( $(echo "$currentCharge/$fullCharge <= $lowerBound" | bc -l) )); then
  batteryNotify "normal" \
    "Hey, I'm charged below ${lowerBoundPercentage}%"
elif [ -e "$tmpFile" ]; then
  rm "$tmpFile"
fi
