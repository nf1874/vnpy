#!/usr/bin/env bash

prefix=/usr/local

pip install --upgrade pip setuptools wheel

# Get and build ta-lib
function install-ta-lib()
{
    pushd /tmp
    curl https://pip.vnpy.com/colletion/ta-lib-0.4.0-src.tar.gz --output ta-lib-0.4.0-src.tar.gz
    tar -xf ta-lib-0.4.0-src.tar.gz
    cd ta-lib
    ./configure --prefix=$prefix
    make -j
    make install
    popd
}
function ta-lib-exists()
{
    ta-lib-config --libs > /dev/null
}
ta-lib-exists || install-ta-lib

# Preinstall ARM version packages
brew install PyQt5
brew install Sip
conda install -y numpy
conda install -y pandas
conda install -y psycopg2
conda install -y matplotlib

pip install ta-lib
pip install psycopg2-binary
pip install https://pip.vnpy.com/colletion/ibapi-9.76.1.tar.gz
pip install --extra-index-url https://rquser:ricequant99@py.ricequant.com/simple/ rqdatac
pip install tzlocal

# Install Python Modules
pip install -r requirements.txt

# Install local Chinese language environment
locale-gen zh_CN.GB18030

# Install vn.py
#$python -m pip install . $@
