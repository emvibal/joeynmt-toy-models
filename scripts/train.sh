#! /bin/bash

scripts=`dirname "$0"`
base=$scripts/..

models=$base/models
configs=$base/configs

mkdir -p $models

num_threads=4
device=0

# measure time

SECONDS=0

#train word level:
#CUDA_VISIBLE_DEVICES=$device OMP_NUM_THREADS=$num_threads python -m joeynmt train $configs/low_resource_example_word_level.yaml

# train bpe:
#CUDA_VISIBLE_DEVICES=$device OMP_NUM_THREADS=$num_threads python -m joeynmt train $configs/d.yaml
#CUDA_VISIBLE_DEVICES=$device OMP_NUM_THREADS=$num_threads python -m joeynmt train $configs/low_resource_example_bpe_level_vocabsize2000.yaml
#CUDA_VISIBLE_DEVICES=$device OMP_NUM_THREADS=$num_threads python -m joeynmt train $configs/low_resource_example_bpe_level_vocabsize5000.yaml
#CUDA_VISIBLE_DEVICES=$device OMP_NUM_THREADS=$num_threads python -m joeynmt train $configs/low_resource_example_bpe_level_vocabsize10000.yaml
CUDA_VISIBLE_DEVICES=$device OMP_NUM_THREADS=$num_threads python -m joeynmt train $configs/low_resource_example_bpe_level_vocabsize8000.yaml


echo "time taken:"
echo "$SECONDS seconds"

#shutdown