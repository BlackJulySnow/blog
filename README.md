# 我的博客

使用 Hugo + Hextra 主题构建的个人博客。

## 🚀 快速开始

```bash
# 本地预览
cd ~/myblog
hugo server -D

# 构建
hugo --minify
```

## 📦 部署方式

本博客支持多种免费部署方式：

### 1. GitHub Pages（推荐）
- 免费、稳定、自动部署
- 访问地址：`https://<username>.github.io/<repo-name>`
- 已配置 GitHub Actions 自动部署

### 2. Vercel
- 全球 CDN、自动部署
- 支持自定义域名
- 访问地址：`https://<project>.vercel.app`

### 3. Netlify
- 简单易用、自动部署
- 支持表单处理、身份验证
- 访问地址：`https://<site>.netlify.app`

### 4. Cloudflare Pages
- 全球 CDN、性能优异
- 访问地址：`https://<project>.pages.dev`

## 📝 写作指南

### 创建新文章

```bash
hugo new content posts/my-new-post.md
```

### 文章前置参数

```yaml
---
title: "文章标题"
date: 2024-03-05T10:00:00+08:00
draft: false
tags: ["标签1", "标签2"]
categories: ["分类"]
---
```

## 🛠️ 技术栈

- [Hugo](https://gohugo.io/) - 静态网站生成器
- [Hextra](https://github.com/imfing/hextra) - Hugo 主题
- [GitHub Pages](https://pages.github.com/) - 静态托管
- [GitHub Actions](https://github.com/features/actions) - CI/CD

## 📄 许可证

本博客内容采用 [CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/) 协议。
