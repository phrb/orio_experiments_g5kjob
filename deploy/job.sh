#! /bin/bash

eval $(ssh-agent)
ssh-add
ssh-add -L
ssh -T git@github.com

cd orio_experiments/testsuite/SPAPT/stencil3d
git pull

./run_multiple.sh 1 stencil3d.src1_linear.c
