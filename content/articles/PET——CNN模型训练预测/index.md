---
title: "PET——CNN模型训练预测"
description: "This description will be used for the article listing and search results on Google."
date: "2023-07-26"
banner:
  src: "../../images/kelly-sikkema-Hl3LUdyKRic-unsplash.jpg"
  alt: "image description"
  caption: 'Photo by <u><a href="https://unsplash.com/photos/Nc5Q_CEcY44">Florian Olivo</a></u>'
categories:
  - "Setup"
  - "Tutorial"
keywords:
  - "Example"
---
## 利用框架构建数据集
```python
DATA_CACHE = {}
class XunFeiDataset(Dataset):
    def __init__(self, img_path, transform=None):
        self.img_path = img_path
        if transform is not None:
            self.transform = transform
        else:
            self.transform = None
    
    def __getitem__(self, index):
        if self.img_path[index] in DATA_CACHE:
            img = DATA_CACHE[self.img_path[index]]
        else:
            img = nib.load(self.img_path[index]) 
            img = img.dataobj[:,:,:, 0]
            DATA_CACHE[self.img_path[index]] = img
        
        # 随机选择一些通道            
        idx = np.random.choice(range(img.shape[-1]), 50)
        img = img[:, :, idx]
        img = img.astype(np.float32)

        if self.transform is not None:
            img = self.transform(image = img)['image']
        
        img = img.transpose([2,0,1])
        return img,torch.from_numpy(np.array(int('NC' in self.img_path[index])))
    
    def __len__(self):
        return len(self.img_path)
```
上述代码通过对 `Pytorch` 框架中的基本数据集进行继承修改，构建了PET项目对应的数据集，方便后续在框架内进行操作。

## 数据增广  构建训练集|验证集|测试集
```python
import albumentations as A
train_loader = torch.utils.data.DataLoader(
    XunFeiDataset(train_path[:-10],
            A.Compose([
            A.RandomRotate90(),
            A.RandomCrop(120, 120),
            A.HorizontalFlip(p=0.5),
            A.RandomBrightnessContrast(p=0.5),
        ])
    ), batch_size=2, shuffle=True, num_workers=1, pin_memory=False
)

val_loader = torch.utils.data.DataLoader(
    XunFeiDataset(train_path[-10:],
            A.Compose([
            A.RandomCrop(120, 120),
        ])
    ), batch_size=2, shuffle=False, num_workers=1, pin_memory=False
)

test_loader = torch.utils.data.DataLoader(
    XunFeiDataset(test_path,
            A.Compose([
            A.RandomCrop(128, 128),
            A.HorizontalFlip(p=0.5),
            A.RandomBrightnessContrast(p=0.5),
        ])
    ), batch_size=2, shuffle=False, num_workers=1, pin_memory=False
)
```
通过Albumentation中的方法对图像进行重组，如`RandomCrop`方法随机裁取部分图像作为输入，生成类似数据集中的图片进行数据增广，减少了过拟合现象的发生概率，增强了模型的鲁棒性。
（demo中的 `A.RandomContrast` 方法已经被弃用，选择换用`A.RandomBrightnessContrast``）


## 构建CNN模型
```python
class XunFeiNet(nn.Module):
    def __init__(self):
        super(XunFeiNet, self).__init__()
                
        model = models.resnet50(True)
        model.conv1 = torch.nn.Conv2d(50, 64, kernel_size=(7, 7), stride=(2, 2), padding=(3, 3), bias=False)
        model.avgpool = nn.AdaptiveAvgPool2d(1)
        # model.fc = nn.Linear(512, 2)
        model.fc = nn.Linear(2048, 2)
        self.resnet = model
        
    def forward(self, img):        
        out = self.resnet(img)
        return out
        
model = XunFeiNet()
model = model.to('cpu')
criterion = nn.CrossEntropyLoss().to('cpu')
optimizer = torch.optim.AdamW(model.parameters(), 0.001)
```
通过继承Pytorch框架中的基本模型，构建出项目对应模型，此处选用resNet50，注意，resNet50由于层数更多，第一层的输入口个数为2048个而非512，故需要改变原代码 `model.fc` 处参数。


## 模型训练
```python
def train(train_loader, model, criterion, optimizer):
    model.train()
    train_loss = 0.0
    for i, (input, target) in enumerate(train_loader):
        input = input.to('cpu')
        target = target.to('cpu')

        output = model(input)
        loss = criterion(output, target)

        optimizer.zero_grad()
        loss.backward()
        optimizer.step()

        if i % 20 == 0:
            print(loss.item())
            
        train_loss += loss.item()
    
    return train_loss/len(train_loader)
            
def validate(val_loader, model, criterion):
    model.eval()
    val_acc = 0.0
    
    with torch.no_grad():
        for i, (input, target) in enumerate(val_loader):
            input = input.to('cpu')
            target = target.to('cpu')

            # compute output
            output = model(input)
            loss = criterion(output, target)
            
            val_acc += (output.argmax(1) == target).sum().item()
            
    return val_acc / len(val_loader.dataset)
    
for _  in range(3):
    train_loss = train(train_loader, model, criterion, optimizer)
    val_acc  = validate(val_loader, model, criterion)
    train_acc = validate(train_loader, model, criterion)
    
    print(train_loss, train_acc, val_acc)
