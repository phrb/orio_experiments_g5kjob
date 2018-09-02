#! /bin/bash

USR="pbruel"
APP_TARGET="dlmt_spapt_experiments/orio/testsuite/SPAPT/stencil3d"
USR_TARGET="/home/${USR}/dlmt_spapt_experiments/data/stencil3d"
NODE_NAME="xeon_e5_2630_v3_$(uname -n | cut -d. -f1)"

apt-get install -y python-rpy2 r-cran-car
Rscript -e 'install.packages("AlgDesign", repos="https://cran.rstudio.com")'
pip install dataset

git clone git@github.com:phrb/dlmt_spapt_experiments.git

cd $APP_TARGET
./run_multiple.sh 1 stencil3d.src1_linear.c

sudo -u ${USR} mkdir -p ${USR_TARGET}
sudo -u ${USR} mv ${APP_TARGET}/${NODE_NAME} ${USR_TARGET}
