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
4. Create a virtual environment: `bash script_create_venv.sh`
  
# Extract features from NICO Vision 
All commands are run from the main directory:
1. Create a new directory `mkdir NICO_Vision_all`
2. Run: `find ./NICO_Vision -name '*.jpg' -exec cp --backup=numbered '{}' ./NICO_Vision_all/ \;`
3. Activate the virtual environment: `source /home/<username>/.ICOS_VENV/bin/activate`
4. Run: `export PYTHONPATH=/pathToMainDirectory/models/research/slim/:$PYTHONPATH`
5. Run: `python ./TF_FeatureExtraction/example_feat_extract.py`

# Implemented features:

1. Extract features from the NICO dataset.

