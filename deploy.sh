#! /bin/bash

JOB_SCRIPT="/home/pbruel/orio_experiments_g5kjob/$1"

echo "Deploying orio_experiments image"

kadeploy3 -e debian10-x64-big -f ${OAR_NODE_FILE} -k

echo "Launching jobs"

taktuk -c "ssh" -l root -f <( uniq ${OAR_FILE_NODES} ) broadcast exec [ ${JOB_SCRIPT} ]
