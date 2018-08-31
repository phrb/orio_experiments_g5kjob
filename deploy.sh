#! /bin/bash

echo "Testing connectivity to GitHub"
ssh -T git@github.com

echo "Allocating machines on 'grisou'"

oarsub -p "cluster='grisou'" -l nodes=1,walltime=2 -I -t deploy

echo "Deploying orio_experiments image"

kadeploy3 -f $OAR_NODE_FILE -a orio_experiments.env -k

echo "Setting up ssh-agent and keys"
echo "Remember to set ForwardAgent to yes"

eval $(ssh-agent)
ssh-add
ssh-add -L
