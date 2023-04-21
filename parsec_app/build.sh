#!/bin/bash

# Parse command line
args_list="account:"
args_list="${args_list},api_key:"
args_list="${args_list},verbose"
args_list="${args_list},version"

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
    --verbose)
        set -x
        ;;
    --version)
        opt_prev=version
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

if [ -z "${version:-}" ]; then
    echo "Version not specified"
    exit 1
fi


docker login containers.us-east-1.mbedcloud.com -u KEY -p  "${apiKey}"

docker build -t containers.us-east-1.mbedcloud.com/"${accountId}"/parsec_poc_demo:"${version}" -f Dockerfile .
docker push  containers.us-east-1.mbedcloud.com/"${accountId}"/parsec_poc_demo:"${version}"

curl https://containers.us-east-1.mbedcloud.com/v2/"${accountId}"/parsec_poc_demo/tags/list -H "Authorization: Bearer ${apiKey}"



