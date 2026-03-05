# Cloudflare Pages 部署指南

## 方法一：通过 Git 集成部署（推荐）

### 步骤 1：推送代码到 GitHub

```bash
cd ~/myblog

# 确保所有更改已提交
git add -A
git commit -m "Ready for Cloudflare Pages deployment"

# 推送到 GitHub（替换 <你的用户名>）
git remote add origin https://github.com/<你的用户名>/myblog.git 2>/dev/null || true
git push -u origin master
```

### 步骤 2：在 Cloudflare 配置

1. 登录 https://dash.cloudflare.com
2. 点击左侧菜单 `Pages`
3. 点击 `Create a project`
4. 选择 `Connect to Git`
5. 授权 GitHub 账号
6. 选择你的 `myblog` 仓库
7. 开始设置：

   | 设置项 | 值 |
   |--------|-----|
   | Project name | myblog（或自定义） |
   | Production branch | master |
   | Framework preset | None |
   | Build command | `hugo --minify` |
   | Build output directory | `public` |
   | Root directory | / |

8. 点击 `Save and Deploy`

### 步骤 3：等待部署完成

- 部署通常需要 1-2 分钟
- 完成后会显示访问链接：`https://<project-name>.pages.dev`

---

## 方法二：直接上传（无需 Git）

如果你不想用 Git，可以直接上传构建好的文件：

```bash
# 1. 在本地构建
cd ~/myblog
hugo --minify

# 2. 压缩 public 目录
cd public && zip -r ../blog.zip . && cd ..
```

然后在 Cloudflare Pages：
1. 点击 `Create a project`
2. 选择 `Upload assets`
3. 上传 `blog.zip`
4. 设置项目名
5. 完成部署

---

## 🔧 常见问题

### 1. 构建失败提示 "hugo: command not found"

**解决**：在 Cloudflare Pages 的环境变量中添加 Hugo 版本：

1. 进入项目设置
2. 点击 `Environment variables`
3. 添加变量：
   - 变量名：`HUGO_VERSION`
   - 值：`0.157.0`（或最新版本）

### 2. 页面样式加载异常

**解决**：检查 `hugo.toml` 中的 `baseURL`：

```toml
# 开发时用本地
baseURL = '/'

# 部署到 Cloudflare Pages 后改为：
baseURL = 'https://<你的项目名>.pages.dev/'
```

### 3. 如何绑定自定义域名？

1. 在 Cloudflare Pages 项目里点击 `Custom domains`
2. 点击 `Set up a custom domain`
3. 输入你的域名
4. 按照提示添加 DNS 记录

### 4. 如何更新博客？

**Git 方式**：
```bash
cd ~/myblog

# 写新文章
hugo new content posts/new-post.md

# 编辑文章
nano content/posts/new-post.md

# 提交并推送（自动部署）
git add .
git commit -m "Add new post"
git push
```

Cloudflare Pages 会自动重新部署！

---

## 📚 相关链接

- Cloudflare Pages 文档：https://developers.cloudflare.com/pages/
- Hugo 文档：https://gohugo.io/documentation/
- Hextra 文档：https://imfing.github.io/hextra/

---

**需要帮助？** 告诉我你卡在哪个步骤，我帮你解决！
