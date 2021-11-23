# python
### pandas
#### read from clipboard
```
pd.read_clipboard(sep=',')
```
### tensorflow
#### GPUs available
```
import tensorflow as tf
print("Num GPUs Available: ", len(tf.config.experimental.list_physical_devices('GPU')))
```
