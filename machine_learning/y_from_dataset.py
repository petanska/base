import numpy as np
import pandas as pd

# Creates a list with two or more numpy arrays
def do_activity_array(act_file, assay, *assays):
    file_len = len(act_file)
    n_assays = len(assays)
    Y = []
    arr = np.empty((file_len, 1))
    for i in range(0, file_len):
        arr[i] = act_file.iloc[i][assay]
    Y.append(arr)
    for n in range(0, n_assays):
        arr_n = np.empty((file_len, 1))
        for i in range(0, file_len):
            arr_n[i] = act_file.iloc[i][assays[n]]
        Y.append(arr_n)
    return Y
