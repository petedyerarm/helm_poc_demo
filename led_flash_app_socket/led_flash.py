#!/usr/bin/python3

import sys
import time

def red(on):
    with open('/work/led1/brightness', 'w') as red:
        if on:
            print("RED: ON")
            red.write('1')
        else:
            print("RED: OFF")
            red.write('0')

def green(on):
    with open('/work/led0/brightness', 'w') as green:
        if on:
            print("GRN: ON")
            green.write('1')
        else:
            print("GRN: OFF")
            green.write('0')

def init_leds():
    with open('/work/led1/trigger', 'w') as red_trigger:
        red_trigger.write('gpio')
    red(False)
    with open('/work/led0/trigger', 'w') as green_trigger:
        green_trigger.write('gpio')
    green(False)


def main():

    init_leds()
    time.sleep(1)

    red(True)
    green(False)
    time.sleep(1)

    red(False)
    green(True)
    time.sleep(1)

    red(True)
    green(False)
    time.sleep(1)

    red(False)
    green(True)
    time.sleep(1)


if __name__ == "__main__":
    sys.exit(main())

