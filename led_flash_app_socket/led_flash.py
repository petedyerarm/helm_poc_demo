#!/usr/bin/python3

"""Flash the LEDs on a Raspberry Pi."""

# ----------------------------------------------------------------------------
# Copyright (c) 2023, Izuma Networks and affiliates.
#
# SPDX-License-Identifier: Apache-2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------

import argparse
import sys
import time


green_off = False
red_off = False
red_seconds = options.red_on
green_seconds = options.green_on


def _red(on):
    with open("/work/led1/brightness", "w") as red:
        if on:
            print("RED: ON")
            red.write("1")
        else:
            print("RED: OFF")
            red.write("0")


def _green(on):
    with open("/work/led0/brightness", "w") as green:
        if on:
            print("GRN: ON")
            green.write("1")
        else:
            print("GRN: OFF")
            green.write("0")


def _init_leds():
    with open("/work/led1/trigger", "w") as red_trigger:
        red_trigger.write("gpio")
    _red(False)
    with open("/work/led0/trigger", "w") as green_trigger:
        green_trigger.write("gpio")
    _green(False)


def main():
    """Perform the main execution."""
    # Parse command line
    parser = argparse.ArgumentParser(description="Flash LEDs")
    parser.add_argument(
        "--green_on", type=int, help="Green LED on seconds", required=True
    )
    parser.add_argument(
        "--green_off", type=int, help="Green LED off seconds", required=True
    )
    parser.add_argument(
        "--red_on", type=int, help="Red LED on seconds", required=True
    )
    parser.add_argument(
        "--red_off", type=int, help="Red LED off seconds", required=True
    )

    options = parser.parse_args()

    print(options.green_on)
    print(options.green_off)
    print(options.red_on)
    print(options.red_off)

    _init_leds()

    while True:
        if green_off:
            if green_seconds > 0:
                _green(False)
                green_seconds -= 1
            if green_seconds == 0:
                green_off = False
                green_seconds = options.green_on
        else:
            if green_seconds > 0:
                _green(True)
                green_seconds -= 1
            if green_seconds == 0:
                green_off = True
                green_seconds = options.green_off

        if red_off:
            if red_seconds > 0:
                _red(False)
                red_seconds -= 1
            if red_seconds == 0:
                red_off = False
                red_seconds = options.red_on
        else:
            if red_seconds > 0:
                _red(True)
                red_seconds -= 1
            if red_seconds == 0:
                red_off = True
                red_seconds = options.red_off

        time.sleep(1)


if __name__ == "__main__":
    sys.exit(main())
