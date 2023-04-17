# Helm chart testing

Helm chart for deploying a RPI LED flasher app, in a pod.

The LED flasher is a simple proof of concept application.

## LED Flasher

The LED flasher APP comprises of a shell script that runs inside a simple Docker container. It is stored within the Container Registry for the users account.
The LED flasher App runs on a 1 second basis and controls the RED and GREEN LED on a RPI3 or RPI4.

The ON/OFF times of the LEDS are controlled by environment variables that are passed in the pod specification.

## Helm

### Values files
Each 

### Install the LED flasher

```
helm install rpi-node-1 rpi-poc-demo/ --values rpi-poc-demo/values.yaml -f rpi-poc-demo/values_node1.yaml
```
```
helm install rpi-node-2 rpi-poc-demo/ --values rpi-poc-demo/values.yaml -f rpi-poc-demo/values_node2.yaml
```

### Update the LED flasher

```
helm upgrade rpi-node-1 rpi-poc-demo --values rpi-poc-demo/values.yaml -f rpi-poc-demo/values_node1.yaml --set image.tag=v2
```
```
helm upgrade rpi-node-2 rpi-poc-demo --values rpi-poc-demo/values.yaml -f rpi-poc-demo/values_node2.yaml --set image.tag=v2
```

### Uninstall the LED flasher

```
helm uninstall rpi-node-1
```
```
helm uninstall rpi-node-2
```


### Check environment variables.

```
kubectl exec <pod> -- env
```
