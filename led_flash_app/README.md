## Container registry instructions

Yon need to have an API or Access key to your Izuma account.
The following commands are also in build.sh
```
./build.sh --account <account> --api_key <api-key>
```

### Production Cloud

```
docker login containers.us-east-1.mbedcloud.com -u KEY -p  <ak_1M...>


docker build -t containers.us-east-1.mbedcloud.com/ACCOUNT_ID/led_poc_demo:v1 -f Dockerfile-v1 .
docker push  containers.us-east-1.mbedcloud.com/ACCOUNT_ID/led_poc_demo:v1

docker build -t containers.us-east-1.mbedcloud.com/ACCOUNT_ID/led_poc_demo:v2 -f Dockerfile-v2 .
docker push  containers.us-east-1.mbedcloud.com/ACCOUNT_ID/led_poc_demo:v2


curl https://containers.us-east-1.mbedcloud.com/v2/ACCOUNT_ID/led_poc_demo/tags/list -H "Authorization: Bearer ak_1M..."
```


### Staging

```
docker login containers.mbedcloudstaging.net -u KEY -p  <ak_1M...>


docker build -t containers.mbedcloudstaging.net/ACCOUNT_ID/led_poc_demo:v1 -f Dockerfile-v1 .
docker push  containers.mbedcloudstaging.net/ACCOUNT_ID/led_poc_demo:v1

docker build -t containers.mbedcloudstaging.net/ACCOUNT_ID/led_poc_demo:v2 -f Dockerfile-v2 .
docker push  containers.mbedcloudstaging.net/ACCOUNT_ID/led_poc_demo:v2


curl https://containers.mbedcloudstaging.net/v2/ACCOUNT_ID/led_poc_demo/tags/list -H "Authorization: Bearer ak_1M..."
```


Integration:

```
docker login containers.mbedcloudintegration.net -u KEY -p  <ak_1M...>


docker build -t containers.mbedcloudintegration.net/ACCOUNT_ID/led_poc_demo:v1 -f Dockerfile-v1 .
docker push  containers.mbedcloudintegration.net/ACCOUNT_ID/led_poc_demo:v1

docker build -t containers.mbedcloudintegration.net/ACCOUNT_ID/led_poc_demo:v2 -f Dockerfile-v2 .
docker push  containers.mbedcloudintegration.net/ACCOUNT_ID/led_poc_demo:v2


curl https://containers.mbedcloudintegration.net/v2/ACCOUNT_ID/led_poc_demo/tags/list -H "Authorization: Bearer ak_1M..."
```
