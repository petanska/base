import numpy as np
import pandas as pd

# Doesnt work with one-hot-encoded. (Wold take ages anyway)
def X_y_info_comparison(x, y, info, dataset):
    if dataset == 'A':
        y_set  = 0
        info_c = 12
    elif dataset == 'B':
        y_set  = 1
        info_c = 13
    elif dataset == 'C':
        y_set  = 2
        info_c = 14
    else:
        raise AssertionError("Unknown dataset: Only 'Dev', 'Hk' and 'DHS' are applicable")
    if not len(x) == len(y[y_set]) == len(info):
        raise AssertionError("Unequal number of entries between X, y and info")
    file_length = len(info)
    for i in range(0, file_length):
        if x[0][i] == info['Sequence'][i]:
            pass
        else:
            print(f"Line {i}: Sequence doesn't match info")
            raise AssertionError("Sequence doesn't match info")
        if y[y_set][i] == info.iloc[:,info_c][i]:
            pass
        else:
            print(f"Line {i}: Activity doesn't match info")
            raise AssertionError("Activity doesn't match info")
    print('All good')
