import numpy as np
import pandas as pd

def base_to_idx(sequence, sequence_length):
    idcs = np.arange(sequence_length)
    for i in range(0, sequence_length):
        base = sequence[i]
        if base == 'A':
            idcs[i] = 0
        elif base == 'C':
            idcs[i] = 1
        elif base == 'G':
            idcs[i] = 2
        elif base == 'T':
            idcs[i] = 3
        elif base == 'N':
            raise AssertionError("Ran into Ns")
        else:
            raise AssertionError("Cannot handle base: " + base)
    return idcs

def do_one_hot_encoding_from_fa(seq_fasta, f=base_to_idx):
    seq_len = len(seq_fasta.iloc[1][0])
    X = np.zeros((len(seq_fasta)//2, seq_len, 4))
    for s in range(0, len(seq_fasta)//2):
        # only every second line in a fasta contains the sequence
        sfa = ((s+1)*2)-1
        seq = seq_fasta.iloc[sfa][0]
        for b in range(0, seq_len):
            X[s][b][f(seq, seq_len)[b]] = 1
    return X
