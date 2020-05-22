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

Make sure to checkout the correct branch where the 2 news factors are added:

git checkout factors_complete

Then finally train a model:

    ./scripts/train.sh


    Specific changes made for Exercise 4:
    You can now try to train models with additional factors.
    Simply uncomment the method you would like to use on the train.ch script
    

The training process can be interrupted at any time, and the best checkpoint will always be saved.

Evaluate a trained model with

    ./scripts/evaluate.sh


Evaluation results:

                            Epochs	        Embedding Dimension	    BLEU Score
Baseline System	            3	            512	                    9.4
Added Embeddings	        3	            512	
Concatenated Embeddings	    3	            512	
