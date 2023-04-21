#!/bin/bash
set -e
printf "Running as `id`\n\n"

if /usr/src/app/parsec-tool ping | grep '1.0'; then 
    printf "Parsec service is reachable!\n\n"

    printf "List the keys managed by this user..\n\n"
    /usr/src/app/parsec-tool list-keys
    if /usr/src/app/parsec-tool list-keys |& grep "No keys currently available"; then
        # No keys found in TPM which are either created or accessed by this user
        # Create ECC key pair
        printf "Create an ECC key pair..\n\n"
        /usr/src/app/parsec-tool create-ecc-key --key-name `id -u`-key-$((1 + $RANDOM % 10))
        /usr/src/app/parsec-tool list-keys
    fi
    /usr/src/app/parsec-tool export-public-key --key-name $(/usr/src/app/parsec-tool  list-keys | cut -d" " -f2)
fi


