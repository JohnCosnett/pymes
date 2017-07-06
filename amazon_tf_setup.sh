#!/bin/bash
#eu-west-1: ami-cd1ffab4
function pause(){
   read -p "$*"
}
 






FLOWERS_DATA_DIR=/tmp/flowers-data/
FLOWERS_DATA_DIR2=$HOME/flowers-data/



# build the preprocessing script.
cd ~/cube_0/models/inception


bazel build //inception:download_and_preprocess_flowers

# run it
bazel-bin/inception/download_and_preprocess_flowers "${FLOWERS_DATA_DIR2}"




# location of where to place the Inception v3 model
INCEPTION_MODEL_DIR=$HOME/inception-v3-model



mkdir -p ${INCEPTION_MODEL_DIR}


cd ${INCEPTION_MODEL_DIR}


# download the Inception v3 model
curl -O http://download.tensorflow.org/models/image/imagenet/inception-v3-2016-03-01.tar.gz


tar xzf inception-v3-2016-03-01.tar.gz






# Build the model. Note that we need to make sure the TensorFlow is ready to
# use before this as this command will not build TensorFlow.
cd ~/cube_0/models/inception

bazel build //inception:flowers_train


# Path to the downloaded Inception-v3 model.
MODEL_PATH="${INCEPTION_MODEL_DIR}/inception-v3/model.ckpt-157585"


# Directory where the flowers data resides.
FLOWERS_DATA_DIR=/tmp/flowers-data/
FLOWERS_DATA_DIR2=$HOME/flowers-data/


# Directory where to save the checkpoint and events files.
TRAIN_DIR=/tmp/flowers_train/
TRAIN_DIR2=$HOME/flowers_train/
pause '___________--ready, set train!'

# Run the fine-tuning on the flowers data set starting from the pre-trained
# Imagenet-v3 model.
bazel-bin/inception/flowers_train \
  --train_dir="${TRAIN_DIR2}" \
  --data_dir="${FLOWERS_DATA_DIR2}" \
  --pretrained_model_checkpoint_path="${MODEL_PATH}" \
  --fine_tune=True \
  --initial_learning_rate=0.001 \
  --input_queue_memory_factor=1


