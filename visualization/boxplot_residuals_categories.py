import numpy as np
import pandas as pd
from scipy import stats
import seaborn as sns
import matplotlib.pyplot as plt

def boxplot_residuals_categories(y_true, y_pred, info, cat, Title):
    if cat == 'class':
        order = ['A', 'B', 'C', 'D']
        color = dict(A='grey', B='blue', C='orange', D='green')
    y_res = y_pred - y_true
    res = pd.DataFrame(y_res, columns = ['res'])
    df = pd.concat([info, res], axis=1)
    #df = df.fillna('none')
    sns.set(font_scale=2)
    fig = plt.figure(figsize=(10, 10))
    ax = sns.boxplot(x = cat, y = 'res', data = df, order = order, palette = color)
    ax.set_xticklabels(ax.get_xticklabels(),rotation=30)
    ax.axhline(0, ls='--')
    plt.xlabel(cat)
    plt.ylabel('')
    plt.title(Title)
    return
