#Additional metrics for model training:
from scipy.stats import spearmanr
import tensorflow as tf
def Spearman(y_true, y_pred):
     return (tf.py_function(spearmanr, [tf.cast(y_pred, tf.float32), 
                       tf.cast(y_true, tf.float32)], Tout = tf.float32))
    
#https://stackoverflow.com/questions/51625357/i-want-to-use-tensorflows-metricpearson-correlation-in-keras
def pearson(y_true, y_pred):
    return tf.contrib.metrics.streaming_pearson_correlation(y_pred, y_true)[1]
