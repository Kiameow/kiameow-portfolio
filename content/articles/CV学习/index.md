---
title: "CV学习"
description: "This description will be used for the article listing and search results on Google."
date: "2023-07-21"
banner:
  src: "../../images/kelly-sikkema-Hl3LUdyKRic-unsplash.jpg"
  alt: "image description"
  caption: 'Photo by <u><a href="https://unsplash.com/photos/Nc5Q_CEcY44">Florian Olivo</a></u>'
categories:
  - "CV"
  - "AI"
keywords:
  - "计算机视觉"
---

## Environment

### Toolkit1 -- Miniconda

Download -- from tuna source

### What Conda does

provides virtual environments for different projects, in order to avoid vesion confilct.

### Conda command

- <strong>conda env list</strong> : check all environments
- <strong>conda create -n your_env_name python=X.X</strong> : create a new environment
- <strong>conda activate your_env_name</strong> : enter your environment
- <strong>conda list</strong> : check all the package downloaded via conda
- <strong>conda install package_name[=X.X]</strong> : install \[specific version of\] package (not recommended)
- <strong>conda uninstall package_name</strong>: uninstall package
- <strong>conda deactivate</strong>: quit current environment
- <strong>conda remove -n your_env_name --all</strong> : remove environment

### Tookit2 -- Jupyter-Notebook

Download -- !pip install jupyter

### What Jupyter does

Jupyter is a powerful tool to conduct data analysis.

### What python module does CV need?

nibabel(medical image), pillow(image process)

### What pyhton module does Data-Mining need?

- scikit-learn
- numpy
- pandas
- tqdm
- lightgbm (data-mining model)

### Toolkit3 -- Pytorch

Step1. Check your CUDA condition (CPU/GPU)
Step2. Go to the official site, choose the approprite edition.
Step3. Copy the command provided and run it.

### how do I know which version of CUDA is right for me?

run command `nvidia-smi` (if you have a Nvidia GPU)

### Cloud environment

百度飞桨 AI Studio
阿里天池 PAI DSW
Kaggle
Google Colab
Sagemaker Studio Lab

## File

### Import

```python
import glob
train_path = glob.glob('./脑PET图像分析和疾病预测挑战赛公开数据/Train/*/*')
test_path = glob.glob('./脑PET图像分析和疾病预测挑战赛公开数据/Test/*')
```

### Export

```python
# /Test/*.nii
test_path = glob.glob('./脑PET图像分析和疾病预测挑战赛公开数据/Test/*')

submit = pd.DataFrame(
    {
        'uuid': [int(x.split('/')[-1][:-4]) for x in test_path],
        'label': test_pred_label
    }
)
submit = submit.sort_values(by='uuid')
submit.to_csv('submit.csv', index=None)
```

## Nibabel

Nibabel is a low-level Python library that gives access to a variety of imaging formats, with a particular focus on providing a common interface to the various **volumetric** formats produced by scanners and used in common neuroimaging toolkits.

### Loading and Inspecting Images in Nibabel

```python
img = nib.load('./脑PET图像分析和疾病预测挑战赛公开数据/Test/10.nii')
print(img)
img = img.dataobj[:, :, :, 0] # turn nii to array-like object
```

## Numpy

### Randomly choose data

```python
np.random.choice(a, size=None, replace=True, p=None)
#Parameters:
#a : 1-D array-like or int
#If an ndarray, a random sample is generated from its elements. If an int, the random sample is generated as if a were np.arange(a)

#size : int or tuple of ints, optional
#Output shape. If the given shape is, e.g., (m, n, k), then m * n * k samples are drawn. Default is None, in which case a single value is returned.

#replace : boolean, optional
#Whether the sample is with or without replacement

#p : 1-D array-like, optional
#The probabilities associated with each entry in a. If not given the sample assumes a uniform distribution over all entries in a.
```

### Conditionally choose data

```python
numpy.where(condition)
numpy.where(condition, x, y)

import numpy as np

arr = np.array([1, 2, 3, 4, 5])
condition = arr > 2

# 使用numpy.where()的单参数形式，返回满足条件的元素的索引
result = np.where(condition)
print(result)
# Output
(array([2, 3, 4]),) # Always tuple


# 使用numpy.where()的三参数形式，根据条件选择x中的元素或y中的元素
result = np.where(condition, arr, 10)
print(result)
# Output
[10 10  3  4  5]
```

```python
# Another one
import numpy as np

arr = np.array([[1, 2, 3], [4, 5, 6], [7, 8, 9]])

# 计算每列的平均值，并返回满足平均值非零的元素的数量
result = len(np.where(arr.mean(0))[0])
print(result)
```

### Reshape

```python
import numpy as np

arr = np.array([1, 2, 3, 4, 5, 6])

# 使用-1来自动计算新形状
new_shape = (2, -1)
reshaped_arr = np.reshape(arr, new_shape)
print(reshaped_arr)

# Output
[[1 2 3]
 [4 5 6]]
```

### Count

```python
from collections import Counter

my_list = [1, 2, 3, 1, 2, 1, 4, 3, 5, 2]
counter_obj = Counter(my_list)

# 获取元素1出现的次数
print(counter_obj[1])  # 输出：3

# 获取元素2出现的次数
print(counter_obj[2])  # 输出：3

# 获取出现次数最多的2个元素及其出现次数
print(counter_obj.most_common(2))  # 输出：[(1, 3), (2, 3)]

```

![alt text](image-1.png)
![alt text](image.png)
