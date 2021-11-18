from keras.callbacks import EarlyStopping, History
from keras import backend as K

K.get_session().run(tf.local_variables_initializer())

history=model.fit(X_trn, y_trn,
                           validation_data=(X_val, y_val),
                           batch_size=params['batch_size'],
                           epochs=params['epochs'],
                           callbacks=[EarlyStopping(patience=params['early_stop'], monitor='val_loss', restore_best_weights=True), History()])
