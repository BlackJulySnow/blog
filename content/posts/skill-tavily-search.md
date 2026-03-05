---
title: "OpenClaw Skill 介绍：Tavily 智能搜索"
date: 2025-03-06T01:05:00+08:00
draft: false
tags: ["openclaw", "skill", "搜索", "tavily", "工具"]
categories: ["工具介绍"]
---

# OpenClaw Skill 介绍：Tavily 智能搜索

## 什么是 Tavily Search？

**tavily-search** 是一个 OpenClaw Skill，它使用 Tavily API 提供实时网络搜索、内容提取和研究能力。当你需要搜索网页、查找信息、研究主题或从 URL 提取内容时，可以使用这个工具。

## 核心功能

### 1. 智能网页搜索

Tavily Search 提供强大的搜索能力：

- **实时搜索**：获取最新的网络信息
- **智能排序**：AI 优化的搜索结果排序
- **深度搜索**：支持基础模式和高级模式
- **结果丰富**：包含标题、摘要、URL 和相关内容

### 2. 内容提取

从任意网页提取干净的内容：

- **文章提取**：自动识别正文内容
- **去噪处理**：移除广告、导航等无关内容
- **格式保留**：保持原始排版和结构
- **批量处理**：支持多个 URL 同时提取

### 3. 研究能力

专为深度研究设计的功能：

- **多源聚合**：从多个来源整合信息
- **相关性分析**：AI 评估内容相关性
- **引用追踪**：方便验证信息来源
- **主题发现**：自动识别相关主题

## 使用方法

### 环境配置

在使用之前，需要设置 API 密钥：

```bash
# 设置环境变量
export TAVILY_API_KEY="your-api-key-here"

# 或者在 ~/.bashrc 或 ~/.zshrc 中添加
echo 'export TAVILY_API_KEY="your-api-key-here"' >> ~/.bashrc
```

获取 API 密钥：访问 https://tavily.com 注册免费账户

### 基本搜索

```bash
# 基础搜索
python3 ~/.openclaw/skills/tavily-search/scripts/tavily_search.py "OpenClaw AI助手"

# 高级搜索选项
python3 ~/.openclaw/skills/tavily-search/scripts/tavily_search.py \
  "机器学习最新进展" \
  --max-results 10 \
  --search-depth advanced \
  --include-images
```

### 内容提取

```bash
# 从 URL 提取内容
python3 ~/.openclaw/skills/tavily-search/scripts/tavily_extract.py \
  "https://example.com/article"

# 批量提取多个 URL
python3 ~/.openclaw/skills/tavily-search/scripts/tavily_extract.py \
  "https://site1.com/article1" \
  "https://site2.com/article2"
```

## 可用工具

| 脚本 | 用途 | 示例 |
|------|------|------|
| `tavily_search.py` | 网页搜索 | 搜索最新技术资讯 |
| `tavily_extract.py` | 内容提取 | 提取文章正文 |

## 环境变量

| 变量名 | 必需 | 默认值 | 说明 |
|--------|------|--------|------|
| `TAVILY_API_KEY` | 是 | - | Tavily API 密钥 |
| `TAVILY_DEFAULT_SEARCH_DEPTH` | 否 | `basic` | 搜索深度：`basic` 或 `advanced` |
| `TAVILY_DEFAULT_MAX_RESULTS` | 否 | `5` | 默认返回结果数量 |

## API 限制

- **免费套餐**：每月 1000 次 API 调用
- **付费套餐**：访问 https://tavily.com 查看定价详情

## 使用场景

### 1. 研究新主题

```bash
# 研究某个技术主题
python3 ~/.openclaw/skills/tavily-search/scripts/tavily_search.py \
  "Kubernetes 最佳实践 2024" \
  --search-depth advanced \
  --max-results 15
```

### 2. 撰写文章时收集资料

```bash
# 收集多来源信息
python3 ~/.openclaw/skills/tavily-search/scripts/tavily_search.py \
  "AI 编程助手对比" \
  --max-results 20
```

### 3. 提取文章内容

```bash
# 获取无广告的文章内容
python3 ~/.openclaw/skills/tavily-search/scripts/tavily_extract.py \
  "https://blog.example.com/article"
```

## 最佳实践

1. **设置环境变量**：在 shell 配置中添加 `TAVILY_API_KEY`，避免每次输入
2. **合理使用搜索深度**：`basic` 适合快速搜索，`advanced` 适合深度研究
3. **控制结果数量**：根据需求调整 `--max-results`，避免信息过载
4. **缓存搜索结果**：对于重复查询，可以保存结果避免浪费 API 调用

## 总结

**tavily-search** Skill 为 OpenClaw 提供了强大的网络搜索能力。它不仅能帮你快速获取最新信息，还能深度提取网页内容，是研究、写作和学习的有力工具。与 AI 助手结合使用，可以大大提升信息获取的效率和质量。
