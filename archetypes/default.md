---
title: '{{ replace .File.ContentBaseName "-" " " | title }}' # 标题：自动将文件名中的连字符替换为空格，并转换为首字母大写格式
date: {{ .Date }} # 日期：自动填充当前创建时间
summary: 简短摘要 # 文章摘要/简介，用于列表页展示
images: [] # 封面图片列表，可在此处添加图片路径
categories: # 分类
  - Default # 默认分类名称
tags: # 标签
  - Markdown # 默认标签名称
draft: false # 草稿状态：false 表示发布，true 表示仅作为草稿保存（不生成公开页面）
---