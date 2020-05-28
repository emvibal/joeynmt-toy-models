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

... (all the prelimstuff goeas here)

Subsample parallel training data:

    Execute the python script found in the my_tools folder
        python3 ./my_tools/prepare.py



![alt text](https://github.com/emvibal/joeynmt-toy-models/blob/ex5/BLEU%20vs.%20Beam%20size.png)