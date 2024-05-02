---
title: "C语言多文件项目构建"
description: "This description will be used for the article listing and search results on Google."
date: "2023-05-20"
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
在自己构建多文件项目的时候经常会遇到一些问题，这个或那个丢了，编译不通过，非常的折磨人，于是乎，有了这篇文章...

## 多文件项目的体系结构
主流的项目体系结构应该是
- main.c文件承担核心部分，联结和组织所有功能模块，实现项目的整体流程而不去单独实现某个功能模块。
- 其余.c文件，如module.c，function.c，实现某个独立的功能模块，以便随时调用，当然.c文件之间也是可以相互调用的。（通过链接编译生成的obj文件，使得各个模块相互可见）
- .h文件，起到接口的作用，.c文件模块的相互调用需要依靠.h文件这个接口。

## 为什么需要.h文件
假如我们现在有两个文件，`max.c`和`main.c`，我们要在`main.c`中调用`max.c`中的`max`函数。我们当然可以直接在`main.c`中写一条`max`函数的声明语句，来实现这个效果。示例如下：
```C
//////////max.c/////////////
int max(int a, int b){
    return a>b? a:b;
}
/////////main.c/////////////
#include<stdio.h>
int max(int,int);
int main(){
    int result = max(20,21) ;
    printf("result=%d\n", result);
}
```
在终端输入`gcc -o MAIN *.c; ./MAIN`，可以看见结果成功输出。

但是，考虑一下这种情况，你的`max.c`文件中不止这一个函数，可能有十多个函数（比如你想重载各种参数类型以提高函数普适性），那每次调用是不是要写十多个函数声明。更糟糕的是，很多模块也需要用到这种得出最大值的功能，你的`max.c`被多个文件所调用，那是不是又要写好几遍...甚至说，`max.c`在后续的实验中需要被修改，函数的参数被改动，那又意味着得在每个文件里把函数声明都改一遍...这是极为痛苦的。

而.h文件的出现，可以解决上述所有问题。
你只需要在你的`max.h`文件中，声明`max.c`文件中的所有函数，在之后的模块调用中，便只需要`#include "max.h"`这样一条预处理语句就行啦。

之后`max.c`有什么改动，也只需要改变`max.h`中相应的函数声明即可。

结构体/类的定义同理，为了方便管理，我们也会将结构体/类的定义放在头文件中。

## 重复声明
众所周知，`#include .h`的工作原理就是把.h文件内容在当前处展开，因此，这可能会造成一些问题。

比如你的`main.c`和`max.c`中都引用了`module.h`，之中恰好有你自定义的结构体，那么就有可能造成重复定义的错误。

函数的重复声明是被允许的，但类或者说结构体（有的编译器不会报错）是不能被重复定义的。而避免的方法就是在.h文件中设置一个与程序构建无关标志物，如果标志物出现，那么说明该.h文件已经被引用过一次，编译器将会自动忽略后续该头文件的展开。

## ifndef,define和endif
看下面一段程序例子：
```C
//////////////Sales_data.h///////////////
#ifndef SALES_DATA_H
#define SALES_DATA_H
struct Sales_data{
	char bookNo[20];
	unsigned units_sold;
	double revenue;
};
#endif
```
这便是头文件保护符功能的使用,通过预处理变量`SALES_DATA_H`的两种状态:未定义和已定义来判断该头文件是否被引用过一次。'ifndef'便是说如果没有定义过`SALES_DATA_H`，就`define`（定义）这样一个变量`SALES_DATA_H`。

这样便能解决我们上文提到的问题。

## 总结
程序构建需要模块化：
- `main.c` : 核心流程
- `module1.h` : 子功能1声明文件
- `module1.c` : 子功能1 （注意：该文件也需包含`module1.h`，这样编译器就能检查头文件中的声明与实际定义是否匹配）
- `struct1.h` : 自定义数据结构1定义文件
- `struct2.h` : 自定义数据结构2定义文件

程序构建也需要规范化：
- 使用头文件保护符
- 预处理变量的命名是随意的，但一般用大写的类/结构体名或文件名代替
- 如`module1.c`和`module1.h`，相同模块的文件前缀名字相同 
