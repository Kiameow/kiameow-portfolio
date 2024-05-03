---
title: "Terminal快捷键小tip"
description: "This description will be used for the article listing and search results on Google."
date: "2023-04-17"
banner:
  src: "../../images/terminal.jpg"
  alt: "image description"
  caption: 'Photo by <u><a href="https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.freecodecamp.org%2Fnews%2Fcommand-line-for-beginners%2F&psig=AOvVaw0vLh00ZRBJMZrkJ8L92YNh&ust=1714792141307000&source=images&cd=vfe&opi=89978449&ved=0CBIQjRxqFwoTCOiI3tXA8IUDFQAAAAAdAAAAABAE">freecodecamp</a></u>'
categories:
  - "速查表"
keywords:
  - "terminal"
---

## 光标移动

- `CTRL+A` 移动光标到头部位置
- `CTRL+E` 移动光标到尾部位置
- `CTRL+F` 向后移动一格
- `CTRL+B` 向前移动一格

## 删除

- `CTRL+U` 删除开端到光标位置的一段文字
- `CTRL+K` 删除光标位置到结尾的一段文字

## 单行输入多条命令

- `;` 在两条命令之间使用`;`以单行运行
- `&&` 与上一条类似，但前面的命令遇到报错，后续不再执行

## 查找历史记录

- `CTRL+R` 按下后输入关键字进行历史命令查找
- `history` 按下后根据命令序号，输入`!{number}`来选择历史命令
