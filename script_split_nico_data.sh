#!/bin/bash
# Copyright (C) 2018  Vadym Gryshchuk (vadym.gryshchuk@protonmail.com)
# Date created: 29 July 2018
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ==============================================================================

mkdir NICO_Vision_train_test
mkdir ./NICO_Vision_train_test/train
mkdir ./NICO_Vision_train_test/test

# Split NICO Vision into train and test sets
python ./split_data_nico.py \
--input_dataset=./NICO_Vision \
--output_train=./NICO_Vision_train_test/train/ \
--output_test=./NICO_Vision_train_test/test/ \
--session_test=2 \