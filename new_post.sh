#!/bin/bash

articles_dir="./content/articles/"
current_time=$(date +"%Y-%m-%d")
for title in "$@"; do
    dest="${articles_dir}${title}"

    # check the existing folder
    if [ -d "$dest" ]; then
        echo "Folder '$dest' already exists. Skipping."
        continue
    fi

    mkdir -p "$dest"

    # content in index.md
    cat << EOF >> "${dest}/index.md"
---
title: "${title}"
description: "This description will be used for the article listing and search results on Google."
date: "${current_time}"
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
