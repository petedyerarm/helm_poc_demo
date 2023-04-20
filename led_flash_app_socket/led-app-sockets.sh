#!/bin/sh

GREEN_SECONDS_ON=1
GREEN_SECONDS_OFF=1
RED_SECONDS_ON=2
RED_SECONDS_OFF=2


./led_flash.py \
    --green_on "$GREEN_SECONDS_ON" \
    --green_off "$GREEN_SECONDS_OFF" \
    --red_on "$RED_SECONDS_ON" \
    --red_off "$RED_SECONDS_OFF"


