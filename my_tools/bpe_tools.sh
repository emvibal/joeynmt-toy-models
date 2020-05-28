#learn BPE

subword-nmt learn-joint-bpe-and-vocab \
-i "../data/train.en-it.subsample.tokenized.en" "../data/train.en-it.subsample.tokenized.it" \
--write-vocabulary "../data/vocab.size_8000.en-it.subsample.tokenized.bpe.en" "../data/vocab.size_8000.en-it.subsample.tokenized.bpe.it" \
-s 8000 --total-symbols -o "../data/vocab.size_8000.en-it.subsample.tokenized.bpe"

#Apply BPE model to data

#src-train
subword-nmt apply-bpe -c "../data/vocab.size_8000.en-it.subsample.tokenized.bpe" \
--vocabulary "../data/vocab.size_8000.en-it.subsample.tokenized.bpe.en" \
--vocabulary-threshold 10 \
< "../data/train.en-it.subsample.tokenized.en" > "../data/train.en-it.subsample.tokenized.bpe.en"

#trg-train
subword-nmt apply-bpe -c "../data/vocab.size_8000.en-it.subsample.tokenized.bpe" \
--vocabulary "../data/vocab.size_8000.en-it.subsample.tokenized.bpe.it" \
--vocabulary-threshold 10 \
< "../data/train.en-it.subsample.tokenized.it" > "../data/train.en-it.subsample.tokenized.bpe.it"

#src-dev
subword-nmt apply-bpe -c "../data/vocab.size_8000.en-it.subsample.tokenized.bpe" \
--vocabulary "../data/vocab.size_8000.en-it.subsample.tokenized.bpe.en" \
--vocabulary-threshold 10 \
< "../data/dev.en-it.tokenized.en" > "../data/dev.en-it.tokenized.bpe.en"

#trg-dev
subword-nmt apply-bpe -c "../data/vocab.size_8000.en-it.subsample.tokenized.bpe" \
--vocabulary "../data/vocab.size_8000.en-it.subsample.tokenized.bpe.it" \
--vocabulary-threshold 10 \
< "../data/dev.en-it.tokenized.it" > "../data/dev.en-it.tokenized.bpe.it"

#src-test
subword-nmt apply-bpe -c "../data/vocab.size_8000.en-it.subsample.tokenized.bpe" \
--vocabulary "../data/vocab.size_8000.en-it.subsample.tokenized.bpe.en" \
--vocabulary-threshold 10 \
< "../data/test.en-it.tokenized.en" > "../data/test.en-it.tokenized.bpe.en"

#trg-dev
subword-nmt apply-bpe -c "../data/vocab.size_8000.en-it.subsample.tokenized.bpe" \
--vocabulary "../data/vocab.size_8000.en-it.subsample.tokenized.bpe.it" \
--vocabulary-threshold 10 \
< "../data/test.en-it.tokenized.it" > "../data/test.en-it.tokenized.bpe.it"


#build single vocabfile
python3 ../tools/joeynmt/scripts/build_vocab.py \
"../data/vocab.size_8000.en-it.subsample.tokenized.bpe.en" "../data/vocab.size_8000.en-it.subsample.tokenized.bpe.it" \
--output_path "../data/en-it-bpe_vocab_size_8000.vocab"


#evaluate:

#word level:

