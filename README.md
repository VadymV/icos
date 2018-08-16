# ICOS
ICOS -Interactive Cognitive System for Lifelong Learning.  

# Setup instructions for Linux-based systems using a terminal:

1. Clone the following repositories into one directory (main):
  [Feature extraction](https://github.com/VadymV/TF_FeatureExtraction.git),
  [Tensorflow models](https://github.com/VadymV/models.git),
  [GWR extensions](https://github.com/VadymV/GWR-Extensions.git).
2. Put the content of this repository into the main directory.
3. Download the [NICO Vision dataset](https://drive.google.com/open?id=1LOfoakc0AVxaG1Y983y5XqY7Ip1Wj1Jr)
into the main directory and extract it.
4. Create a virtual environment: `bash script_create_venv.sh` Please be advised, that the file 'requirements.txt' may not be found. Follow the the terminal output and place it in the correct folder.
  
# Extract features from NICO Vision 
All commands are run from the main directory:
1. Run: `find ./NICO_Vision -name '*.jpg' -exec cp --backup=numbered '{}' ./NICO_Vision_all/ \;`
2. Activate the virtual environment: `source /home/<username>/.ICOS_VENV/bin/activate`
3. Run: `export PYTHONPATH=/pathToMainDirectory/models/research/slim/:$PYTHONPATH`
4. Run: `python ./TF_FeatureExtraction/example_feat_extract.py`

# Train a CNN model using the NICO Vision dataset
1. To train a CNN model it is important to set the number of output class labels and the number of images for train and test sets.
Default values are: 50, 10200 and 10200 respectively. If there is a need to change these settings, it can be done in the file 'nico.py',  the package 'datasets'. 
2. Split data into train and test sets. 
3. Prepare the data by converting it to TFRecords (protos). Run: `python ./models/research/slim/convert_data.py`

# Implemented features:

1. Extract features from the NICO dataset.

