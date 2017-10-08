#!/bin/bash

# package.json contents go to top level
# resource.json goes to .resource
# config.json goes to .config
# b64 encode of marathon.json.mustache goes to .marathon.v2AppMustacheTemplate

base64 -w0 marathon.json.mustache | jq -R '{v2AppMustacheTemplate: .}' > marathon.json
jq -s '{resource: .[0], config: .[1], marathon: .[2] }' resource.json config.json marathon.json > base.json

jq -s '.[0] * .[1]' package.json base.json > full.json

jq '{packages: [.]}' full.json > universe.json