---
title: "Docker 容器化部署实践"
date: 2026-05-22 03:54:25
draft: false
summary: "学习 Docker Compose 多容器排排，实现一锯部署完整应用栈。"
tags:
  - "Docker"
  - "DevOps"
categories:
  - "技术"
---

## Docker Compose 示例

```yaml
version: '3.8'
services:
  web:
    image: nginx:latest
    ports:
      - "80:80"
```
