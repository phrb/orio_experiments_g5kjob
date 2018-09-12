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

USR_TARGET="/home/${USR}/dlmt_spapt_experiments/data/tests/adi/adi1_cubic_quad_big_model"
APP_TARGET="/root/dlmt_spapt_experiments/orio/testsuite/SPAPT/adi"
cd $APP_TARGET

# ./run_multiple.sh 1 adi.ancc.src1.c
#
# USR="pbruel"
# NODE_NAME="xeon_e5_2630_v3_$(uname -n | cut -d. -f1)"
#
# mv ${APP_TARGET}/${NODE_NAME}_* /tmp/
#
# su ${USR} -c "mkdir -p ${USR_TARGET}"
# su ${USR} -c "mv /tmp/${NODE_NAME}_* ${USR_TARGET}"

./run_multiple.sh 1 adi.ancc.src1_random.c

USR="pbruel"
NODE_NAME="xeon_e5_2630_v3_$(uname -n | cut -d. -f1)"

cp -r ${APP_TARGET}/${NODE_NAME}_* /tmp/

su ${USR} -c "mkdir -p ${USR_TARGET}"
su ${USR} -c "cp -r /tmp/${NODE_NAME}_* ${USR_TARGET}"

./run_multiple.sh 1 adi.ancc.src1_sima.c

USR="pbruel"
NODE_NAME="xeon_e5_2630_v3_$(uname -n | cut -d. -f1)"

cp -r ${APP_TARGET}/${NODE_NAME}_* /tmp/

su ${USR} -c "mkdir -p ${USR_TARGET}"
su ${USR} -c "cp -r /tmp/${NODE_NAME}_* ${USR_TARGET}"

# ./run_multiple.sh 1 adi.ancc.src1_rsl.c
#
# USR="pbruel"
# NODE_NAME="xeon_e5_2630_v3_$(uname -n | cut -d. -f1)"
#
# cp -r ${APP_TARGET}/${NODE_NAME}_* /tmp/
#
# su ${USR} -c "mkdir -p ${USR_TARGET}"
# su ${USR} -c "cp -r /tmp/${NODE_NAME}_* ${USR_TARGET}"
#
# ./run_multiple.sh 1 adi.ancc.src1_simp.c
#
# USR="pbruel"
# NODE_NAME="xeon_e5_2630_v3_$(uname -n | cut -d. -f1)"
#
# cp -r ${APP_TARGET}/${NODE_NAME}_* /tmp/
#
# su ${USR} -c "mkdir -p ${USR_TARGET}"
# su ${USR} -c "cp -r /tmp/${NODE_NAME}_* ${USR_TARGET}"
