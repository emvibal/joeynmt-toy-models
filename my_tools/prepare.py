import random
from sacremoses import MosesTokenizer
import os

'''
quick n dirty pre processing script in python
'''
#it might not be that "pythonic"

NUM_LINES = 100000

def main():
    #faster to hardcode.
    input1= '../data/train.en-it.en'
    input2= '../data/train.en-it.it'
    tokenize1 = '../data/dev.en-it.en'
    tokenize2 = '../data/dev.en-it.it'
    tokenize3 = '../data/test.en-it.en'
    tokenize4  = '../data/test.en-it.it'
    lang1 = 'en'
    lang2 = 'it'

    filename1, filename2 = sub_sample(input1,input2)
    tokenizer(filename1,lang1)
    tokenizer(filename2,lang2)

    tokenizer(tokenize1,lang1)
    tokenizer(tokenize2,lang2)
    tokenizer(tokenize3,lang1)
    tokenizer(tokenize4,lang2)

#step 1.
def sub_sample(in1, in2):

    file_exists(in1)
    file_exists(in1)
    
    len_1 = file_len(in1)
    len_2 = file_len(in2)
    if len_1 != len_2:
        print('something is wrong. files are not the same size')
        exit()
    
    print('length: {}'.format(len_1))
    my_lines = random.sample(range(0,len_1),NUM_LINES)
    my_lines.sort()
    
    filename1 = save_lines(in1,my_lines)
    filename2 = save_lines(in2,my_lines)
    return filename1,filename2

#step 2
def tokenizer(filename,lang):
    print("tokenizing {}".format(filename))
    tokenizer = MosesTokenizer(lang=lang)
    all_tokens = []
    with open(filename,'r') as f:
        for line in f:
            t = tokenizer.tokenize(line)
            all_tokens.append(t)
    outputpath = filename[:-3] + '.tokenized' + filename[-3:]
    with open(outputpath,'w',encoding='utf8') as out:
        for line_list in all_tokens:
            for token in line_list:
                out.write(token+' ')
            out.write('\n')
    return all_tokens


def file_exists(filepath):
    if not os.path.isfile(filepath):
        print('file not found :{}'.format(filepath))
        exit()

#https://stackoverflow.com/questions/845058/how-to-get-line-count-of-a-large-file-cheaply-in-python
def file_len(fname):
    '''
    return file length
    '''
    with open(fname) as f:
        for i, _ in enumerate(f):
            pass
    return i + 1


#https://stackoverflow.com/questions/2081836/reading-specific-lines-only/2081880#2081880
def save_lines(inputpath,mylines):
    mylines_index = 0
    num = mylines[mylines_index]
    inputpath
    outputpath = inputpath[:-3] + '.subsample' + inputpath[-3:]
    with open(inputpath,'r') as fp, open(outputpath,'w',encoding='utf8') as out:
        for i, line in enumerate(fp):
            if i == num:
                try:
                    mylines_index += 1
                    num = mylines[mylines_index]
                    out.write(line)
                except :
                    #print('end')
                    #print(e)
                    break
    #lazy solution
    return outputpath


if __name__ == '__main__':
    main()
