# ICOS
ICOS - Interactive Cognitive System for Lifelong Learning on a robotic platform.
It consists of two modules. The first one is a pretrained CNN model, which is used
to extract the features from the image sequences. The second one is the RGWR network, which
uses the extracted features as the input data for continuous object learning.

### Requirements:
1. GPU with installed drivers for CUDA >=9.0 and cuDNN >=7.
2. Python 3.
3. A Linux-based system (tested on an Ubuntu-based system).
All commands are run from the main directory.

# Setup instructions for Linux-based systems using a terminal:

1. Create the directory, which will contain all required files. This directory
will be referred as 'main' directory.
2. Clone the following repositories from the main directory:
  [Feature extraction](https://github.com/VadymV/TF_FeatureExtraction.git),
  [Tensorflow models](https://github.com/VadymV/models.git),
  [GWR extensions](https://github.com/VadymV/GWR-Extensions.git).
3. Put the content of this repository into the main directory.
4. Download the [NICO Vision dataset](https://drive.google.com/open?id=1LOfoakc0AVxaG1Y983y5XqY7Ip1Wj1Jr)
into the main directory and extract it.
5. Activate the virtual environment: `source ~/.ICOS_VENV/bin/activate`
6. Run: `export PYTHONPATH=/pathToMainDirectory/models/research/slim/:$PYTHONPATH`

# NICO Vision
## Extract the features
1. Run: `bash script_extract_features_nico_vision.sh`

## Object learning with RGWR network
1. Run `bash script_nico_learning.sh`

## Extra: train and evaluate a CNN model
1. To train a CNN model it is important to set the number of output class labels and the number of images for train and test sets.
Default values are 50, 10200 and 10200 respectively. If there is a need to change these settings, it can be done in the file 'nico.py',  the package 'datasets'.
2. Split data into train and test sets: `bash script_split_nico_data.sh`.
3. Convert data to TFRecords (protos), train and validate the CNN model:
`bash script_train_cnn_model_nico_vision.sh`

# ICWT
## Extract the features
1. Download the [ICWT dataset](https://robotology.github.io/iCubWorld/#icubworld-transformations-modal).
Extract all files and put category folders into one directory called 'ICWT' and place it into the main directory.
2. Run: `bash script_extract_features_icwt.sh`.
Depending on the CPU and HDD/SDD performance, this operation may take some time.


# CORe50
## Extract the features
1. Download the [CORe50 dataset](http://bias.csr.unibo.it/maltoni/download/core50/core50_128x128.zip).
Extract all files into one directory called 'CORe50' and put it into the main directory.
2. Run: `bash script_extract_features_core50.sh`