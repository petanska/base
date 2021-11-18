#params is a dictionary that has to be defined outside the function

def build_model(params=params):
    
    import keras
    import keras.layers as kl
    from keras.layers import BatchNormalization
    from keras.layers.core import Activation, Flatten, Dropout
    from keras.layers.convolutional import MaxPooling1D
    from keras import models
    from keras.optimizers import Adam
    
    num_filters = params['num_filters']
    num_filters2 = params['num_filters2']
    kernel_size1 = params['kernel_size1']
    lr = params['lr']
    dropout_prob = params['dropout_prob']
    n_conv_layer = params['n_conv_layer']
    n_add_layer = params['n_add_layer']
    params['n_add_layer']
    
    # body
    input = kl.Input(shape=(601, 4))
    x = kl.Conv1D(num_filters, kernel_size=kernel_size1,
                  padding=params['pad'],
                  name='Conv1D_1st')(input)
    x = BatchNormalization()(x)
    x = Activation('relu')(x)
    x = MaxPooling1D(2)(x)

    for i in range(1, n_conv_layer):
        x = kl.Conv1D(params['num_filters'+str(i+1)],
                      kernel_size=params['kernel_size'+str(i+1)],
                      padding=params['pad'],
                      name=str('Conv1D_'+str(i+1)))(x)
        x = BatchNormalization()(x)
        x = Activation('relu')(x)
        x = MaxPooling1D(2)(x)
    
    x = Flatten()(x)
    # dense layers
    for i in range(0, n_add_layer):
        x = kl.Dense(params['dense_neurons'+str(i+1)],
                     name=str('Dense_'+str(i+1)))(x)
        x = BatchNormalization()(x)
        x = Activation('relu')(x)
        x = Dropout(dropout_prob)(x)
    bottleneck = x
    
    # heads per task
    tasks = ['A', 'B', 'C']
    outputs = []
    for task in tasks:
        outputs.append(kl.Dense(1, activation='linear', name=str('Dense_' + task))(bottleneck))

    model = keras.models.Model([input], outputs)
    model.compile(keras.optimizers.Adam(lr=lr),
                  loss=['mse', 'mse', 'mse'], # loss
                  loss_weights=[1, 1, 1], # loss weigths to balance
                  metrics=[pearson]) # additional track metric

    return model, params

