execute command with specifying GPU device:

```
 CUDA_VISIBLE_DEVICES=2  python3   train_lstm.py 
```
If you want to define in code: use 
```
import os
os.environ["CUDA_VISIBLE_DEVICES"]="0,1"
```
