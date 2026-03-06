---
title: "OpenClaw 多智能体路由完全指南"
date: 2026-03-07T01:30:00+08:00
draft: false
tags: ["OpenClaw", "多智能体", "教程", "技术"]
categories: ["技术"]
---

## 一、什么是多智能体？为什么你需要它

单智能体能帮你处理所有事情，但它有两个明显的局限：

1. **人格和记忆混杂** — 工作和生活的上下文混在一起，AI 既记不住你的工作偏好，也不了解你的生活习惯
2. **通道无法分离** — 一个账号收到的消息，不管内容是什么，都交给同一个 AI 处理

多智能体解决这个问题的方式是：**创建多个独立的 AI 大脑，每个大脑有自己的性格、记忆和工作空间**。

典型使用场景：

- **工作与生活分离** — 工作号交给工作脑，个人号交给生活脑
- **多平台分工** — WhatsApp 处理日常，Telegram 处理深度工作
- **家庭共享** — 每人一个独立的智能体，数据完全隔离

---

## 二、OpenClaw 的核心概念

三个基本概念：**Agent**、**Account**、**Binding**。

### 2.1 Agent（智能体）

一个 Agent 就是一个完整的 AI 单元，包含：

| 组成部分 | 路径 | 作用 |
|---------|------|------|
| **Workspace** | `~/.openclaw/workspace-<agentId>` | 文件存储，存放 SOUL.md、AGENTS.md 等 |
| **agentDir** | `~/.openclaw/agents/<agentId>/agent` | 认证配置、模型注册表 |
| **Sessions** | `~/.openclaw/agents/<agentId>/sessions` | 聊天历史 |

默认只有一个 `main` Agent。

### 2.2 Account（账号）

一个通道账号实例。比如 WhatsApp 可以同时登录 personal 和 biz 两个号，Telegram 可以同时运行多个 Bot。

注意：Account 和 Agent 是多对多关系。

### 2.3 Binding（绑定）

路由规则，决定消息交给哪个 Agent 处理。匹配优先级：

1. peer（精确 DM/群组 ID）
2. parentPeer（线程继承）
3. guildId + roles（Discord 角色）
4. guildId（Discord 服务器）
5. teamId（Slack）
6. accountId（通道账号）
7. channel（通道级别）
8. default（兜底）

**精确匹配优先**。

---

## 三、快速上手

场景：创建两个智能体，home 处理个人消息，work 处理工作消息。

### 步骤 1：创建智能体

```bash
openclaw agents add home
openclaw agents add work
```

每个命令会创建独立的 workspace 和 agentDir。

### 步骤 2：登录通道账号

```bash
openclaw channels login --channel whatsapp --account personal
openclaw channels login --channel whatsapp --account biz
```

### 步骤 3：配置路由

编辑 `~/.openclaw/openclaw.json`：

```json
{
  "agents": {
    "list": [
      { "id": "home", "default": true },
      { "id": "work" }
    ]
  },
  "bindings": [
    { "agentId": "work", "match": { "channel": "whatsapp", "accountId": "biz" } },
    { "agentId": "home", "match": { "channel": "whatsapp", "accountId": "personal" } }
  ]
}
```

### 步骤 4：重启验证

```bash
openclaw gateway restart
openclaw agents list --bindings
```

---

## 四、路由规则详解

### 4.1 优先级规则

Binding 按配置顺序匹配，最具体的规则优先。

示例：

```json
{
  "bindings": [
    // 特定用户 DM
    { "agentId": "opus", "match": { "channel": "whatsapp", "peer": { "kind": "direct", "id": "+15551234567" } } },
    // 特定群组
    { "agentId": "work", "match": { "channel": "whatsapp", "peer": { "kind": "group", "id": "1203630...@g.us" } } },
    // 账号级别
    { "agentId": "work", "match": { "channel": "whatsapp", "accountId": "biz" } },
    // 通道级别
    { "agentId": "chat", "match": { "channel": "whatsapp" } }
  ]
}
```

匹配顺序：peer → accountId → channel → default。

### 4.2 常见匹配模式

| 场景 | 配置 |
|-----|------|
| 某个 WhatsApp 号 | `{ "channel": "whatsapp", "accountId": "biz" }` |
| 某个 Telegram Bot | `{ "channel": "telegram", "accountId": "alerts" }` |
| Discord 特定服务器 | `{ "channel": "discord", "guildId": "123456789" }` |
| Discord 特定频道 | `{ "channel": "discord", "guildId": "123456789", "channelId": "222222222" }` |

---

## 五、典型部署案例

### 5.1 Discord 多机器人

```json
{
  "agents": {
    "list": [
      { "id": "main" },
      { "id": "coding" }
    ]
  },
  "bindings": [
    { "agentId": "main", "match": { "channel": "discord", "accountId": "default" } },
    { "agentId": "coding", "match": { "channel": "discord", "accountId": "coding" } }
  ],
  "channels": {
    "discord": {
      "accounts": {
        "default": { "token": "BOT_TOKEN_MAIN" },
        "coding": { "token": "BOT_TOKEN_CODING" }
      }
    }
  }
}
```

### 5.2 WhatsApp 多号码

```json
{
  "agents": {
    "list": [
      { "id": "alex" },
      { "id": "mia" }
    ]
  },
  "bindings": [
    { "agentId": "alex", "match": { "channel": "whatsapp", "peer": { "kind": "direct", "id": "+15551230001" } } },
    { "agentId": "mia", "match": { "channel": "whatsapp", "peer": { "kind": "direct", "id": "+15551230002" } } }
  ],
  "channels": {
    "whatsapp": {
      "dmPolicy": "allowlist",
      "allowFrom": ["+15551230001", "+15551230002"]
    }
  }
}
```

### 5.3 跨通道组合

```json
{
  "agents": {
    "list": [
      { "id": "chat", "model": "anthropic/claude-sonnet-4-5" },
      { "id": "deep", "model": "anthropic/claude-opus-4-6" }
    ]
  },
  "bindings": [
    { "agentId": "chat", "match": { "channel": "whatsapp" } },
    { "agentId": "deep", "match": { "channel": "telegram" } }
  ]
}
```

---

## 六、注意事项

1. **auth-profiles 不自动共享**。每个 Agent 的认证独立，需要手动复制：`cp ~/.openclaw/agents/main/agent/auth-profiles.json ~/.openclaw/agents/work/agent/auth-profiles.json`

2. **不要复用 agentDir**。会导致认证冲突和会话混淆。

3. **注意 Binding 顺序**。精确匹配要放在前面，否则会被更宽泛的规则先拦截。

---

## 总结

多智能体路由实现了：

- 工作与生活场景的分离
- 不同通道账号的独立处理
- 灵活的消息路由机制
- 完整的数据隔离

配置本身不复杂，关键是理解 Agent、Account、Binding 三个概念和路由优先级。