#!/usr/bin/env bash

token_uri="https://auth.docker.io/token"
list_uri="https://registry-1.docker.io/v2/###IMAGE###/tags/list"

images=($@)

scope=''
for image in "${images[@]}"; do
    scope+="scope=repository:${image}:pull&"
done

token=$( curl -Ss "${token_uri}?service=registry.docker.io&${scope}" | jq -r .token )

for image in "${images[@]}"; do
    this_uri=$( echo -n "${list_uri}" | sed -e "s^###IMAGE###^${image}^" )
    curl -Ss -H "Accept: application/json" -H "Authorization: Bearer $token" "${this_uri}" | jq .
done
