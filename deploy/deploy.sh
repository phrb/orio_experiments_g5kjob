#! /bin/bash

echo "Deploying orio_experiments image"

kadeploy3 -f $OAR_NODE_FILE -a /home/pbruel/orio_experiments.env -k

echo "Setting up ssh-agent and keys"
echo "Remember to set ForwardAgent to yes"

eval $(ssh-agent)
ssh-add
ssh-add -L

echo "Testing connectivity to GitHub"
ssh -T git@github.com

echo "Launching jobs"

taktuk -l root -o output='"$host: should be running...\n"' -f <( uniq $OAR_FILE_NODES ) broadcast exec [ /home/pbruel/orio_experiments_g5kjob/deploy/job.sh ]
