---
title: "OpenClaw Skill 介绍：Coding Agent 编程助手"
date: 2025-03-06T01:10:00+08:00
draft: false
tags: ["openclaw", "skill", "编程", "AI助手", "codex", "claude"]
categories: ["工具介绍"]
---

# OpenClaw Skill 介绍：Coding Agent 编程助手

## 什么是 Coding Agent？

**coding-agent** 是一个 OpenClaw Skill，它允许你将编程任务委托给 Codex、Claude Code、Pi 等 AI 编程助手。无论是构建新功能、审查 PR、重构大型代码库，还是需要文件探索的迭代式编码，这个 Skill 都能帮上忙。

## 核心特性

### 1. 支持多种 AI 编程助手

| 工具 | 说明 |
|------|------|
| **Codex** | OpenAI 的编程助手，支持 GPT-5.2-codex |
| **Claude Code** | Anthropic 的 Claude 编程助手 |
| **Pi** | 轻量级编程助手 |
| **OpenCode** | 开源替代方案 |

### 2. 灵活的工作模式

**单次执行模式**：
- 适合快速任务
- 执行完自动退出
- 适合脚本和自动化

**后台模式**：
- 适合长时间运行的任务
- 可以监控进度
- 支持随时介入

### 3. 安全的执行环境

- **工作目录限制**：Agent 只能在指定目录内工作
- **Git 沙箱**：需要 git 目录才能运行
- **权限控制**：支持自动审批或手动确认

## 使用方法

### 快速开始

#### 单次执行（推荐用于简单任务）

```bash
# 基本用法 - 在临时目录执行
SCRATCH=$(mktemp -d) && cd $SCRATCH && git init && codex exec "Your prompt here"

# 在实际项目中执行（带 PTY）
bash pty:true workdir:~/Projects/myproject command:"codex exec 'Add error handling to the API calls'"
```

#### 后台模式（适合长时间任务）

```bash
# 启动后台任务（带 PTY）
bash pty:true workdir:~/project background:true command:"codex exec --full-auto 'Build a snake game'"

# 返回的 sessionId 用于后续管理
```

### 监控和管理后台任务

```bash
# 查看所有运行中的会话
process action:list

# 查看特定会话的日志
process action:log sessionId:XXX

# 检查会话是否还在运行
process action:poll sessionId:XXX

# 向会话发送输入（如果 Agent 提问）
process action:write sessionId:XXX data:"y"

# 发送输入并按回车
process action:submit sessionId:XXX data:"yes"

# 终止会话
process action:kill sessionId:XXX
```

## 实用场景

### 场景 1：快速原型开发

```bash
# 创建一个临时目录并初始化 git
SCRATCH=$(mktemp -d) && cd $SCRATCH && git init

# 让 Codex 快速构建一个原型
codex exec --full-auto "Build a React todo app with TypeScript"
```

### 场景 2：代码重构

```bash
# 在现有项目中重构代码
bash pty:true workdir:~/project command:"codex exec --full-auto 'Refactor the authentication module to use JWT'"
```

### 场景 3：PR 审查

**⚠️ 重要：不要在 OpenClaw 的项目目录中审查 PR！**

```bash
# 安全的 PR 审查流程
REVIEW_DIR=$(mktemp -d)
git clone https://github.com/user/repo.git $REVIEW_DIR
cd $REVIEW_DIR && gh pr checkout 130

# 使用 Codex 审查
bash pty:true workdir:$REVIEW_DIR command:"codex review --base origin/main"

# 清理
trash $REVIEW_DIR
```

### 场景 4：并行处理多个任务

```bash
# 同时处理多个 PR 审查
git fetch origin '+refs/pull/*/head:refs/remotes/origin/pr/*'

# 启动多个 Codex 实例
bash pty:true workdir:~/project background:true command:"codex exec 'Review PR #86'"
bash pty:true workdir:~/project background:true command:"codex exec 'Review PR #87'"

# 查看所有任务
process action:list
```

## 最佳实践

### 1. 始终使用 PTY

Coding Agent 是交互式终端应用，需要伪终端 (PTY) 才能正常工作。

```bash
# ✅ 正确 - 带 PTY
bash pty:true command:"codex exec 'Your task'"

# ❌ 错误 - 无 PTY，可能输出混乱或卡住
bash command:"codex exec 'Your task'"
```

### 2. 使用工作目录限制

始终指定 `workdir` 来限制 Agent 的工作范围：

```bash
bash pty:true workdir:~/project command:"codex exec 'Task'"
```

### 3. Git 仓库要求

Codex 需要在 git 仓库中运行。对于临时任务，创建临时 git 仓库：

```bash
SCRATCH=$(mktemp -d) && cd $SCRATCH && git init && codex exec "Task"
```

### 4. 不要在 OpenClaw 目录运行

**永远不要**在 `~/.openclaw/` 目录中启动 Coding Agent，它会读取你的个人配置文件并可能产生奇怪的行为。

### 5. 进度更新

对于长时间运行的后台任务，保持用户知情：

```bash
# 启动时发送一条消息
# 只在有重要进展时更新
# 任务完成时报告结果
```

## 总结

**coding-agent** Skill 是 OpenClaw 中最强大的工具之一。它将 AI 编程助手（Codex、Claude Code、Pi 等）集成到你的工作流中，让你能够：

- 快速构建原型和 MVP
- 重构和优化现有代码
- 并行审查多个 PR
- 自动化重复性编程任务

通过合理使用 PTY、工作目录限制和后台模式，你可以安全高效地利用 AI 助手提升编程效率。

---

**相关链接：**
- [Codex CLI 文档](https://platform.openai.com/docs/guides/codex)
- [Claude Code 文档](https://docs.anthropic.com/en/docs/agents-and-tools/claude-code)
- [OpenClaw Skills 文档](https://docs.openclaw.ai)
