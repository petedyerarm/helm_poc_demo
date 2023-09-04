## Container registry instructions

Yon need to have an API or Access key to your Izuma account.
The following commands are also in build.sh which will work out the ACCOUNT_ID from the apikey.
```
./build.sh --api_key <api-key>
```

```
./build_red_green.sh --api_key <api-key>
```

### Production Cloud

```
echo  <ak_1M...> | docker login containers.us-east-1.mbedcloud.com -u KEY --password-stdin

docker build -t containers.us-east-1.mbedcloud.com/ACCOUNT_ID/led_poc_demo:v1 -f Dockerfile-v1 .
docker push  containers.us-east-1.mbedcloud.com/ACCOUNT_ID/led_poc_demo:v1

docker build -t containers.us-east-1.mbedcloud.com/ACCOUNT_ID/led_poc_demo:v2 -f Dockerfile-v2 .
docker push  containers.us-east-1.mbedcloud.com/ACCOUNT_ID/led_poc_demo:v2

docker logout containers.us-east-1.mbedcloud.com

curl https://containers.us-east-1.mbedcloud.com/v2/ACCOUNT_ID/led_poc_demo/tags/list -H "Authorization: Bearer ak_1M..."
```


### Staging

```
echo  <ak_1M...> | docker login containers.mbedcloudstaging.net -u KEY --password-stdin

docker build -t containers.mbedcloudstaging.net/ACCOUNT_ID/led_poc_demo:v1 -f Dockerfile-v1 .
docker push  containers.mbedcloudstaging.net/ACCOUNT_ID/led_poc_demo:v1

docker build -t containers.mbedcloudstaging.net/ACCOUNT_ID/led_poc_demo:v2 -f Dockerfile-v2 .
docker push  containers.mbedcloudstaging.net/ACCOUNT_ID/led_poc_demo:v2

docker logout containers.mbedcloudstaging.net

curl https://containers.mbedcloudstaging.net/v2/ACCOUNT_ID/led_poc_demo/tags/list -H "Authorization: Bearer ak_1M..."
```


Integration:

```
echo  <ak_1M...> | docker login containers.mbedcloudintegration.net -u KEY --password-stdin

docker build -t containers.mbedcloudintegration.net/ACCOUNT_ID/led_poc_demo:v1 -f Dockerfile-v1 .
docker push  containers.mbedcloudintegration.net/ACCOUNT_ID/led_poc_demo:v1

docker build -t containers.mbedcloudintegration.net/ACCOUNT_ID/led_poc_demo:v2 -f Dockerfile-v2 .
docker push  containers.mbedcloudintegration.net/ACCOUNT_ID/led_poc_demo:v2

docker logout containers.mbedcloudintegration.net

curl https://containers.mbedcloudintegration.net/v2/ACCOUNT_ID/led_poc_demo/tags/list -H "Authorization: Bearer ak_1M..."
```
