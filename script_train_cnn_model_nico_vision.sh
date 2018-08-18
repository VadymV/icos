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

mkdir ./NICO_TFRecords
mkdir ./training_directory
mkdir ./checkpoint

cd ./checkpoint
wget http://download.tensorflow.org/models/resnet_v1_50_2016_08_28.tar.gz
tar -xvf resnet_v1_50_2016_08_28.tar.gz
rm resnet_v1_50_2016_08_28.tar.gz
cd ..

# Convert data to TFRecords.
python ./models/research/slim/convert_data.py \
--dataset_name=nico \
--training_dataset_dir=./NICO_Vision_train_test/train \
--testing_dataset_dir=./NICO_Vision_train_test/test \
--convert_dataset_dir=./NICO_TFRecords \

# Train the model.
python ./models/research/slim/train_image_classifier.py \
--train_dir=./training_directory \
--dataset_dir=./NICO_TFRecords \
--dataset_name=nico \
--dataset_split_name=train \
--model_name=resnet_v1_50 \
--checkpoint_path=./checkpoint/resnet_v1_50.ckpt \
--checkpoint_exclude_scopes=resnet_v1_50/logits,resnet_v1_50/Conv2d_features \
--trainable_scopes=resnet_v1_50/logits,resnet_v1_50/Conv2d_features \
--max_number_of_steps=3000 \
--batch_size=32 \
--learning_rate=0.01 \
--save_interval_secs=600 \
--save_summaries_secs=600 \
--log_every_n_steps=100 \
--optimizer=rmsprop \
--weight_decay=0.00004 \

# Evaluate the model.
python ./models/research/slim/eval_image_classifier.py \
--checkpoint_path=./training_directory \
--eval_dir=./training_directory \
--dataset_name=nico \
--dataset_split_name=validation \
--dataset_dir=./NICO_TFRecords \
--model_name=resnet_v1_50 \



