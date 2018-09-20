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

USR="pbruel"
USR_TARGET="/home/${USR}/dlmt_spapt_experiments/data/tests/fdtd/fdtd_3x_lin_cub_quad"
NODE_NAME="xeon_e5_2630_v3_$(uname -n | cut -d. -f1)"

APP_TARGET="/root/dlmt_spapt_experiments/orio/testsuite/SPAPT/fdtd"
cd $APP_TARGET

./run_multiple.sh 1 fdtd-2d.c

mv ${APP_TARGET}/${NODE_NAME}_* /tmp/

su ${USR} -c "mkdir -p ${USR_TARGET}"
su ${USR} -c "mv /tmp/${NODE_NAME}_* ${USR_TARGET}"

./run_multiple.sh 1 fdtd-2d_random.c

mv ${APP_TARGET}/${NODE_NAME}_* /tmp/

su ${USR} -c "mkdir -p ${USR_TARGET}"
su ${USR} -c "mv /tmp/${NODE_NAME}_* ${USR_TARGET}"

# ./run_multiple.sh 2 atax2.src1_sima.c
#
# mv ${APP_TARGET}/${NODE_NAME}_* /tmp/
#
# su ${USR} -c "mkdir -p ${USR_TARGET}"
# su ${USR} -c "mv /tmp/${NODE_NAME}_* ${USR_TARGET}"
#
# ./run_multiple.sh 2 atax2.src1_rsl.c
#
# mv ${APP_TARGET}/${NODE_NAME}_* /tmp/
#
# su ${USR} -c "mkdir -p ${USR_TARGET}"
# su ${USR} -c "mv /tmp/${NODE_NAME}_* ${USR_TARGET}"
#
# ./run_multiple.sh 2 atax2.src1_simp.c
#
# mv ${APP_TARGET}/${NODE_NAME}_* /tmp/
#
# su ${USR} -c "mkdir -p ${USR_TARGET}"
# su ${USR} -c "mv /tmp/${NODE_NAME}_* ${USR_TARGET}"