#!/bin/bash
#eu-west-1: ami-cd1ffab4
function pause(){
   read -p "$*"
}
 


#pause 'Press [Enter] key to continue...'


# location of where to place the flowers data
FLOWERS_DATA_DIR=/tmp/flowers-data/
FLOWERS_DATA_DIR2=$HOME/flowers-data/
#pause '___________--1'


# build the preprocessing script.
cd ~/cube_0/models/inception
#pause '___________--2'

sudo bazel build //inception:download_and_preprocess_flowers
pause '___________--3'
# run it
sudo bazel-bin/inception/download_and_preprocess_flowers "${FLOWERS_DATA_DIR2}"
pause '___________--4'



# location of where to place the Inception v3 model
INCEPTION_MODEL_DIR=$HOME/inception-v3-model
pause '___________--5'


mkdir -p ${INCEPTION_MODEL_DIR}
pause '___________--6'

cd ${INCEPTION_MODEL_DIR}
pause '___________--7'

# download the Inception v3 model
curl -O http://download.tensorflow.org/models/image/imagenet/inception-v3-2016-03-01.tar.gz
pause '___________--8'

tar xzf inception-v3-2016-03-01.tar.gz
pause '___________--9'

# this will create a directory called inception-v3 which contains the following files.
> ls inception-v3
pause '___________--10'
README.txt
pause '___________--11'
checkpoint
pause '___________--12'
model.ckpt-157585
pause '___________--13'




# Build the model. Note that we need to make sure the TensorFlow is ready to
# use before this as this command will not build TensorFlow.
cd ~/cube_0/models/inception
pause '___________--14'
sudo bazel build //inception:flowers_train
pause '___________--15'

# Path to the downloaded Inception-v3 model.
MODEL_PATH="${INCEPTION_MODEL_DIR}/inception-v3/model.ckpt-157585"
pause '___________--16'

# Directory where the flowers data resides.
FLOWERS_DATA_DIR=/tmp/flowers-data/
FLOWERS_DATA_DIR2=$HOME/flowers-data/
pause '___________--17'

# Directory where to save the checkpoint and events files.
TRAIN_DIR=/tmp/flowers_train/
TRAIN_DIR2=$HOME/flowers_train/
pause '___________--18'

# Run the fine-tuning on the flowers data set starting from the pre-trained
# Imagenet-v3 model.
sudo bazel-bin/inception/flowers_train \
  --train_dir="${TRAIN_DIR2}" \
  --data_dir="${FLOWERS_DATA_DIR2}" \
  --pretrained_model_checkpoint_path="${MODEL_PATH}" \
  --fine_tune=True \
  --initial_learning_rate=0.001 \
  --input_queue_memory_factor=1

pause '___________--19'
