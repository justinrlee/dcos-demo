#!/bin/bash
mkdir -p workspace
mkdir -p packages
for package in $PACKAGES; do
    echo "Building package for [${package}]..."
    
    echo "Encoding mustache"
    base64 -w0 ${package}/marathon.json.mustache | jq -R '{v2AppMustacheTemplate: .}' > workspace/marathon.json

    # echo Combine nested entries
    jq -s '{resource: .[0], config: .[1], marathon: .[2] }' ${package}/resource.json ${package}/config.json workspace/marathon.json > workspace/base.json

    echo "Creating tweeter.json"
    jq -s '.[0] * .[1]' ${package}/package.json workspace/base.json > packages/${package}.json

    echo "Cleaning up..."
    rm workspace/marathon.json
    rm workspace/base.json

done

echo "Combining packages into universe.json"
jq -s '{packages: .}' packages/*.json > universe.json
# rm packages/*

