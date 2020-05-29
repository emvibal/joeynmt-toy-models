# joeynmt-toy-models

This repo is just a collection of scripts showing how to install [JoeyNMT](https://github.com/joeynmt/joeynmt), preprocess
data, train and evaluate models.

# Requirements

- This only works on a Unix-like system, with bash.
- Python 3 must be installed on your system, i.e. the command `python3` must be available
- Make sure virtualenv is installed on your system. To install, e.g.

    `pip install virtualenv`



**Documentation for Exercise 5 in Machine Translation**

Language Pair: English and Italian

Translation Direction: English -> Italian (en->it)


Results of the automatic evaluation:
|      | use BPE   | vocabulary size | BLEU |
|------|-----------|-----------------|------|
| (a)  | no        | 2000            | 9.2  |
| (b)  | yes       | 2000            | 3.3  |
| (c)  | yes       | 5000            | 9.6  |
| (d)  | yes       | 8000            | 15.3 |

The model that performed best was the one with BPE with a vocabulary size of 8000. It got a score of 15.3 on BLEU.

Translation quality (manual check):

Source

    Several years ago here at TED, Peter Skillman introduced a design challenge called the marshmallow challenge.
    And the idea's pretty simple:
    Teams of four have to build the tallest free-standing structure out of 20 sticks of spaghetti, one yard of tape, one yard of string and a marshmallow.
    The marshmallow has to be on top.
    And, though it seems really simple, it's actually pretty hard because it forces people to collaborate very quickly.


Reference

    Parecchi anni fa, qui a TED, Petere Skillman  introdusse una sfida di progettazione  chiamata la sfida marshmallow.
    E l'idea è molto semplice.
    Gruppi di quattro persone devono costruire la più alta torre possibile che si regga in piedi da sola,  utilizzando 20 spaghetti,  un metro di nastro adesivo, un metro di spago  e un marshmallow.
    Il marshmallow deve essere piazzato in cima alla torre.
    E, anche se sembra molto semplice, di fatto è piuttosto difficile,  perché costringe le persone  a collaborare molto rapidamente.



The first 5 lines of the translation of the models I trained are included below in order to show a concrete example.

Word Level

    <unk> anni fa qui a TED, <unk> <unk> <unk> una sfida <unk> <unk> la sfida <unk>.
    E l'idea è molto semplice.
    <unk> di quattro devono costruire la struttura <unk> <unk> da 20 <unk> di <unk>, una <unk> di <unk>, un <unk> di <unk> e un <unk>.
    La <unk> deve essere in cima.
    E, se sembra veramente semplice, è davvero difficile perché <unk> le persone ad <unk> molto rapidamente.


BPE Level

Vocab Size 2000

    Molti anni fa, il TED fa, Dio ha chiamato un progetto chiamato ".
    E il punto è il problema.
    Alcune di voi si trova in un paio di dollari, un paio di anni, un po 'di un momento di vista, un po' di un banco.
    Il sacco di cui si può fare.
    Ed è molto semplice, è perché le persone che hanno bisogno di più.

Vocab Size 5000

    Signore di anni fa qui a TED, Paul Street ha messo una sfida chiamata chiamata la sfida chiamata la sfida di una sfida.
    E l'idea è piuttosto semplice.
    Molte di quattro di quattro hanno iniziato a costruire la struttura di una struttura di un certo senso di plastica di 20, uno di un aereo, un topo di tascolare e un tessore di piena.
    La polizia si ha dovuto essere in basso.
    E se sembra molto semplice, è molto difficile perché la gente di collaborare molto velocemente.

Vocab Size 8000

    Ensieme anni fa qui a TED, Peter Sick ha introdotto una sfida di design chiamata la sfida di marshie.
    E l'idea è semplice.
    I quattro hanno bisogno di costruire la struttura di una piattaforma di 20 sani, uno o una tezza di togi, uno ylitro.
    Il marpeggio è in cima.
    E poi sembra molto semplice, è molto difficile perché le forze hanno collaborato molto rapidamente.


Of the five lines sample, I would say that only sentence 2 has been translated correctly by 3 out of 4 models. The BPE model with a vocab size of 2000 did not translate sentence 2 correctly. For translators, the word level model would be the most helpful. It is easier to fill in missing words given a context than to correct a sentence that either doesn't make sense or contains wrong words (even non words in the target language).


Differences between the automatic evaluation findings and manual evaluation findings:

The automatic evaluation findings can be very misleading, in that a hypothesis receiving a  high score doesn't really mean that it is a good translation.

Take line 1 for example. "Several years ago" ("Parecchi anni fa" - reference "Un paio d'anni fa", "Qualche anno fa" - other possibile translations, based on my knowledge of the Italian language) has not been translated correctly by the best performing model while the word level model did not translate it at all. The one that comes closest to a good enough translation is the BPE model with a vocab size of 2000 ("Molti anni fa" which translates to "Many years ago")) and this model got the lowest score among all tested models.

The named entity "Peter Skillman" was also translated in the BPE models instead of being left alone especially because this is not a fictional text where there is some form of freedom in changing the names of fictional characters (e.g. Albus Dumbeldore is Albus Silente in the Italian translation of the Harry Potter books). The reference is also not that sound since it still used "Petere" instead of "Peter" (this one boils down to style and conventions followed by the translator, or it can also be a mistake).

The translations using BPE models also has a tendency to have recurring words: "Molte di quattro di quattro", "ha messo una sfida chiamata chiamata la sfida chiamata la sfida di una sfida.". 

Looking at just phrases and a very few sentences is not enough to really say how good the translations are when one evaluates translation quality manually, but the few examples given above already give an idea on how translations can be rated differently depending on the type of evaluation conducted (automatic vs. manual). If I am to translate the text, I will still choose the word level model because it will take me less time. Among the BPE models, I would say that none of them can be viable for use, since thay don't really make sense and I can translate the text faster from scratch.

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





**Impact of beam size on translation quality**

The graph below has been generated from a Google spreadsheet where I recorded the results of my experiments.

![alt text](https://github.com/emvibal/joeynmt-toy-models/blob/ex5/BLEU%20vs.%20Beam%20size.png)


Based on the results of the experiments I conducted for this exercise, I will be using a beam size of 3 because it achieved the best BLEU score among the other beam sizes tried and it also takes less time and computng power to run compared to the other beam sizes that received the same score. 

The results of my experiments show that higher beam size leads to lower BLEU scores and that there is some form of a plateau from beam size 3 to 15 with just a few fluctuations within that range. 