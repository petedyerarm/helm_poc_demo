#!/bin/bash

# Parse command line
args_list="api_key:"
args_list="${args_list},verbose"

args=$(getopt -o+ho:x $args_list -n "$(basename "$0")" -- "$@")

eval set -- "$args"

while [ $# -gt 0 ]; do
    if [ -n "${opt_prev:-}" ]; then
        eval "$opt_prev=\$1"
        opt_prev=
        shift 1
        continue
    elif [ -n "${opt_append:-}" ]; then
        eval "$opt_append=\"\${$opt_append:-} \$1\""
        opt_append=
        shift 1
        continue
    fi
    case $1 in
    --api_key)
        opt_prev=apiKey
        ;;
    --verbose)
        set -x
        ;;
    esac
    shift 1
done

if [ -z "${apiKey:-}" ]; then
    echo "API Key not specified"
    exit 1
fi

# Work out the accountId from the apiKey.

if [ "$(curl -s -o /dev/null https://api.us-east-1.mbedcloud.com/v3/accounts/me -w "%{http_code}\n" -H "Authorization: Bearer ${apiKey}")" = 200 ]; then
    accountId=$(curl -s https://api.us-east-1.mbedcloud.com/v3/accounts/me -H "Authorization: Bearer ${apiKey}" | jq ".id")
    CONTAINER_REGISTRY_URL="containers.us-east-1.mbedcloud.com"
elif [ "$(curl -s -o /dev/null https://lab-api.mbedcloudintegration.net/v3/accounts/me -w "%{http_code}\n" -H "Authorization: Bearer ${apiKey}")" = 200 ]; then
    accountId=$(curl -s https://lab-api.mbedcloudintegration.net/v3/accounts/me -H "Authorization: Bearer ${apiKey}" | jq ".id")
    CONTAINER_REGISTRY_URL="containers.mbedcloudintegration.net"
elif [ "$(curl -s -o /dev/null https://api-os2.mbedcloudstaging.net/v3/accounts/me -w "%{http_code}\n" -H "Authorization: Bearer ${apiKey}")" = 200 ]; then
    accountId=$(curl -s https://api-os2.mbedcloudstaging.net/v3/accounts/me -H "Authorization: Bearer ${apiKey}" | jq ".id")
    CONTAINER_REGISTRY_URL="containers.mbedcloudstaging.net"
else
    echo "ERROR - API key doesn't belong to an account on PRODUCTION, STAGING or INTLAB"
    exit 1
fi

echo "${apiKey}" | docker login "${CONTAINER_REGISTRY_URL}" -u KEY --password-stdin

docker build -t "${CONTAINER_REGISTRY_URL}"/"${accountId}"/led_poc_demo:v1 -f Dockerfile-v1 .
docker push  "${CONTAINER_REGISTRY_URL}"/"${accountId}"/led_poc_demo:v1

docker build -t "${CONTAINER_REGISTRY_URL}"/"${accountId}"/led_poc_demo:v2 -f Dockerfile-v2 .
docker push  "${CONTAINER_REGISTRY_URL}"/"${accountId}"/led_poc_demo:v2

docker logout "${CONTAINER_REGISTRY_URL}"

curl https://"${CONTAINER_REGISTRY_URL}"/v2/"${accountId}"/led_poc_demo/tags/list -H "Authorization: Bearer ${apiKey}"



