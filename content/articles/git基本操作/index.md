---
title: "Git基本操作"
description: "This description will be used for the article listing and search results on Google."
date: "2023-04-06"
banner:
  src: "../../images/git.jpg"
  alt: "image description"
  caption: 'Photo by <u><a href="https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.shiksha.com%2Fonline-courses%2Farticles%2Ftop-git-interview-questions-and-answers%2F&psig=AOvVaw3HU7PNTNGZo-jFRsHnvF96&ust=1714792841414000&source=images&cd=vfe&opi=89978449&ved=0CBIQjRxqFwoTCKjgqqPD8IUDFQAAAAAdAAAAABAQ">Git</a></u>'
categories:
  - "Git"
  - "教程"
  - "速查表"
keywords:
  - "Git命令速查"
---

## git 相关命令以及原理学习

墙裂推荐一下这个 -> [Learn Git Branching](https://learngitbranching.js.org/?locale=zh_CN)

跟着提示闯关，过一遍基本就能够掌握 git 绝大部分的操作，并且让你对 git 有全新的理解

## git 团队协作

一个向所有人开放的 git 上手项目，帮助你快速熟悉 git 团队协作中的一些关键步骤 -> [first-contributions](https://github.com/firstcontributions/first-contributions)

更加详细的工作流推荐 -> [十分钟学会正确的 github 工作流，和开源作者们使用同一套流程](https://www.bilibili.com/video/BV19e4y1q7JJ/?spm_id_from=333.337.search-card.all.click&vd_source=ea7e3a32696013a15824af0651dc1a01)

## 一些命令行操作

### 1.创建代码库

```shell
# 下载项目文件
git clone <项目文件地址>
git clone https://github.com/Kiameow/Kiameow.github.io.git
# 在当前目录新建一个Git代码库
git init
```

### 2.配置

Git 的设置文件为.gitconfig,它可以在用户主目录下（全局配置），也可以在项目目录下（项目配置）。

```shell
# 显示当前的Git配置
git config --list

# 编辑配置文件 []为可选项
git config -e [--global]

# 设置提交代码时的用户信息
git config [--global] user.name <your_name>
git config [--global] user.email <your_email>
```

### 3.本地仓库提交

```shell
# 将当前文件夹下的所有文件提交至暂存区
git add .
# 指定file1,file2文件提交至暂存区
git add file1 file2
# 将暂存区文件提交到本地仓库
git commit
```

### 4.远程仓库使用

```shell
# 下载远程仓库文件
git fetch <origin>
# 将下载的远程仓库文件与本地仓库文件合并
git merge <origin> <main>
# 同时实现上述两步效果
git pull <origin> <main>
# 将本地仓库内容提交至远程仓库
git push
```

更多更详细的内容请参见[阮老师的网络日志](https://www.ruanyifeng.com/blog/2015/12/git-cheat-sheet.html)

## 怎样了解又新又好的开源项目

- [Trending](https://github.com/trending/) -- 寻找潮流开源项目
- [HelloGitHub](https://github.com/521xueweihan/HelloGitHub) -- 项目介绍期刊
- [科技爱好者周报](https://github.com/ruanyf/weekly) -- 前沿科技、工具介绍

## GitHub 搜索技巧

- awesome-<你想要了解的领域> : 该领域的百科大全 e.g. awesome-vue
- <你想要了解的领域> sample : 该领域的项目案例 e.g. vue sample
- <某领域> starter/boilerplate : 空项目模板
- <你想要了解的领域> tutorial : 教程
