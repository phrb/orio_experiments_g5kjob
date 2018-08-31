#! /bin/bash

echo "Allocating machines on 'grisou'"

oarsub -q production -p "cluster='graoully'" -l nodes=4,walltime=3 -I -t deploy

echo "Deploying orio_experiments image"

kadeploy3 -f $OAR_NODE_FILE -a /home/phrb/orio_experiments.env -k

echo "Setting up ssh-agent and keys"
echo "Remember to set ForwardAgent to yes"

eval $(ssh-agent)
ssh-add
ssh-add -L

echo "Testing connectivity to GitHub"
ssh -T git@github.com

