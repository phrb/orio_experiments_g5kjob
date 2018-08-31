#! /bin/bash

apt-get install -y python-rpy2 r-cran-car
pip install dataset
Rscript -e 'install.packages("AlgDesign", repos="https://cran.rstudio.com")'

git clone git@github.com:phrb/orio_experiments.git
