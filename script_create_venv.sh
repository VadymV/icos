#!/bin/bash

# get dir
CALLDIR=`pwd`
cd "`dirname "$BASH_SOURCE"`"
WORKDIR=$(pwd)
cd "$CALLDIR"
VIRTUALENV="virtualenv"
echo Running at: "$WORKDIR"

VIRTUALENVDIR="ICOS_VENV"
if [ $# -eq 1 ]
  then
    VIRTUALENVDIR="$1"
fi
echo Virtual environment directory: "$VIRTUALENVDIR"

cd

#virtualenv setup
echo "Checking for virtualenv"
if [ -d ".$VIRTUALENVDIR/" ]; then
    echo "Existing virtualenv found"
else
  echo "No virtualenv found - setting up new virtualenv"
  # Test for virtualenv
  if ! [ -x "$(command -v virtualenv)" ]; then
    pip install --user virtualenv
    VIRTUALENV=".local/bin/virtualenv"
  fi
  $VIRTUALENV -p /usr/bin/python3 --system-site-packages ~/.$VIRTUALENVDIR
fi
echo "Activating virtualenv"
source ~/.$VIRTUALENVDIR/bin/activate

#install python packages
if [ $VIRTUAL_ENV == ~/.$VIRTUALENVDIR ]; then
  echo Please place the requirements.txt here:
  pwd
  echo "Checking python packages"
  pip install -r requirements.txt
  pip install h5py
  pip install numba
else
  echo "Activation failed - skipping python package installations"
fi


