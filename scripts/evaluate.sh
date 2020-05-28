#! /bin/bash

scripts=`dirname "$0"`
base=$scripts/..

data=$base/data
configs=$base/configs

translations=$base/translations

mkdir -p $translations

src=en
trg=it



# cloned from https://github.com/bricksdont/moses-scripts
MOSES=$base/tools/moses-scripts/scripts

num_threads=4
device=0

# measure time

SECONDS=0

for model_name in low_resource_example_bpe_level_vocabsize8000; do

    echo "###############################################################################"
    echo "model_name $model_name"

    translations_sub=$translations/$model_name/

    mkdir -p $translations_sub

    # translation with factors: lines in the input file have to be:
    # source tokens ||| factor tokens


    #CUDA_VISIBLE_DEVICES=$device OMP_NUM_THREADS=$num_threads python -m joeynmt translate $configs/$model_name.yaml < data/test.en-it.tokenized.$src > $translations_sub/test.word_level.tokenized.$model_name.$trg

    CUDA_VISIBLE_DEVICES=$device OMP_NUM_THREADS=$num_threads python -m joeynmt translate $configs/$model_name.yaml < data/test.en-it.tokenized.bpe.$src > $translations_sub/test.bpe_level.tokenized_w_bpe.beam_20.$model_name.$trg

    # undo BPE (this does not do anything: https://github.com/joeynmt/joeynmt/issues/920)

    cat $translations_sub/test.bpe_level.tokenized_w_bpe.beam_20.$model_name.$trg | sed 's/\@\@ //g' > $translations_sub/test.bpe_level.tokenized.beam_20.$model_name.$trg

    # undo truecasing

    #cat $translations_sub/test.truecased.$model_name.$trg | $MOSES/recaser/detruecase.perl > $translations_sub/test.tokenized.$model_name.$trg

    # undo tokenization

    cat $translations_sub/test.bpe_level.tokenized.beam_20.$model_name.$trg | $MOSES/tokenizer/detokenizer.perl -l $trg > $translations_sub/test.bpe_level.beam_20.$model_name.$trg

    # compute case-sensitive BLEU on detokenized data

    cat $translations_sub/test.bpe_level.beam_20.$model_name.$trg | sacrebleu $data/test.en-it.$trg

done

echo "time taken:"
echo "$SECONDS seconds"

