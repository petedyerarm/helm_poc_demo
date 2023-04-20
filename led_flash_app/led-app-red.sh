#!/bin/sh

GREEN_SECONDS_ON=0
GREEN_SECONDS_OFF=0
RED_SECONDS_ON=1
RED_SECONDS_OFF=1



red_seconds="$RED_SECONDS_ON"
green_seconds="$GREEN_SECONDS_ON"
green_off=false
red_off=false


# Assign the LED pins to GPIO
echo gpio | tee /work/led0/trigger
echo gpio | tee /work/led1/trigger

# Turn both LEDs off.
echo 0    | tee /work/led0/brightness
echo 0    | tee /work/led1/brightness

while true; do

    # Deal with GREEN.
    if [ "$green_off" = true ]; then
        if [ "$green_seconds" -gt 0 ]; then
            echo 0 | tee /work/led0/brightness
            let "green_seconds = green_seconds - 1"
        fi
        if [ "$green_seconds" = 0 ]; then
            green_off=false
            green_seconds="$GREEN_SECONDS_ON"
        fi
    else
        if [ "$green_seconds" -gt 0 ]; then
            echo 1 | tee /work/led0/brightness
            let "green_seconds = green_seconds - 1"
        fi
        if [ "$green_seconds" = 0 ]; then
            green_off=true
            green_seconds="$GREEN_SECONDS_OFF"
        fi
    fi

    # Deal with RED.
    if [ "$red_off" = true ]; then
        if [ "$red_seconds" -gt 0 ]; then
            echo 0 | tee /work/led1/brightness
            let "red_seconds = red_seconds -1"
        fi
        if [ "$red_seconds" = 0 ]; then
            red_off=false
            red_seconds="$RED_SECONDS_ON"
        fi
    else
        if [ "$red_seconds" -gt 0 ]; then
            echo 1 | tee /work/led1/brightness
            let "red_seconds = red_seconds -1"
        fi
        if [ "$red_seconds" = 0 ]; then
            red_off=true
            red_seconds="$RED_SECONDS_OFF"
        fi
    fi

    sleep 1
done
