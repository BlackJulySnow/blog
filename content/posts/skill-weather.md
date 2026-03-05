---
title: "OpenClaw Skill 介绍：Weather 天气查询"
date: 2025-03-06T01:15:00+08:00
draft: false
tags: ["openclaw", "skill", "天气", "工具"]
categories: ["工具介绍"]
---

# OpenClaw Skill 介绍：Weather 天气查询

## 简介

**Weather** 是一个简单但实用的 OpenClaw Skill，用于查询天气信息。它通过 wttr.in 服务获取天气数据，无需 API 密钥即可使用。

## 功能特点

- 🌍 支持全球任意地点的天气查询
- 🌡️ 实时温度、体感温度、湿度、风速
- 📅 3天天气预报
- 🌅 日出日落时间
- 🌙 月相信息
- 💨 空气质量指数（部分城市）

## 使用方法

### 基础查询

```bash
# 查询当前位置天气
curl wttr.in

# 查询指定城市
curl wttr.in/Beijing
curl wttr.in/London
curl wttr.in/"New York"

# 使用中文城市名
curl wttr.in/北京
curl wttr.in/上海
```

### 格式化输出

```bash
# 简洁模式（单行输出）
curl "wttr.in/Beijing?format=3"

# 自定义格式
curl "wttr.in/Beijing?format=%l:+%c+%t+%w+%h"

# 常用格式变量
# %l - 地点
# %c - 天气状况
# %t - 温度
# %f - 体感温度
# %w - 风速
# %h - 湿度
# %p - 降水概率
```

### JSON 输出

```bash
# 获取 JSON 格式数据
curl "wttr.in/Beijing?format=j1"
```

### 图片输出

```bash
# 获取 PNG 图片
curl "wttr.in/Beijing.png" -o weather.png
```

## 机场代码查询

```bash
# 使用 IATA 机场代码
curl wttr.in/PEK   # 北京首都机场
curl wttr.in/PVG   # 上海浦东机场
curl wttr.in/HKG   # 香港机场
curl wttr.in/NRT   # 东京成田机场
curl wttr.in/LHR   # 伦敦希思罗机场
curl wttr.in/JFK   # 纽约肯尼迪机场
```

## 在 OpenClaw 中使用

```bash
# 询问 OpenClaw 天气
@weather 北京今天天气怎么样？

# 或直接使用命令
curl -s "wttr.in/Beijing?format=3"
```

## 注意事项

- 🆓 完全免费，无需注册或 API 密钥
- 🌍 支持全球 200,000+ 城市
- 🌐 支持多语言输出
- ⏱️ 数据来自世界各地的气象站，通常每 1-2 小时更新
- 📊 预报准确度随时间递减，3天内的预报最可靠

## 相关链接

- [wttr.in 官方文档](https://wttr.in/:help)
- [GitHub 仓库](https://github.com/chubin/wttr.in)

---

**简单、实用、免费** —— 这就是 Weather Skill 的魅力所在！
