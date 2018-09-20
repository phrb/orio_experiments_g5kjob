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

#oarsub -q default -p "cluster='paravance'" -l nodes=10,walltime=13 -t deploy -r "2018-09-20 19:00:00"
oarsub -q default -p "cluster='paravance'" -l nodes=10,walltime=13 -t deploy
