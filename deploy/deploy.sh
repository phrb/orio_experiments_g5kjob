#! /bin/bash

echo "Setting up ssh-agent and keys"
echo "Remember to set ForwardAgent to yes"

eval $(ssh-agent)
ssh-add
ssh-add -L

echo "Testing connectivity to GitHub"
ssh -T git@github.com

echo "Deploying orio_experiments image"

kadeploy3 -f $OAR_NODE_FILE -a /home/pbruel/orio_experiments.env -k

echo "Launching jobs"

taktuk -c "ssh -A" -l root -f <( uniq $OAR_FILE_NODES ) broadcast exec [ /home/pbruel/orio_experiments_g5kjob/deploy/job.sh ]
