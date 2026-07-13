# 📋 部署检查清单

按照以下步骤完成部署，每完成一步就打勾 ✅

---

## 准备阶段

- [ ] **1. 注册 GitHub 账号**（如果还没有）
  - 访问：https://github.com
  - 记住用户名和密码

- [ ] **2. 创建 GitHub 仓库**
  - 仓库名：`library-system`
  - 类型：Public（公开）

- [ ] **3. 推送代码到 GitHub**
  ```bash
  cd D:\实习\library-system
  git init
  git add .
  git commit -m "Initial commit"
  git remote add origin https://github.com/你的用户名/library-system.git
  git push -u origin main
  ```

---

## 数据库配置

- [ ] **4. 确认 Supabase 项目已创建**
  - 访问：https://supabase.com
  - 复制 Project URL 和 anon key

- [ ] **5. 初始化数据库表**
  - 打开 Supabase → SQL Editor
  - 执行 `backend/supabase-setup.sql`

- [ ] **6. 导入示例数据（可选）**
  - 执行 `backend/add-more-books.sql`
  - 执行 `backend/add-book-descriptions.sql`

---

## 后端部署（Railway）

- [ ] **7. 注册 Railway 账号**
  - 访问：https://railway.app
  - 用 GitHub 登录

- [ ] **8. 创建新项目**
  - New Project → Deploy from GitHub repo
  - 选择 `library-system` 仓库

- [ ] **9. 配置环境变量**
  在 Railway Variables 中添加：
  ```
  SUPABASE_URL = https://xxx.supabase.co
  SUPABASE_KEY = eyJhbGc...（你的anon公钥）
  PORT = 3000
  NODE_ENV = production
  ```

- [ ] **10. 等待部署完成**
  - 查看 Logs 确认无错误
  - 复制生成的域名（如：`https://xxx.up.railway.app`）

- [ ] **11. 测试后端 API**
  浏览器访问：`https://xxx.up.railway.app/api/books`
  - 应该看到 JSON 格式的图书列表

---

## 前端部署（Vercel）

- [ ] **12. 修改前端 API 地址**
  编辑 `frontend/index.html`，找到：
  ```javascript
  const API_BASE = 'http://localhost:3000/api';
  ```
  改为：
  ```javascript
  const API_BASE = 'https://xxx.up.railway.app/api';
  ```
  （替换为你的 Railway 域名）

- [ ] **13. 提交修改到 GitHub**
  ```bash
  git add frontend/index.html
  git commit -m "Update API_BASE for production"
  git push
  ```

- [ ] **14. 注册 Vercel 账号**
  - 访问：https://vercel.com
  - 用 GitHub 登录

- [ ] **15. 导入项目**
  - Add New Project → Import Git Repository
  - 选择 `library-system` 仓库
  - Root Directory 设置为：`frontend`

- [ ] **16. 等待部署完成**
  - 复制生成的域名（如：`https://library-system.vercel.app`）

---

## 测试阶段

- [ ] **17. 访问前端网址**
  打开：`https://library-system.vercel.app`

- [ ] **18. 注册测试账号**
  - 用户名：testuser
  - 密码：test123456
  - 邮箱：test@example.com
  - 手机：13800138000

- [ ] **19. 测试核心功能**
  - [ ] 浏览图书列表
  - [ ] 按分类筛选（点击"文学"、"计算机科学"等标签）
  - [ ] 搜索图书（搜索框输入关键词）
  - [ ] 查看图书详情（点击书名或"详情"按钮）
  - [ ] 借书（输入图书ID，点击"确认借书"）
  - [ ] 还书（输入图书ID，点击"确认还书"）
  - [ ] 查看借阅记录（点击左侧"借阅记录"）

- [ ] **20. 测试登录持久化**
  - 刷新页面，确认不会退出登录

---

## 分享阶段

- [ ] **21. 更新 README.md**
  编辑 `README.md`，把"在线访问"部分改为实际地址：
  ```markdown
  ## 🌐 在线访问
  
  **前端地址：** https://library-system.vercel.app  
  **后端 API：** https://xxx.up.railway.app/api
  ```

- [ ] **22. 提交最终版本**
  ```bash
  git add README.md
  git commit -m "Update deployment URLs"
  git push
  ```

- [ ] **23. 分享给朋友**
  发送以下消息：
  ```
  📚 欢迎使用我的图书管理系统！
  
  访问地址：https://library-system.vercel.app
  
  功能：
  - 浏览 60+ 本图书
  - 按分类筛选
  - 在线借书/还书
  - 查看个人借阅记录
  
  首次使用需要注册账号，完全免费！
  ```

---

## 维护阶段（可选）

- [ ] **24. 设置自定义域名**（如果有自己的域名）
  - Vercel：Settings → Domains → Add Domain
  - Railway：Settings → Domains → Add Custom Domain

- [ ] **25. 启用 HTTPS**（Vercel/Railway 默认已启用）

- [ ] **26. 添加 CORS 支持**（如果前端和后端域名不同）
  见 `DEPLOYMENT.md` 中的"进阶优化"部分

- [ ] **27. 定期备份数据库**
  - Supabase → Database → Backups → Create backup

---

## 故障排查

如果某一步失败，参考以下解决方案：

### Railway 部署失败
- 检查 `backend/package.json` 是否存在
- 检查环境变量是否正确
- 查看 Railway Logs 标签的错误信息

### Vercel 部署失败
- 确认 Root Directory 设置为 `frontend`
- 查看 Vercel Deployments → View Build Logs

### 前端无法连接后端
- 确认 `API_BASE` 已改为 Railway 地址
- 确认 Railway 后端正在运行
- 检查浏览器控制台是否有 CORS 错误

### 其他问题
- 查看 `README.md` 中的"常见问题"
- 查看 `DEPLOYMENT.md` 中的详细说明

---

## 🎉 完成！

当所有步骤都打勾后，恭喜你成功部署了图书管理系统！

现在任何人都可以通过网址访问你的系统了 🚀
