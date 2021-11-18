import numpy as np
import pandas as pd
from scipy import stats
import seaborn as sns
import matplotlib.pyplot as plt

def plot_scatter_with_hex_bin_density(y_true, y_pred, Title):
    sns.set(font_scale=2)
    fig = plt.figure(figsize=(10, 10))
    ax = sns.jointplot(x=y_true, y=y_pred, kind="kde", shade=True) # kde is super slow with large data
    plt.xlabel('Measured ')
    plt.ylabel('Predicted ')
    plt.title(Title)
    val = stats.pearsonr(y_true, y_pred)
    return

