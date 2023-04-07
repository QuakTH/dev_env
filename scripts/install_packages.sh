#!/bin/bash

set -e

conda config --add channels pytorch \
    --add channels conda-forge

conda config --set channel_priority strict

conda run --no-capture-output \
    -n dev mamba install -y pandas \
    numpy \
    scipy \
    scikit-learn \
    matplotlib \
    sqlalchemy \
    pymysql \
    pytorch

# install pytorchaudio via pip due to the package is not found on conda channels
conda run --no-capture-output \
    -n dev pip install torchaudio --no-cache-dir

conda clean -a
