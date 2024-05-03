---
title: "文件处理工具收录"
description: "This description will be used for the article listing and search results on Google."
date: "2023-05-20"
banner:
  src: "../../images/kelly-sikkema-Hl3LUdyKRic-unsplash.jpg"
  alt: "image description"
  caption: 'Photo by <u><a href="https://unsplash.com/photos/Nc5Q_CEcY44">Florian Olivo</a></u>'
categories:
  - "工具"
keywords:
  - "文件文本处理工具"
---

### cut

- 用途:获取文件内容的某一列（某几列）
- 命令范例:`cut f 1,2 foo.txt > bar.txt`

### paste

- 用途:以列方式合并不同文件
- 命令范例:`paste foo.txt bar.txt > output.txt`
- 效果:

```
////////foo.txt////////
1 2
1 2
1 2
///////bar.txt////////
3 4 5
3 4 5
3 4 5
///////output.txt///////
1 2 3 4 5
1 2 3 4 5
1 2 3 4 5
```

### sed

- 用途:文件分析,功能很强大,此处只演示文本替换相关功能
- 命令范例 1:`sed 's/unix/linux/g' obj.txt`
- 命令范例 2:`sed 's/unix/linux/2' obj.txt`
- 命令范例 3:`sed 's/unix/linux/2g' obj.txt`
- 命令范例 4:`sed 's/^/HEAD/g' obj.txt`
- 命令范例 2:`sed 's/$/TAIL/g' obj.txt`

- 参数解读: `s`--替换 | `unix`为内容关键字 | `linux`为替换内容 | `g`为 global,替换每行中所有匹配的关键字 | `2`每行只替换第二个匹配的 | `2g`每行替换第二个及第二个以后的 | ` ^``$ `分别为每行开头标志和结尾标志

### awk

- 用途:文件分析,功能很强大,此处只演示文本删除相关功能
- 命令范例:`awk '{$2 = ""; print $0}' obj.txt`
- 效果:将第二列替换为"",即删除效果

### shuf

- 用途:打乱文本内容（交换行）
