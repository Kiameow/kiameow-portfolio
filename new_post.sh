#!/bin/bash

articles_dir="./content/articles/"

# 循环处理所有输入的参数
for title in "$@"; do
    dest="${articles_dir}${title}"

    # 检查文件夹是否已经存在
    if [ -d "$dest" ]; then
        echo "Folder '$dest' already exists. Skipping."
        continue
    fi

    # 创建文件夹
    mkdir -p "$dest"

    # index.md
    cat << EOF >> "${dest}/index.md"
---
title: "${title}"
description: "This description will be used for the article listing and search results on Google."
date: "xxx"
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

## start your writing!
EOF

    echo "New post '$title' added!"
done
