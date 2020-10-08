#!/bin/bash

set -e

# OSX GUI apps do not pick up environment variables the same way as Terminal apps and there are no easy solutions,
# especially as Apple changes the GUI app behavior every release (see https://stackoverflow.com/q/135688/483528). As a
# workaround to allow GitHub Desktop to work, add this (hopefully harmless) setting here.
export PATH=$PATH:/usr/local/bin

# Export some Default Variables to make testing work
export AWS_REGION=${AWS_REGION:-us-east-1}

for dir in $(echo "$@" | xargs -n1 dirname | sort -u | uniq); do
  pushd "$dir" >/dev/null
  terraform init -backend=false
  terraform validate
  popd >/dev/null
done
