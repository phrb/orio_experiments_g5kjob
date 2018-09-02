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

echo "Allocating machines on 'grisou'"

oarsub -I -q production -p "cluster='graoully'" -l nodes=1,walltime=3 -t deploy
