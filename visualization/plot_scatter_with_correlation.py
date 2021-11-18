import numpy as np
import pandas as pd
from scipy import stats
import seaborn as sns
import matplotlib.pyplot as plt

def plot_scatter_with_correlation_test(y_true, y_pred, Title):
    sns.set(font_scale=2)
    fig = plt.figure(figsize=(10, 10))
    ax = sns.regplot(x=y_true, y=y_pred, fit_reg=False)
    ax.plot([-3, 14], [-3, 14], ls="--", c=".3")
    plt.xlabel('Measured ')
    plt.ylabel('Predicted ')
    plt.title(Title)
    plt.xlim((int(y_true.min()) - 1, int(y_true.max() + 1)))
    plt.ylim((int(y_pred.min() - 1), int(y_pred.max() + 1)))
    val = stats.pearsonr(y_true, y_pred)
    if val[1] < 10 ** -10:
        plt.text(0.1, 0.8, 'R=%.2f\n$p=<10^{-10}$\nN=%d' % (val[0], len(y_true)),
                 transform=ax.transAxes, size=30)
    else:
        plt.text(0.1, 0.8, 'R=%.2f\np=%.2E\nN=%d' % (val[0], val[1], len(y_true)),
                 transform=ax.transAxes, size=30)
    return
