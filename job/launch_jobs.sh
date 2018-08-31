#! /bin/bash

echo "Setting up ssh-agent and keys"
echo "Remember to set ForwardAgent to yes"

eval $(ssh-agent)
ssh-add
ssh-add -L

echo "Testing connectivity to GitHub"
ssh -T git@github.com

echo "Allocating machines"

oarsub -q production -p "cluster='graoully'" -l nodes=4,walltime=3 ./job.sh
