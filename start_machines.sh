#! /bin/bash

echo "Deploying orio_experiments image"

kadeploy3 -f ${OAR_NODE_FILE} -e debian9-x64-big -k
