#!/bin/bash
# Copyright (C) 2018  knowledgetechnologyuhh https://github.com/knowledgetechnologyuhh/NICO-software/blob/master/api/NICO-setup.bash
#
# Modifications copyright (C) 2018  Vadym Gryshchuk (vadym.gryshchuk@protonmail.com)
# Date modified: 29 July 2018
#
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

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
    echo "The existing virtualenv found"
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
  echo "Checking python packages"
  pip install -r $CALLDIR/requirements.txt
  pip install h5py
  pip install numba
  pip install matplotlib
  pip install sklearn
else
  echo "Activation failed - skipping python package installations"
fi



