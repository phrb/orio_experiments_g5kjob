#! /bin/bash

echo "Allocating machines on 'grisou'"

oarsub -I -q production -p "cluster='graoully'" -l nodes=4,walltime=3 -t deploy
