#! /bin/bash

apt-get install -y python-rpy2 r-cran-car
Rscript -e 'install.packages(c("AlgDesign", "rsm", "dplyr", "quantreg", "DiceKriging", "DiceDesign", "tibble", "randtoolbox", "stringr", "foreach", "doParallel", "rgenoud"), repos="https://cran.rstudio.com")'
pip install dataset

CLONE_TARGET="/root/dlmt_spapt_experiments"

echo "Updating target data directory"

if [ -d "$CLONE_TARGET" ]; then
    git -C ${CLONE_TARGET} pull
else
    git clone --depth 1 https://github.com/phrb/dlmt_spapt_experiments.git
fi

USR="pbruel"
USR_TARGET="/home/${USR}/dlmt_spapt_experiments/data/tests/gpr_sobol_v4/bicgkernel"
NODE_NAME="xeon_e5_2630_v3_$(uname -n | cut -d. -f1)"

APP_TARGET="/root/dlmt_spapt_experiments/orio/testsuite/SPAPT/bicgkernel"
cd $APP_TARGET

# ./run_multiple.sh 1 bicgkernel.c
# ./run_multiple.sh 1 bicgkernel_no_binary.c
./run_multiple.sh 1 bicgkernel_gpr.c
# ./run_multiple.sh 1 bicgkernel_random.c

mv ${APP_TARGET}/${NODE_NAME}_* /tmp/

su ${USR} -c "mkdir -p ${USR_TARGET}"
su ${USR} -c "mv /tmp/${NODE_NAME}_* ${USR_TARGET}"
