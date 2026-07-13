#  部署指南

本文档说明如何将图书管理系统部署到云端，让其他人可以通过网址访问。

---

## 方案概览

我们将采用以下架构：
- **前端**：Vercel（免费静态托管）
- **后端**：Railway（免费 Node.js + PostgreSQL 托管）
- **数据库**：Supabase（已配置好的云数据库）

总成本：**$0/月**（使用免费套餐）

---

## 第一步：准备 GitHub 仓库

### 1.1 创建 GitHub 账号
如果还没有 GitHub 账号，访问 [https://github.com](https://github.com) 注册

### 1.2 创建新仓库
1. 点击右上角 "+" → "New repository"
2. 填写仓库名称：`library-system`
3. 选择 "Public"（公开）
4. 点击 "Create repository"

### 1.3 推送代码到 GitHub

在本地项目根目录（`D:\实习\library-system`）打开命令行：

```bash
# 初始化 git（如果还没有）
git init

# 添加所有文件
git add .

# 提交
git commit -m "Initial commit: Library Management System"

# 关联远程仓库（替换为你的仓库地址）
git remote add origin https://github.com/你的用户名/library-system.git

# 推送
git push -u origin main
```

---

## 第二步：部署后端到 Railway

### 2.1 注册 Railway 账号
1. 访问 [https://railway.app](https://railway.app)
2. 点击 "Login with GitHub"（用 GitHub 账号登录）
3. 授权 Railway 访问你的 GitHub

### 2.2 创建新项目
1. 点击 "New Project"
2. 选择 "Deploy from GitHub repo"
3. 选择你刚才创建的 `library-system` 仓库
4. Railway 会自动检测到 `backend` 目录

### 2.3 配置环境变量
1. 进入项目 → Variables 标签
2. 添加以下环境变量：
   ```
   SUPABASE_URL = https://你的项目ID.supabase.co
   SUPABASE_KEY = 你的anon公钥
   PORT = 3000
   NODE_ENV = production
   ```
   
   > 💡 这些值和你本地 `.env` 文件中的一样

### 2.4 等待部署完成
Railway 会自动构建并部署，大约需要 2-5 分钟

### 2.5 获取后端地址
1. 进入项目 → Settings → Domains
2. 复制生成的域名，如：`https://library-system-production.up.railway.app`

---

## 第三步：部署前端到 Vercel

### 3.1 注册 Vercel 账号
1. 访问 [https://vercel.com](https://vercel.com)
2. 点击 "Sign Up" → "Continue with GitHub"
3. 授权 Vercel 访问你的 GitHub

### 3.2 导入项目
1. 点击 "Add New Project"
2. 选择 "Import Git Repository"
3. 选择 `library-system` 仓库
4. 点击 "Import"

### 3.3 配置构建设置
1. **Framework Preset**：选择 "Other"
2. **Root Directory**：设置为 `frontend`
3. **Build Command**：留空（不需要构建）
4. **Output Directory**：留空

### 3.4 部署
点击 "Deploy"，等待 1-2 分钟

### 3.5 获取前端地址
部署完成后，Vercel 会给你一个域名，如：`https://library-system.vercel.app`

---

## 第四步：配置前端连接后端

### 方法一：修改 index.html（推荐）

编辑 `frontend/index.html`，找到这一行：

```javascript
const API_BASE = 'http://localhost:3000/api';
```

改为你的 Railway 后端地址：

```javascript
const API_BASE = 'https://library-system-production.up.railway.app/api';
```

然后重新推送到 GitHub：

```bash
git add frontend/index.html
git commit -m "Update API_BASE for production"
git push
```

Vercel 会自动重新部署前端

### 方法二：使用 URL 参数（临时测试）

如果不修改代码，可以在访问前端时加上参数：

```
https://library-system.vercel.app?api=https://library-system-production.up.railway.app/api
```

---

## 第五步：测试在线系统

### 5.1 访问前端
打开浏览器，访问你的 Vercel 地址：
```
https://library-system.vercel.app
```

### 5.2 注册账号
1. 点击"注册"标签
2. 填写用户名、密码、邮箱、手机号
3. 点击"注册"

### 5.3 测试功能
- ✅ 浏览图书列表
- ✅ 按分类筛选
- ✅ 搜索图书
- ✅ 查看图书详情
- ✅ 借书
- ✅ 还书
- ✅ 查看借阅记录

---

## 第六步：分享给别人

现在你可以把前端地址分享给任何人：

```
📚 欢迎使用图书管理系统！

访问地址：https://library-system.vercel.app

功能：
- 浏览 60+ 本图书
- 按分类筛选（文学、计算机科学、历史等）
- 在线借书/还书
- 查看个人借阅记录

首次使用需要注册账号，完全免费！
```

---

## 常见问题

### Q1: Railway 部署失败怎么办？
检查以下几点：
- 确保 `backend/package.json` 存在
- 确保 `backend/server.js` 是入口文件
- 检查环境变量是否正确配置
- 查看 Railway 的 Logs 标签，看具体错误信息

### Q2: Vercel 部署后前端无法连接后端？
- 确认 `API_BASE` 已改为 Railway 的地址
- 确认 Railway 后端正在运行（访问 `/api/books` 看是否有数据）
- 检查浏览器控制台是否有 CORS 错误

### Q3: 如何自定义域名？
- **Vercel**：Settings → Domains → Add Domain
- **Railway**：Settings → Domains → Add Custom Domain
- 需要你有自己的域名（可在阿里云、腾讯云购买）

### Q4: 免费套餐有限制吗？
- **Vercel**：每月 100GB 带宽，足够小型项目
- **Railway**：每月 $5 额度，Node.js 项目通常够用
- **Supabase**：500MB 数据库空间，足够存储几千本书

如果流量大了，可以升级到付费套餐（Vercel $20/月，Railway $5/月起）

---

## 进阶优化（可选）

### 启用 HTTPS
Vercel 和 Railway 默认都提供 HTTPS，无需额外配置

### 添加 CORS 支持
如果前端和后端域名不同，需要在后端添加 CORS 中间件：

在 `backend/server.js` 中添加：

```javascript
const cors = require('cors');
app.use(cors({
    origin: ['https://library-system.vercel.app', 'http://localhost:3000'],
    credentials: true
}));
```

然后安装依赖：
```bash
cd backend
npm install cors
git add package.json package-lock.json
git commit -m "Add CORS support"
git push
```

### 设置自动部署
每次推送到 GitHub，Vercel 和 Railway 都会自动重新部署，无需手动操作

---

## 监控和维护

### 查看日志
- **Railway**：项目 → Logs 标签
- **Vercel**：项目 → Deployments → 点击某次部署 → View Build Logs

### 更新代码
1. 本地修改代码
2. `git add . && git commit -m "描述"`
3. `git push`
4. 等待自动部署完成（约 2-5 分钟）

### 备份数据库
定期在 Supabase 中导出数据库备份：
1. Supabase → Database → Backups
2. 点击 "Create backup"

---

## 技术支持

如果遇到问题，可以：
1. 查看 README.md 中的常见问题
2. 检查 Railway/Vercel 的日志
3. 联系作者：雷依芸

祝你部署顺利！🎉