```
GPT：这段代码用于使用PyTorch在数据集上训练和评估神经网络模型。它包含两个函数：`train`和`validate`，分别用于处理训练和验证步骤。代码在三个epochs中运行这些步骤，并在每个epoch后打印训练损失、训练准确率和验证准确率。

让我们逐步解释代码：

1. `def train(train_loader, model, criterion, optimizer)`: 此函数使用给定的`train_loader`执行一个epoch的训练，其中`train_loader`是包含训练数据的PyTorch DataLoader。该函数有四个参数：
   - `train_loader`：包含训练数据的PyTorch DataLoader。
   - `model`：待训练的神经网络模型。
   - `criterion`：用于计算损失的损失函数。
   - `optimizer`：用于在训练过程中更新模型参数的优化算法。

   函数内部：
   - `model.train()` 将模型设置为训练模式，启用训练过程中的dropout和批归一化等功能。
   - 然后，函数遍历`train_loader`中的批次数据。
   - 每个批次包含输入数据（`input`）和对应的目标标签（`target`）。
   - 将`input`和`target`张量移到CPU设备，使用`.to('cpu')`将计算放在CPU上（不使用GPU）。
   - 使用模型对输入数据进行预测，得到输出（`output`）。
   - 使用提供的`criterion`计算预测的`output`与实际的`target`之间的损失。
   - 使用`optimizer.zero_grad()`将优化器的梯度重置为零。
   - 使用`loss.backward()`进行反向传播计算梯度。
   - 使用`optimizer.step()`更新模型的参数。
   - 将当前批次的损失累积到`train_loss`中。
   - 处理完所有批次后，计算并返回整个epoch的平均训练损失。

2. `def validate(val_loader, model, criterion)`: 此函数使用给定的`val_loader`执行验证步骤，其中`val_loader`是包含验证数据的PyTorch DataLoader。该函数有三个参数：
   - `val_loader`：包含验证数据的PyTorch DataLoader。
   - `model`：经过训练的神经网络模型。
   - `criterion`：用于计算损失的损失函数。

   函数内部：
   - `model.eval()` 将模型设置为评估模式，禁用评估过程中的dropout等功能。
   - 然后，函数遍历`val_loader`中的批次数据。
   - 使用模型对输入数据进行预测得到输出（`output`）。
   - 通过比较预测的输出（`output.argmax(1)`）与目标标签（`target`）来计算验证准确率。如果预测的类索引与目标类索引匹配，则视为正确预测。
   - 将验证准确率累积到`val_acc`中。
   - 处理完所有批次后，计算并返回整个数据集的平均验证准确率。

3. 代码然后在三个epochs中运行训练和评估的循环，使用`for _ in range(3)`。
   - `train_loss`、`train_acc`和`val_acc`是变量，用于分别存储每个epoch的训练损失、训练准确率和验证准确率。
   - 在每个epoch中，调用`train`函数在训练数据（`train_loader`）上执行训练步骤。
   - 调用`validate`函数两次：一次在训练数据（`train_loader`），一次在验证数据（`val_loader`），分别计算训练准确率和验证准确率。

4. 每个epoch结束后，打印该epoch的平均训练损失（`train_loss`）、训练准确率（`train_acc`）和验证准确率（`val_acc`）。

该代码的目标是在训练数据上训练模型，并在验证数据上评估模型的性能，同时跟踪训练过程中的损失和准确率。这样的训练和评估循环常用于监控模型的进展，并根据验证性能决定何时停止训练。

## 结果预测
```python
def predict(test_loader, model, criterion):
    model.eval()
    val_acc = 0.0
    
    test_pred = []
    with torch.no_grad():
        for i, (input, target) in enumerate(test_loader):
            input = input.to('cpu')
            target = target.to('cpu')

            output = model(input)
            test_pred.append(output.data.cpu().numpy())
            
    return np.vstack(test_pred)
    
pred = None
for _ in range(10):
    if pred is None:
        pred = predict(test_loader, model, criterion)
    else:
        pred += predict(test_loader, model, criterion)
        
```

## 结果处理
最终在讯飞平台上提交数据结果后获得的分数为0.03279，存在严重的数据相反，于是，通过反转数据以提高准确度。

```python
import pandas as pd
submit_df = pd.read_csv('CNN_submit4.csv')

labels = submit_df['label']
# 原始标签：NC和MCI
original_labels = ["NC", "MCI"]

# 反转标签：NC变为MCI，MCI变为NC
reversed_labels = ["MCI", "NC"]

# 创建一个空列表来存储取反后的标签
inverted_labels = []

# 遍历原始标签列表
for label in labels:
    # 查找原始标签在original_labels中的索引位置
    original_index = original_labels.index(label)
    # 使用索引位置找到对应的反转标签，将其添加到inverted_labels中
    inverted_labels.append(reversed_labels[original_index])

# 现在，inverted_labels中就存储了取反后的结果标签
# 可以将inverted_labels作为新的标签来替换原来的labels，或者根据需要使用它来进行后续处理。

submit = pd.DataFrame(
    {
        'uuid': submit_df['uuid'],
        'label': inverted_labels
})
submit.to_csv('CNN_submit4RE.csv', index=None)
```
提交反转数据结果后，准确度果然大幅提升，达到了0.73885。





