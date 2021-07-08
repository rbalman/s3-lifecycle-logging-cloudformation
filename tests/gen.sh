#!/bin/bash
########################## GENERATE RANDOM TEXT FILES FOR TESTS ##########################
## Takes only one agrument: number of files to generate by default generates 100 files
## Example: ./gen.sh 10

mkdir -p files
count=${1:-100}

while [ ${count} -gt 0 ]
do
  name=$(uuidgen)
  ((count=count - 1))
  cat /dev/urandom | base64 | head -c 1000 > files/${name}
done
