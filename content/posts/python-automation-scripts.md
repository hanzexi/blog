---
title: "Python 自动化脚本合集"
date: 2026-05-22 03:54:25
draft: false
summary: "日常工作中常用的 Python 小工具：文件整理和日志分析。"
tags:
  - "Python"
  - "自动化"
categories:
  - "技术"
---

## 文件批量重命命

```python
import os, glob
for f in glob.glob("*.jpg"):
    name = os.path.splitext(f)[0]
    os.rename(f, "photo_" + name + ".jpeg")
```
