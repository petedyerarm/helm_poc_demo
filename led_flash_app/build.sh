#!/bin/bash

# Parse command line
args_list="account:"
args_list="${args_list},api_key:"
args_list="${args_list},url"
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
    --account)
        opt_prev=accountId
        ;;
    --api_key)
        opt_prev=apiKey
        ;;
    --url)
        opt_prev=url
        ;;
    --verbose)
        set -x
        ;;
    esac
    shift 1
done

if [ -z "${accountId:-}" ]; then
    echo "Account ID not specified"
    exit 1
fi

if [ -z "${apiKey:-}" ]; then
    echo "API Key not specified"
    exit 1
fi

if [ -z "${url:-}" ]; then
    url=containers.us-east-1.mbedcloud.com
fi

docker login "${url}" -u KEY -p  "${apiKey}"


docker build -t "${url}"/"${accountId}"/led_poc_demo:v1 -f Dockerfile-v1 .
docker push  "${url}"/"${accountId}"/led_poc_demo:v1

docker build -t "${url}"/"${accountId}"/led_poc_demo:v2 -f Dockerfile-v2 .
docker push  "${url}"/"${accountId}"/led_poc_demo:v2


curl https://"${url}"/v2/"${accountId}"/led_poc_demo/tags/list -H "Authorization: Bearer ${apiKey}"



