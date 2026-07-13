# 📚 图书管理系统

一个基于 Node.js + Supabase 的在线图书管理系统，支持图书浏览、借阅、归还和记录查询功能。

##  在线访问

**前端地址：** [待部署后填写]  
**后端 API：** [待部署后填写]

---

## 🚀 快速开始（本地开发）

### 前置要求
- Node.js 16+ 
- npm 或 yarn
- Supabase 账号（免费）

### 安装步骤

#### 1. 克隆项目
```bash
git clone <你的GitHub仓库地址>
cd library-system
```

#### 2. 配置 Supabase 数据库

##### 2.1 创建 Supabase 项目
1. 访问 [https://supabase.com](https://supabase.com)
2. 注册/登录账号
3. 点击 "New Project"
4. 选择免费计划，填写项目名称和密码

##### 2.2 获取 API 密钥
1. 进入项目 → Settings → API
2. 复制以下信息：
   - **Project URL**（如：`https://xxxxx.supabase.co`）
   - **anon public key**（匿名公钥）

##### 2.3 创建环境变量文件
在 `backend` 目录下创建 `.env` 文件：
```env
SUPABASE_URL=https://你的项目ID.supabase.co
SUPABASE_KEY=你的anon公钥
PORT=3000
```

##### 2.4 初始化数据库
1. 打开 Supabase → SQL Editor
2. 复制 `backend/supabase-setup.sql` 的内容
3. 点击 "Run" 执行

##### 2.5 导入示例数据（可选）
1. 继续执行 `backend/add-more-books.sql`
2. 继续执行 `backend/add-book-descriptions.sql`

#### 3. 安装依赖
```bash
cd backend
npm install
```

#### 4. 启动后端服务器
```bash
node server.js
```

服务器将在 `http://localhost:3000` 启动

#### 5. 打开前端页面
直接用浏览器打开 `frontend/index.html` 即可

---

## 📁 项目结构

```
library-system/
├── frontend/                  # 前端代码
│   └── index.html            # 主页面（HTML/CSS/JS）
├── backend/                   # 后端代码
│   ├── server.js             # Express 服务器入口
│   ├── routes/               # API 路由
│   │   ├── books.js          # 图书相关接口
│   │   ├── users.js          # 用户相关接口
│   │   └── records.js        # 借阅记录接口
│   ├── config/
│   │   └── db.js             # Supabase 数据库配置
│   ├── supabase-setup.sql    # 数据库初始化脚本
│   ├── add-more-books.sql    # 示例图书数据
│   └── add-book-descriptions.sql  # 图书简介数据
└── README.md                 # 本文档
```

---

## 🔧 API 接口说明

### 用户相关
- `POST /api/users/register` - 用户注册
- `POST /api/users/login` - 用户登录

### 图书相关
- `GET /api/books` - 获取所有图书
- `GET /api/books/:id` - 获取单本图书详情
- `GET /api/books/search?keyword=xxx` - 搜索图书（支持书名、作者、ISBN、分类）
- `POST /api/books` - 添加图书（需管理员权限）
- `PUT /api/books/:id` - 修改图书（需管理员权限）
- `DELETE /api/books/:id` - 删除图书（需管理员权限）

### 借阅记录相关
- `GET /api/records/:userId` - 获取用户借阅记录
- `POST /api/records/borrow` - 借书
- `POST /api/records/return` - 还书

---

## 🎨 功能特性

- ✅ 用户注册/登录（支持邮箱和手机号）
- ✅ 图书浏览（按分类筛选、关键词搜索）
- ✅ 图书详情查看（包含简介）
- ✅ 在线借书/还书
- ✅ 个人借阅记录查询
- ✅ 登录状态持久化（刷新不退出）
- ✅ 响应式设计，支持移动端

---

## 🛠️ 技术栈

**前端：**
- HTML5 + CSS3 + JavaScript (ES6+)
- 原生 DOM 操作（无框架）

**后端：**
- Node.js + Express 5.x
- Supabase (PostgreSQL)
- RESTful API

**数据库：**
- PostgreSQL（通过 Supabase 托管）

---

## 📝 注意事项

1. **首次使用需要注册账号**，系统不支持游客模式
2. **借书前请确认图书有库存**（可借数量 > 0）
3. **只能归还自己借阅的图书**
4. **搜索功能支持模糊匹配**，可搜索书名、作者、ISBN 或分类

---

## 🐛 常见问题

### Q: 后端启动报错 "Cannot find module '@supabase/supabase-js'"
A: 确保在 `backend` 目录下运行了 `npm install`

### Q: 前端无法连接后端
A: 检查 `index.html` 中的 `API_BASE` 是否指向正确的后端地址（默认 `http://localhost:3000/api`）

### Q: 搜索不到图书
A: 确保数据库中已有数据，可以执行 `add-more-books.sql` 导入示例数据

### Q: 登录后刷新页面退出
A: 检查浏览器的 localStorage 是否被禁用

---

## 📄 许可证

MIT License

---

## 👤 作者

雷依芸

---

## 🙏 致谢

感谢 Supabase 提供的免费数据库服务！
