#!/bin/bash

# Hugo 博客一键部署脚本

set -e

# 配置
REPO_DIR="/home/ubuntu/workspace/blog"
PUBLIC_DIR="$REPO_DIR/public"
COMMIT_MSG="${1:-Update: $(date '+%Y-%m-%d %H:%M:%S')}"

echo "========================================"
echo "       Hugo 博客一键部署脚本"
echo "========================================"

# 进入项目目录
cd "$REPO_DIR" || { echo "Error: 无法进入目录 $REPO_DIR"; exit 1; }

# 检查 Hugo 是否安装
if ! command -v hugo &> /dev/null; then
    echo "Error: Hugo 未安装"
    exit 1
fi

# 清理旧的构建文件
echo "[1/4] 清理旧构建..."
rm -rf "$PUBLIC_DIR"

# 构建站点
echo "[2/4] 构建站点..."
hugo --minify

# 检查构建结果
if [ ! -d "$PUBLIC_DIR" ]; then
    echo "Error: 构建失败，public 目录不存在"
    exit 1
fi

echo "[3/4] 构建成功，共 $(find "$PUBLIC_DIR" -type f | wc -l) 个文件"

# Git 提交并推送
if [ -d "$PUBLIC_DIR/.git" ]; then
    echo "[4/4] 部署到 GitHub Pages..."
    cd "$PUBLIC_DIR" || exit 1

    git add -A
    git commit -m "$COMMIT_MSG"
    git push origin gh-pages

    echo "========================================"
    echo "  部署完成!"
    echo "========================================"
else
    echo "[4/4] public 目录不是 Git 仓库，跳过推送"
    echo "构建完成，静态文件位于: $PUBLIC_DIR"
fi
