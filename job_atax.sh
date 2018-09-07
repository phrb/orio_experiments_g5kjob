#! /bin/bash

apt-get install -y python-rpy2 r-cran-car
Rscript -e 'install.packages("AlgDesign", repos="https://cran.rstudio.com")'
pip install dataset

CLONE_TARGET="/root/dlmt_spapt_experiments"

echo "Updating target data directory"

if [ -d "$CLONE_TARGET" ]; then
    git -C ${CLONE_TARGET} pull
else
    git clone https://github.com/phrb/dlmt_spapt_experiments.git
fi

APP_TARGET="/root/dlmt_spapt_experiments/orio/testsuite/SPAPT/atax"
cd $APP_TARGET

./run_multiple.sh 1 atax2.src0.c

USR="pbruel"
USR_TARGET="/home/${USR}/dlmt_spapt_experiments/data/atax"
NODE_NAME="xeon_e5_2630_v3_$(uname -n | cut -d. -f1)"

mv ${APP_TARGET}/${NODE_NAME}_* /tmp/

su ${USR} -c "mkdir -p ${USR_TARGET}"
su ${USR} -c "mv /tmp/${NODE_NAME}_* ${USR_TARGET}"

# ./run_multiple.sh 1 atax2.src0_random.c
#
# USR="pbruel"
# USR_TARGET="/home/${USR}/dlmt_spapt_experiments/data/atax"
# NODE_NAME="xeon_e5_2630_v3_$(uname -n | cut -d. -f1)"
#
# mv ${APP_TARGET}/${NODE_NAME}_* /tmp/
#
# su ${USR} -c "mkdir -p ${USR_TARGET}"
# su ${USR} -c "mv /tmp/${NODE_NAME}_* ${USR_TARGET}"
#
# ./run_multiple.sh 1 atax2.src0_sima.c
#
# USR="pbruel"
# USR_TARGET="/home/${USR}/dlmt_spapt_experiments/data/atax"
# NODE_NAME="xeon_e5_2630_v3_$(uname -n | cut -d. -f1)"
#
# mv ${APP_TARGET}/${NODE_NAME}_* /tmp/
#
# su ${USR} -c "mkdir -p ${USR_TARGET}"
# su ${USR} -c "mv /tmp/${NODE_NAME}_* ${USR_TARGET}"
