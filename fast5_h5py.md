# h5py
```
import h5py
h5py.__version__
```

### print fast5 structure
```
def print_h5_keys_recursive(a, pad=''):
    if hasattr(a, 'keys'):
        for k in list(a.keys()):
            print(pad, k)
            if k in a:
                print_h5_keys_recursive(a[k], pad+'  ')
def print_h5_keys(f5):
    """ print an exemplary h5 key structure for the passed fast5 files """
    f = h5py.File(f5, 'r')
    first_read_name=next(iter(f.keys()))
    print_h5_keys_recursive(f[first_read_name])
```

### identify the Basecall_1D group with "Trace"
```
with h5py.File(f5, 'r') as f:
    # extract first read
    readID1 = str(list(f.keys())[0])
    try:
        BC_1D_grps = list(filter(lambda x: 'Basecall_1D_' in x, list(f[readID1]['Analyses'])))
        if len(BC_1D_grps) > 1:
            for i in BC_1D_grps:
                if 'Trace' in list(f[readID1]['Analyses'][i]['BaseCalled_template']):
                    print(i)
                else:
                    pass
        else:
            if 'Trace' in list(f[readID1]['Analyses'][BC_1D_grps[0]]['BaseCalled_template']):
                print(BC_1D_grps[0])
            else:
                print('did not find Trace information')
    except KeyError:
        print(f'Expected key "Analyses" but found {list(f[readID1].keys())}')
```

### count reads inside fast5
```
 with h5py.File(f5, 'r') as f:
    print(len(f.keys()))
```
