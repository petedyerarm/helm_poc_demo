# Helm Chart Proof of Concept Demos.

This repository holds some sample containers and Helm charts.

## LED Flasher

### LED Flasher Containers

The container specification is in led_flash_app.

There are 2 versions of the container with different LED flashing behaviour.

There is a build.sh script to assist in building the containers and pushing them into an account specific container registry.

### LED Flasher Helm Charts

The LED flasher Helm Charts are in helm/rpi-poc-demo


## PARSEC

### PARSEC Container

The container specification is in parsec_app.

This container must be built on the device being used - for example a RPi.
There is a build.sh script to assist in building the containers and pushing them into an account specific container registry.

## PARSEC Helm Charts


