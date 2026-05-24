---
title: "Hugo 静态网站常用命令速查"
date: 2026-05-24T19:30:00+08:00
draft: false
summary: "整理 Hugo 日常开发中最高频使用的命令，从建站到部署一条龙。"
tags:
  - "Hugo"
  - "静态网站"
  - "速查表"
categories:
  - "技术"
---

## 为什么需要这个速查？

每次用 Hugo 都要翻文档太麻烦了。这篇文章把最常用的命令整理在一起，方便快速查阅和复制粘贴。

---

## 安装与初始化

```bash
# macOS (Homebrew)
brew install hugo

# Ubuntu/Debian
sudo apt update && sudo apt install -y hugo

# Windows (Chocolatey)
choco install hugo-extended -confirm

# 创建新站点
hugo new site my-blog --force

cd my-blog
git init

# 添加 PaperMod 主题（推荐）
git submodule add https://github.com/adityatelange/hugo-PaperMod.git themes/PaperMod

# 编辑配置，设置 theme = "PaperMod"
```

---

## 内容管理

```bash
# 创建新文章（自动生成 Front Matter）
hugo new posts/my-first-post.md

# 创建分类索引页
hugo new categories/technology/_index.md

# 批量创建草稿
for i in $(seq 1 5); do hugo new posts/draft-$i.md; done
```

**Markdown Front Matter 模板：**

```yaml
---
title: "文章标题"
date: 2026-05-24T19:30:00+08:00
draft: false
summary: "一句话摘要，显示在首页列表页。"
tags:
  - Hugo
  - Markdown
categories:
  - 技术
---

正文从这里开始...
```

**JSON Front Matter 模板：**

```json
{
  "title": "文章标题",
  "date": "2026-05-24T19:30:00+08:00",
  "draft": false,
  "summary": "一句话摘要。",
  "tags": ["Hugo", "Markdown"],
  "categories": ["技术"]
}
```

---

## 本地开发（最常用）

```bash
# 启动开发服务器，监听文件变化自动刷新
hugo server

# 带草稿内容 + 指定端口 + 允许外部访问
hugo server -D --port 1313 --bind 0.0.0.0

# 禁用浏览器自动打开（容器/CI环境）
hugo server --disableLiveReload
```

---

## 构建与部署

```bash
# 生产环境构建（默认不包含草稿）
hugo

# 压缩输出 + 最小化 CSS/JS
hugo --minify

# 包含草稿内容一起构建
hugo -D
```bash
# 清理 public/ 目录后重新构建
hugo --cleanDestinationDir

---

## GitHub Pages 部署（CI/CD）

我们的博客使用 GitHub Actions 自动构建和部署。配置文件在 `.github/workflows/deploy.yml`：

```yaml
name: Deploy Hugo site to Pages
on:
  push:
    branches: [main]
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          submodules: true
      - name: Setup Hugo
        uses: peaceiris/actions-hugo@v3
        with:
          hugo-version: '0.161.1'
          extended: true
      - run: hugo --minify
      - name: Deploy to GitHub Pages
        uses: peaceiris/actions-gh-pages@v4
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
```

**本地测试构建：**

```bash
# 模拟 CI 环境（不启动服务器）
hugo --minify --environment production -b "https://your-domain.com"
```

---

## Git 工作流

我们使用 WSL + SSH 推送至 GitHub：

```bash
cd /home/hanzexi/workspace/Blog

# 查看变更
git status --short

# 添加文件并提交
git add content/posts/my-new-post.md hugo.yaml static/assets/icons/avatar.png
git commit -m "feat: add new post about Hugo commands"

# 推送到 GitHub（触发 CI/CD）
GIT_SSH_COMMAND="ssh -i ~/.ssh/id_ed25519" git push origin main

---

## PaperMod 主题常用配置

我们的博客使用 **PaperMod** 主题，以下是关键配置项：

```yaml
params:
  avatar: # 头像配置（必须放在对应语言的 params 下）
    enabled: true
    image: /assets/icons/avatar.png
  
  homeInfoParams:
    Title: "欢迎来到我的博客"
    Content: "记录技术成长，分享编程心得。"

menu:
  main:
    - identifier: home
      name: "首页"
      url: /
```

---

## VM #102 本地构建验证

我们在 Ubuntu VM (#102) 上安装了 Hugo v0.161.1，用于快速测试：

```bash
# SSH 到 VM #102（ubuntu@192.168.18.102）
ssh ubuntu@192.168.18.102

# 同步代码并构建验证
cd ~/workspace/blog && git pull origin main && hugo --minify

# 启动本地预览（端口 :3000）
hugo server -D --port 3000 --bind 0.0.0.0
```

---

## 常用命令速查表

| 场景 | 命令 |
|------|------|
| 新文章 | `hugo new posts/title.md` |
| 本地预览 | `hugo server -D` |
| 生产构建 | `hugo --minify` |
| Git 推送 | `git push origin main` |
| CI/CD 状态 | GitHub Actions Runs（自动触发） |

---

> 💡 **提示**：本文使用 Hugo + PaperMod 主题搭建，通过 GitHub Actions 自动化部署至 GitHub Pages。每次推送到 `main` 分支都会触发完整构建流程。```bash