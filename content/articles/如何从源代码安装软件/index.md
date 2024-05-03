---
title: "如何从源代码安装软件"
description: "This description will be used for the article listing and search results on Google."
date: "2023-07-04"
banner:
  src: "../../images/kelly-sikkema-Hl3LUdyKRic-unsplash.jpg"
  alt: "image description"
  caption: 'Photo by <u><a href="https://unsplash.com/photos/Nc5Q_CEcY44">Florian Olivo</a></u>'
categories:
  - "教程"
  - "Linux"
keywords:
  - "源代码安装软件"
---

## Step1: Download the Source Code Archive File and Unzip it

下载源代码的压缩包，通常以`.tar.gz`的格式出现。

之后使用`tar`工具进行解压，命令如下：

```shell
tar -xzf tarfile
# -v verbose模式，展示解压过程
# -x 提取
# -z 同时使用gzip，当被解压文件只有.tar后缀时请忽略这个命令选项
# -f 指定文件输入，而不是标准输入STDIN
```

## Step2: Check the Necessary Files

在你解压完成后，进入源文件文件夹，你会看见 README 文件，或者是 INSTALL 文件，这些文件将会为你安装软件提供指引，请务必阅读它们。

之后，运行文件中的 configure 文件，检查你的系统中是否已经完全具备编译源代码的条件，即依赖文件是否齐全（编译工具，库文件）。

```shell
./configure
# 有两个命令选项
# --prefix=[指定安装目录]
# --with指的是安装本文件所依赖的库文件
```

检查完毕后，会根据你的系统文件存在情况生成 makefile（去哪找库文件，如何链接）

- 如果检查后发现缺少必要文件怎么办？
  使用如下命令，安装缺失文件：

```shell
sudo apt-get install build-essential
```

## Step3: Start Compiling and Install

生成对应的`makefile`后，在源文件文件夹下，使用`make`命令，进行编译。

编译阶段可能会花费较长的时间，请耐心等待。如果你拥有多核 CPU，可以使用`make -j`加快编译速度。

~~接着，执行`sudo make install`安装软件。~~
接着使用`checkinstall`而不是`make install`，`checkinstall`是一款软件，如果没有请安装它，它能够打包你将要安装的软件成为`.deb`包，以便后续的管理。

这样一来，之后你想要删除这个软件，只需运行`sudo dpkg -r 软件名.deb`，而无需手动一个个找文件删除。（运行了`makeinstall`之后，仍然可以使用`checkinstall`进行打包）

## Can't Launch Your App?

在安装完成后，启动软件却发现仍然缺少一些必要的运行库，如何解决？
执行：

```shell
sudo ldconfig
```

会帮助你安装这些缺失的文件。

## 优缺点

- 优点：使用源代码安装，可以为你提供对软件的完全控制，以及最新版本（包管理器收录必然是滞后的）
- 缺点：麻烦，配置时出错很难调试，并且无法自动升级，有新的版本就需要重装。而包管理器一条命令就可以完成上述工作。
