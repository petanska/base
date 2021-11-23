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
len(tf.config.experimental.list_physical_devices('GPU'))
```
