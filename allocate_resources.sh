#! /bin/bash

CLONE_TARGET="/home/pbruel/dlmt_spapt_experiments"

echo "Testing connectivity to GitHub"
ssh -T git@github.com

echo "Updating target data directory"

if [ -d "$CLONE_TARGET" ]; then
    git -C ${CLONE_TARGET} pull
else
    git clone git@github.com:phrb/dlmt_spapt_experiments.git ${CLONE_TARGET}
fi

echo "Allocating machines"

# Nancy

#oarsub -q default -p "cluster='grisou'" -l nodes=51,walltime=14 -t deploy -r "2018-10-04 19:00:00"
#oarsub -I -q default -p "cluster='paravance'" -l nodes=10,walltime=12 -t deploy
oarsub -I -q production -p "cluster='graoully'" -l nodes=10,walltime=10 -t deploy
#oarsub -I -q default -p "cluster='grisou'" -l nodes=20,walltime=4 -t deploy

# Rennes

#oarsub -q default -p "cluster='grisou'" -l nodes=9,walltime=14 -t deploy -r "2018-09-21 19:00:00"
#oarsub -I -q default -p "cluster='paravance'" -l nodes=10,walltime=12 -t deploy
#oarsub -I -q default -p "cluster='parasilo'" -l nodes=9,walltime=8 -t deploy
#oarsub -I -q production -p "cluster='graoully'" -l nodes=10,walltime=48 -t deploy
#oarsub -I -q default -p "cluster='paravance'" -l nodes=30,walltime=6 -t deploy
#oarsub -I -q default -p "cluster='parasilo'" -l nodes=20,walltime=6 -t deploy
