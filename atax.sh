#! /bin/bash

apt-get install -y python-rpy2 r-cran-car
Rscript -e 'install.packages(c("future.apply", "AlgDesign", "rsm", "dplyr", "quantreg", "DiceKriging", "DiceDesign", "DiceOptim", "tibble", "randtoolbox", "stringr", "foreach", "doParallel", "rgenoud"), repos="https://cran.rstudio.com")'
pip install -Iv dataset==1.1.2

CLONE_TARGET="/root/dlmt_spapt_experiments"

echo "Updating target data directory"

if [ -d "$CLONE_TARGET" ]; then
    git -C ${CLONE_TARGET} pull
else
    git clone --depth 1 https://github.com/phrb/dlmt_spapt_experiments.git
fi

USR="pbruel"
USR_TARGET="/home/${USR}/dlmt_spapt_experiments/data/tests/rs_baseline/atax"
NODE_NAME="xeon_e5_2630_v3_$(uname -n | cut -d. -f1)"

APP_TARGET="/root/dlmt_spapt_experiments/orio/testsuite/SPAPT/atax"
cd $APP_TARGET

# ./run_multiple.sh 1 atax2.c
./run_multiple.sh 1 atax2_random.c
# ./run_multiple.sh 1 atax2_gpr.c

mv ${APP_TARGET}/${NODE_NAME}_* /tmp/

su ${USR} -c "mkdir -p ${USR_TARGET}"
su ${USR} -c "mv /tmp/${NODE_NAME}_* ${USR_TARGET}"
