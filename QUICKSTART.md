# 🚀 快速开始 - 3 分钟部署指南

想要让别人访问你的图书管理系统？只需 3 步！

---

##  本地测试（给别人演示）

### 方法一：双击启动（最简单）
1. 把整个 `library-system` 文件夹打包成 zip
2. 发给对方
3. 对方解压后，双击 `start.bat`
4. 浏览器自动打开，即可使用

**要求**：对方电脑已安装 Node.js

### 方法二：手动启动
```bash
cd backend
npm install
node server.js
```
然后用浏览器打开 `frontend/index.html`

---

## ☁️ 云端部署（推荐 - 永久在线）

### 第 1 步：推送到 GitHub（5 分钟）

```bash
cd D:\实习\library-system

# 初始化 git
git init
git add .
git commit -m "Initial commit"

# 关联远程仓库（替换为你的 GitHub 用户名）
git remote add origin https://github.com/你的用户名/library-system.git

# 推送
git push -u origin main
```

> 💡 如果还没有 GitHub 账号，先访问 https://github.com 注册

---

### 第 2 步：部署后端到 Railway（10 分钟）

1. **注册 Railway**
   - 访问：https://railway.app
   - 点击 "Login with GitHub"

2. **创建项目**
   - New Project → Deploy from GitHub repo
   - 选择 `library-system` 仓库

3. **配置环境变量**
   在 Variables 标签添加：
   ```
   SUPABASE_URL = https://你的项目ID.supabase.co
   SUPABASE_KEY = 你的anon公钥
   PORT = 3000
   NODE_ENV = production
   ```
   > 💡 这些值和你本地 `.env` 文件一样

4. **获取后端地址**
   - 等待部署完成（约 5 分钟）
   - 复制域名，如：`https://library-system-production.up.railway.app`

5. **测试后端**
   浏览器访问：`https://xxx.up.railway.app/api/books`
   - 应该看到 JSON 格式的图书列表 ✅

---

### 第 3 步：部署前端到 Vercel（5 分钟）

1. **修改 API 地址**
   编辑 `frontend/index.html`，找到：
   ```javascript
   const API_BASE = 'http://localhost:3000/api';
   ```
   改为你的 Railway 地址：
   ```javascript
   const API_BASE = 'https://library-system-production.up.railway.app/api';
   ```

2. **提交到 GitHub**
   ```bash
   git add frontend/index.html
   git commit -m "Update API for production"
   git push
   ```

3. **注册 Vercel**
   - 访问：https://vercel.com
   - 点击 "Sign Up" → "Continue with GitHub"

4. **导入项目**
   - Add New Project → Import Git Repository
   - 选择 `library-system` 仓库
   - **Root Directory** 设置为：`frontend`
   - 点击 "Deploy"

5. **获取前端地址**
   - 等待部署完成（约 2 分钟）
   - 复制域名，如：`https://library-system.vercel.app`

---

## 🎉 完成！

现在你可以把以下地址分享给任何人：

```
📚 图书管理系统

访问地址：https://library-system.vercel.app

功能：
✅ 浏览 60+ 本图书
✅ 按分类筛选（文学、计算机科学等）
✅ 搜索图书
✅ 在线借书/还书
✅ 查看个人借阅记录

首次使用需要注册账号，完全免费！
```

---

##  遇到问题？

### 问题 1：Railway 部署失败
**解决**：检查环境变量是否正确，查看 Logs 标签的错误信息

### 问题 2：Vercel 部署后无法连接后端
**解决**：确认 `API_BASE` 已改为 Railway 的地址

### 问题 3：不知道如何获取 Supabase 密钥
**解决**：打开 Supabase → Settings → API，复制 Project URL 和 anon public key

### 更多帮助
- 查看 `CHECKLIST.md`（详细步骤清单）
- 查看 `DEPLOYMENT.md`（完整部署指南）
- 查看 `README.md`（常见问题解答）

---

## 💰 成本说明

- **Vercel**：免费（每月 100GB 带宽）
- **Railway**：免费（每月 $5 额度）
- **Supabase**：免费（500MB 数据库空间）

**总成本：$0/月** 

如果流量大了可以升级付费套餐（Vercel $20/月起，Railway $5/月起）

---

## 🛠️ 后续维护

### 更新代码
每次修改代码后：
```bash
git add .
git commit -m "描述修改内容"
git push
```
Vercel 和 Railway 会自动重新部署

### 查看日志
- **Railway**：项目 → Logs 标签
- **Vercel**：项目 → Deployments → View Build Logs

### 备份数据库
定期在 Supabase 中导出备份：
Database → Backups → Create backup

---

祝你部署顺利！🚀

如有问题，欢迎联系作者：雷依芸
