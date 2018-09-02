#! /bin/bash

echo "Setting up ssh-agent and keys"
echo "Remember to set ForwardAgent to yes"

eval $(ssh-agent)
ssh-add
ssh-add -L

echo "Testing connectivity to GitHub"
ssh -T git@github.com

echo "Allocating machines on 'grisou'"

oarsub -I -q production -p "cluster='graoully'" -l nodes=1,walltime=3 -t deploy
