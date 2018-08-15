#!/bin/bash

# Extract features
python ./TF_FeatureExtraction/example_feat_extract.py \
--network resnet_v1_50 \
--checkpoint ./pretrainedModels/ResNet50/model.ckpt-56127 \
--image_path ./NICO_Vision_all/ \
--out_features_h5 ./reduced_features.h5 \
--out_features_csv ./reduced_features.csv \
--layer_names Features_3d \
--batch_size 64 \
--num_classes 50 \
--dataset_name NICO \