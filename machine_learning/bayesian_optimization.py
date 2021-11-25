#!/users/peter.zoescher/.conda/envs/*/bin/python

#load libraries
from tensorflow import keras
from tensorflow.keras import layers,models
import tensorflow.keras.layers as kl
from kerastuner.tuners import RandomSearch, BayesianOptimization
from tensorflow.keras.optimizers import Adam
from tensorflow.keras.regularizers import l1_l2, l2
from tensorflow.keras.layers import BatchNormalization, InputLayer, Input, GlobalAvgPool1D, Dropout, Reshape, Dense, Activation, Flatten, Conv1D, MaxPooling1D
from tensorflow.keras.models import Sequential
from tensorflow.keras.optimizers import Adam
from tensorflow.keras.callbacks import EarlyStopping, History
from tensorflow.nn import leaky_relu
import pandas as pd
import numpy as np
import os

#set the resources
import tensorflow as tf
gpu_devices = tf.config.experimental.list_physical_devices('GPU')
for device in gpu_devices:
	    tf.config.experimental.set_memory_growth(device, True)

#load sequences and activity
os.chdir('')
os.getcwd()

X_trn = np.load('data/train_seqs_input.npy')
y_trn = list(np.load('data/train_acts_input.npy'))
X_val = np.load('data/val_seqs_input.npy')
y_val = list(np.load('data/val_acts_input.npy'))


#build model
print("\nBuild model\n")

#workaround for leaky relu
def lrelu(x):
    return leaky_relu(x, alpha = 0.01)

def shuffle_model(hp):
    dropout = hp.Choice('dropout', values = [0.3, 0.4, 0.5], default = 0.3)
    batchNorm = hp.Choice('batchNorm', values = ['yes', 'no'], default = 'yes')
    pad = 'same'
    act = hp.Choice('activation', values = ['relu', 'elu', 'lrelu'], default = 'elu')
    n_convs = hp.Choice('Conv_layers', values = [1, 4, 8, 12], default = 4)
    dense = hp.Choice('dense', values = [0, 1, 2], default = 1)
    nodes = hp.Choice('nodes', values = [32, 128, 256], default = 256)

    #body
    input = kl.Input(shape = (133, 4))
    x = kl.Conv1D(hp.Choice('Filters_1', values = [64, 128, 256], default = 128),
                  kernel_size = hp.Choice('kernel_1', values = [6, 12, 18, 24], default = 18),
                  padding = pad,
                  name = 'Conv1D_1')(input)
    if batchNorm == 'yes':
        x = BatchNormalization()(x)
    if act == 'lrelu':
        x = Activation(lrelu)(x)
    else:
        x = Activation(act)(x)

    for i in range(1, n_convs):
        x = kl.Conv1D(hp.Choice('Filters_' + str(i+1), values = [32, 64, 128], default = 128),
                      kernel_size = hp.Choice('kernel_' + str(i+1), values = [6, 12, 18, 24], default = 6),
                      padding = pad,
                      name = str('Conv1D_'+str(i+1)))(x)
        if batchNorm == 'yes':
            x = BatchNormalization()(x)
        if act == 'lrelu':
            x = Activation(lrelu)(x)
        else:
            x = Activation(act)(x)

    #dense layers
    if dense != 0:
        x = kl.Flatten()(x)

        for i in range(0, dense):
            x = kl.Dense(nodes,
                         name = str('Dense_'+str(i+1)))(x)
            if act == 'lrelu':
                x = Activation(lrelu)(x)
            else:
                x = Activation(act)(x)
            x = kl.Dropout(dropout)(x)
    bottleneck = x

    #heads per task
    tasks = ['p300', 'Chro']
    outputs = []
    for task in tasks:
        if dense == 0:
            cx = kl.GlobalAvgPool1D(name = str('GlobalAvgPool1D_' + task))(bottleneck)
        else:
            cx = bottleneck
        outputs.append(kl.Dense(1, activation='linear', name = str('Dense_' + task))(cx))

    #compile neural network
    model = models.Model([input], outputs)
    model.compile(keras.optimizers.Adam(lr = hp.Choice('learning_rate', values=[0.01, 0.004, 0.002, 0.001, 0.0005], default=0.001)), #optimizer
                  loss=['mse', 'mse'], #track metric
                  loss_weights = [1, 1] #loss weigths to balance
                  )
    return model


print('\nPrepare BayesianOptimization tuning')
tuner = BayesianOptimization(
    shuffle_model,
    objective = 'val_loss',
    max_trials = 1000,
    executions_per_trial = 2, #number of models that should be built and fit for each trial (each model configuration)
    directory = 'data/2021-06-01_Keras_tuner_bayesian_search',
    project_name = '2021-06-01_BayesianOptimization_search')

print(tuner.search_space_summary())

print('\nStart the search for the best hyperparameter configuration')
tuner.search(X_trn, y_trn,
             epochs = 50,
             batch_size = 128,
             validation_data = (X_val, y_val),
             callbacks = [tf.keras.callbacks.EarlyStopping('val_loss', patience = 5)],
             verbose = 0)

print('\nGet best model')
best_model = tuner.get_best_models(num_models=1)[0]

print('\nPrint a summary of the results:')
tuner.results_summary()
