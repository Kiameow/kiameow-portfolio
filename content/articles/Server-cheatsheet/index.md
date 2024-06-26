---
title: "Server cheatsheet"
description: "This description will be used for the article listing and search results on Google."
date: "2023-11-18"
banner:
  src: "../../images/kelly-sikkema-Hl3LUdyKRic-unsplash.jpg"
  alt: "image description"
  caption: 'Photo by <u><a href="https://unsplash.com/photos/Nc5Q_CEcY44">Florian Olivo</a></u>'
categories:
  - "速查表"
keywords:
  - "服务器管理"
---

## ssh

### ssh 远程登录

`ssh -p port_number username@ip_address`
`ssh -p 10000 root@11.11.11.11`

不用-p 则默认为 22 端口

### 将服务器端口映射到本地端口

`ssh -CNgv -L local_port:127.0.0.1:port username@ip_address -p 22`

比如在服务器上启用了 hugo server，你想要看看页面的效果如何
hugo server 默认启动在端口 1313
`ssh -CNgv -L 1313:127.0.0.1:1313 root@11.11.11.11 -p 10000`
此处 ssh 连接端口为 10000,根据个人配置来，改动是出于安全性考虑

## scp

### scp 文件上传

`scp /path/local_file username@ip_address:/path`
`scp /var/www/test.php  codinglog@192.168.0.101:/var/www/ `

### scp 文件下载

`scp username@ip_address:/path/filename /tmp/local_destination`
`scp root@11.11.11.11:/home/user/text /tmp/local_destination`

上传、下载文件夹则加上-r 选项
