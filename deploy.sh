#! /bin/bash

JOB_SCRIPT="/home/pbruel/orio_experiments_g5kjob/job_atax.sh"

echo "Deploying orio_experiments image"

kadeploy3 -f ${OAR_NODE_FILE} -e debian9-x64-big -k

echo "Launching jobs"

taktuk -c "ssh" -l root -f <( uniq ${OAR_FILE_NODES} ) broadcast exec [ ${JOB_SCRIPT} ]
