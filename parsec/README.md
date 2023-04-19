***IMPORTANT*** 
This container ***MUST*** be built and pushed from the device under test - i.e. the RPi.

## Container registry instructions

Yon need to have an API or Access key to your Izuma account.
The following commands are also in build.sh
```
./build.sh --account <account> --api_key <api-key>
```

### Production Cloud

```
docker login containers.us-east-1.mbedcloud.com -u KEY -p  <ak_1M...>


docker build -t containers.us-east-1.mbedcloud.com/ACCOUNT_ID/parsec_poc_demo:v1 -f Dockerfile .
docker push  containers.us-east-1.mbedcloud.com/ACCOUNT_ID/parsec_poc_Demo:v1


curl https://containers.us-east-1.mbedcloud.com/v2/ACCOUNT_ID/parsec_poc_demo/tags/list -H "Authorization: Bearer ak_1M..."
```



