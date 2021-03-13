#! /bin/bash

apt-get install -y python-rpy2 r-cran-car
Rscript -e 'install.packages("devtools", repos="https://cran.rstudio.com")'
Rscript -e 'install_version("dplyr", version="0.8.5", repos = "http://cran.us.r-project.org")'
Rscript -e 'install.packages(c("future.apply", "AlgDesign", "rsm", "quantreg", "DiceKriging", "DiceDesign", "DiceOptim", "tibble", "randtoolbox", "stringr", "foreach", "doParallel", "rgenoud"), repos="https://cran.rstudio.com")'
pip install -Iv dataset==1.1.2

CLONE_TARGET="/root/dlmt_spapt_experiments"

echo "Updating target data directory"

if [ -d "$CLONE_TARGET" ]; then
    git -C ${CLONE_TARGET} pull
else
    git clone --depth 1 https://github.com/phrb/dlmt_spapt_experiments.git
fi

USR="pbruel"
USR_TARGET="/home/${USR}/dlmt_spapt_experiments/data/tests/dlmt_native/dgemv"
NODE_NAME="xeon_e5_2630_v3_$(uname -n | cut -d. -f1)"

APP_TARGET="/root/dlmt_spapt_experiments/orio/testsuite/SPAPT/dgemv3"
cd $APP_TARGET

# ./run_multiple.sh 1 dgemv.c
# ./run_multiple.sh 1 dgemv_random.c
./run_multiple.sh 1 dgemv_gpr.c

mv ${APP_TARGET}/${NODE_NAME}_* /tmp/

su ${USR} -c "mkdir -p ${USR_TARGET}"
su ${USR} -c "mv /tmp/${NODE_NAME}_* ${USR_TARGET}"
