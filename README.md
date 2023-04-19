# Helm Chart Proof of Concept Demo.

There are 2 parts to the demo.


The first is the containers with the applications. These are in led_flash_app - there are 2 versions of the container with different LED flashing behaviour.
There is a build.sh script to assist in building the containers and pushing them into an account specific container registry.

Then there is Helm charts. These are in helm

