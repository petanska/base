import seaborn as sns
import matplotlib.pyplot as plt

# model_hist needs to be loaded from json file, otherwise it doesnt work.
def plot_model_fitting(history):
    epochs = range(1, len(history['loss'])+1)
    sns.set(font_scale=2)
    
    sns.regplot(x=np.array(epochs), y=np.array(list(history['loss'].values())), fit_reg=False, scatter_kws={'s': 100}, label='Training')
    sns.regplot(x=np.array(epochs), y=np.array(list(history['val_loss'].values())), fit_reg=False, scatter_kws={'s': 100}, label='Validation')
    plt.xlim((0, len(history['loss'])+1))
    plt.ylim(ymin=0)
    plt.xlabel('Epochs')
    plt.ylabel('Loss')
    plt.title('Training and validation loss')
    plt.legend()
    
    return
