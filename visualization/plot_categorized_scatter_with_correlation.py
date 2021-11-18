import numpy as np
import pandas as pd
from scipy import stats
import seaborn as sns
import matplotlib.pyplot as plt

def plot_scatter_with_categories(y_true, y_pred, info, cat, Title):
    if cat == 'class':
        order = ['negative', 'Other_DHSs', 'Other_enhancers', 'positive_and_flanks']
        color = dict(negative='grey', Other_DHSs='blue', Other_enhancers='orange', positive_and_flanks='green')
    obs = pd.DataFrame(y_true, columns = ['obs'])
    pred = pd.DataFrame(y_pred, columns = ['pred'])
    df = pd.concat([info, obs, pred], axis=1)
    #df = df.fillna('none')
    sns.set(font_scale=2)
    fig = plt.figure(figsize=(10, 10))
    ax = sns.lmplot(x = 'obs', y = 'pred', fit_reg = False, data = df, hue = cat, hue_order = order, palette = color, legend = False, height=10)
    plt.xlabel('Measured activity [log2]')
    plt.ylabel('Predicted activity [log2]')
    plt.title(Title)
    plt.xlim((int(df['obs'].min() - 1), int(df['obs'].max() + 1)))
    plt.ylim((int(df['pred'].min() - 1), int(df['pred'].max() + 1)))
    plt.legend(loc = 'upper left')
    return
