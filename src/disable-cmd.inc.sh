#!/bin/sh

for CMD in python ruby
do
  eval "$CMD(){ echo \"error: '${CMD}' is deprecated\"; exit 1; }"
done

pwd
python --version
ruby --version
