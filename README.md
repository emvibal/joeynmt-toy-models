# joeynmt-toy-models

This repo is just a collection of scripts showing how to install [JoeyNMT](https://github.com/joeynmt/joeynmt), preprocess
data, train and evaluate models.

# Requirements

- This only works on a Unix-like system, with bash.
- Python 3 must be installed on your system, i.e. the command `python3` must be available
- Make sure virtualenv is installed on your system. To install, e.g.

    `pip install virtualenv`

# Steps

Clone this repository in the desired place and check out the correct branch:

    git clone https://github.com/bricksdont/joeynmt-toy-models
    cd joeynmt-toy-models
    checkout ex4

Create a new virtualenv that uses Python 3. Please make sure to run this command outside of any virtual Python environment:

    ./scripts/make_virtualenv.sh

**Important**: Then activate the env by executing the `source` command that is output by the shell script above.

Download and install required software:

    ./scripts/download_install_packages.sh

Download and split data:

    ./scripts/download_split_data.sh

Preprocess data:

    ./scripts/preprocess.sh

Then finally train a model:

    ./scripts/train.sh

The training process can be interrupted at any time, and the best checkpoint will always be saved.

Evaluate a trained model with

    ./scripts/evaluate.sh


Documentation for Exercise 5 in Machine Translation

Language Pair: English and Italian

Translation Direction: English -> Italian (en->it)


Results of the automatic evaluation:
|      | use BPE   | vocabulary size | BLEU |
|------|-----------|-----------------|------|
| (a)  | no        | 2000            | 9.2  |
| (b)  | yes       | 2000            | 3.3  |
| (c)  | yes       | 5000            | 9.6  |
| (d)  | yes       | 8000            | 15.3 |

...

Translation quality (manual check):
...

Differences between the automatic evaluation findings and manual evaluation findings:
...

To retrace the steps I took in order to get the results mentioned above:

1) Clone this repository on a folder of your choice

        git clone https://github.com/bricksdont/joeynmt-toy-models

        cd joeynmt-toy-models

2) Go to the branch dedicated to exercise 5

        git checkout ex5

3) Install and activate a virtual environment

        ./scripts/make_virtualenv.sh

 -> After the running the script above, run the command that will be echoed on your terminal (source ...)

4) Download the the data for this exercise

        ./scripts/download data.sh

5) Subsample and tokenize the parallel training data 

Execute the python script found in the my_tools folder 

        python3 ./my_tools/prepare.py

Word Level Model
1) Duplicate the low_resource_example.yaml configugation and supply the parameters that only has a ? in them, except for  src_vocab: "?" and trg_vocab: "?". 

If you are using GPU make sure to set cuda:True

Make sure to change name:xxx

2) Train your model

    ./scripts/train.sh

Open the script above amd ke sure to uncomment the command to word level and comment out the ones for the other models before running.

3) Evaluate your model

    ./scripts/evaluate.sh

Open the script make sure to use write the name of the model and also rename the outfiles before running the script.



BPE Level
1) Learn and apply BPE and build a single vocab file

    ./my_tools/bpe_tools.sh

Open the script and set the required filenames before running.

2) Duplicate the low_resource_example.yaml configugation and supply the parameters that only has a ? in them, except for  src_voc_limit:  and trg_voc_limit: ? 

If you are using GPU make sure to set cuda:True

Make sure to change name:xxx

2) Train your model

    ./scripts/train.sh

Open the script above amd ke sure to uncomment the command to word level and comment out the ones for the other models before running.

3) Evaluate your model

    ./scripts/evaluate.sh

Open the script make sure to use write the name of the model and also rename the outfiles before running the script.





Impact of beam size on translation quality

The graph below has been generated from a Google spreadsheet where I recorded the results of my experiments.

![alt text](https://github.com/emvibal/joeynmt-toy-models/blob/ex5/BLEU%20vs.%20Beam%20size.png)