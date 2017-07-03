#!/bin/zsh
# location of where to place the flowers data
FLOWERS_DATA_DIR=/tmp/flowers-data/

# build the preprocessing script.
cd ~/cube_0/models/inception
bazel build //inception:download_and_preprocess_flowers

# run it
bazel-bin/inception/download_and_preprocess_flowers "${FLOWERS_DATA_DIR}"
