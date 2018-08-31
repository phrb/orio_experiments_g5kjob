#! /bin/bash

cd orio_experiments/testsuite/SPAPT/stencil3d
git pull

./run_multiple.sh 1 stencil3d.src1_linear.c
