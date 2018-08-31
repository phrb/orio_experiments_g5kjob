#! /bin/bash

cd orio_experiments/testsuite/SPAPT/stencil3d
./run_multiple.sh 1 stencil3d.src1_linear.c

mkdir xeon_e5_2630_v3_$(uname -n | cut -d. -f1)

./db2csv.py
mv results.* search_space* xeon_e5_2630_v3_$(uname -n | cut -d. -f1)

./clean.sh

git add --all
git commit -m "stencil3d Xeon E5 2630 v3 $(uname -n | cut -d. -f1) $(date)"
git push
