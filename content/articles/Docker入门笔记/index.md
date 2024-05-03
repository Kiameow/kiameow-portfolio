---
title: "Docker入门笔记"
description: "This description will be used for the article listing and search results on Google."
date: "2023-04-19"
banner:
  src: "../../images/docker.png"
  alt: "image description"
  caption: 'Photo by <u><a href="https://www.google.com/url?sa=i&url=https%3A%2F%2Fblog.devgenius.io%2Fapi-calls-between-docker-instances-24124f5bf010&psig=AOvVaw2MeXTISLavsYxebbHsg3sD&ust=1714793293738000&source=images&cd=vfe&opi=89978449&ved=0CBIQjRxqFwoTCOiH8vrE8IUDFQAAAAAdAAAAABAi">Docker</a></u>'
categories:
  - "Docker"
  - "笔记"
keywords:
  - "Docker"
---

# STEP1：了解两个概念

## 什么是容器 Container?

容器有以下特点：

- 是一个镜像的可运行实例（类似于虚拟机）。
- 能够在本地机器、虚拟机上运行，或者在云端上部署。
- 轻便性（能够在任何操作系统上运行）。
- 独立于其他容器，软件、二进制文件和设置都可以是定制化的。

## 什么是容器镜像 Image？

镜像有以下特点：

- 提供了一个独立与本地机器和其他容器的文件系统。
- 提供运行特定程序所需要的一切--包括依赖，脚本，二进制文件等等
- 提供环境变量，默认的一些命令
