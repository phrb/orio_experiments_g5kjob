#! /bin/bash

apt-get install -y python-rpy2 r-cran-car
Rscript -e 'install.packages("AlgDesign", repos="https://cran.rstudio.com")'
pip install dataset

CLONE_TARGET="/root/dlmt_spapt_experiments"

echo "Updating target data directory"

if [ -d "$CLONE_TARGET" ]; then
    git -C ${CLONE_TARGET} pull
else
    git clone --depth 1 https://github.com/phrb/dlmt_spapt_experiments.git
fi

APP_TARGET="/root/dlmt_spapt_experiments/orio/testsuite/SPAPT/stencil3d"
cd $APP_TARGET

USR="pbruel"
USR_TARGET="/home/${USR}/dlmt_spapt_experiments/data/results/stencil3d"
NODE_NAME="xeon_e5_2630_v3_$(uname -n | cut -d. -f1)"

./run_multiple.sh 1 stencil3d.c

mv ${APP_TARGET}/${NODE_NAME}_* /tmp/

su ${USR} -c "mkdir -p ${USR_TARGET}"
su ${USR} -c "mv /tmp/${NODE_NAME}_* ${USR_TARGET}"

./run_multiple.sh 1 stencil3d_random.c

mv ${APP_TARGET}/${NODE_NAME}_* /tmp/

su ${USR} -c "mkdir -p ${USR_TARGET}"
su ${USR} -c "mv /tmp/${NODE_NAME}_* ${USR_TARGET}"
