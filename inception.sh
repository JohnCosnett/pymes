#!/bin/zsh

# location of where to place the Inception v3 model
INCEPTION_MODEL_DIR=$HOME/inception-v3-model
mkdir -p ${INCEPTION_MODEL_DIR}
cd ${INCEPTION_MODEL_DIR}

# download the Inception v3 model
curl -O http://download.tensorflow.org/models/image/imagenet/inception-v3-2016-03-01.tar.gz
tar xzf inception-v3-2016-03-01.tar.gz

# this will create a directory called inception-v3 which contains the following files.
> ls inception-v3
README.txt
checkpoint
model.ckpt-157585
