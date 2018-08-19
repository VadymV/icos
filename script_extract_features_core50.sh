#!/bin/bash
# MIT License
#
# Copyright (C) 2018  Vadym Gryshchuk (vadym.gryshchuk@protonmail.com)
# Date created: 29 July 2018
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to conditions.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
# WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS
# OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
# TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

mkdir ./CORe50_all
find ./CORe50 -name '*.jpg' -exec cp --backup=numbered '{}' ./CORe50_all/ \;

# Extract features
python ./TF_FeatureExtraction/example_feat_extract.py \
--network resnet_v1_50 \
--checkpoint ./pretrainedModels/ResNet50/model.ckpt-56127 \
--image_path ./ICWT_all/ \
--out_features_h5 ./reduced_features.h5 \
--out_features_csv ./reduced_features.csv \
--layer_names Features_3d \
--batch_size 64 \
--num_classes 50 \
--dataset_name CORe50 \