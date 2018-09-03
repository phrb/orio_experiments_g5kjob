#! /bin/bash

USR="pbruel"
APP_TARGET="/root/dlmt_spapt_experiments/orio/testsuite/SPAPT/atax"
USR_TARGET="/home/${USR}/dlmt_spapt_experiments/data/atax"
NODE_NAME="xeon_e5_2630_v3_$(uname -n | cut -d. -f1)"

apt-get install -y python-rpy2 r-cran-car
Rscript -e 'install.packages("AlgDesign", repos="https://cran.rstudio.com")'
pip install dataset

git clone https://github.com/phrb/dlmt_spapt_experiments.git

cd $APP_TARGET

#./run_multiple.sh 1 atax2.src1.c
./run_multiple.sh 1 atax2.src1_random.c

cp -r ${APP_TARGET}/${NODE_NAME}_* /tmp/

su ${USR} -c "mkdir -p ${USR_TARGET}"
su ${USR} -c "cp -r /tmp/${NODE_NAME}_* ${USR_TARGET}"
