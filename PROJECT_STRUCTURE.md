# 📁 项目结构说明

```
library-system/
├── README.md                  # 项目介绍 + 本地开发指南
├── QUICKSTART.md             # 3分钟快速部署指南
├── CHECKLIST.md              # 详细部署步骤清单（可打勾）
├── DEPLOYMENT.md             # 完整部署指南 + 故障排查
├── NEXT_STEPS.md             # 下一步操作指南
├── .gitignore                # Git 忽略文件配置
├── start.bat                 # Windows 一键启动脚本
│
├── frontend/                 # 前端代码
│   ├── index.html           # 主页面（HTML/CSS/JS）
│   └── vercel.json          # Vercel 部署配置
│
├── backend/                  # 后端代码
│   ├── server.js            # Express 服务器入口
│   ├── package.json         # Node.js 依赖配置
│   ├── railway.toml         # Railway 部署配置
│   ├── .env                 # 环境变量（本地开发用，不提交到 Git）
│   │
│   ├── config/
│   │   └── db.js            # Supabase 数据库连接配置
│   │
│   ├── routes/              # API 路由
│   │   ├── books.js         # 图书相关接口
│   │   ├── users.js         # 用户相关接口
│   │   ── borrow.js        # 借阅记录接口
│   │
│   ├── supabase-setup.sql   # 数据库初始化脚本（创建表）
│   ├── add-more-books.sql   # 示例图书数据（54本）
│   └── add-book-descriptions.sql  # 图书简介数据
│
└── database/                # 数据库相关文件
    └── create_tables.sql    # 数据库表结构定义（备用）
```

---

## 📄 核心文件说明

### 根目录文件

| 文件名 | 用途 | 重要程度 |
|--------|------|----------|
| **README.md** | 项目介绍、功能说明、本地开发指南 | ⭐⭐⭐⭐ |
| **QUICKSTART.md** | 3分钟快速部署到云端 | ⭐⭐⭐⭐⭐ |
| **CHECKLIST.md** | 详细部署步骤清单，每步可打勾 | ⭐⭐⭐⭐⭐ |
| **DEPLOYMENT.md** | 完整部署指南 + 常见问题解答 | ⭐⭐⭐⭐ |
| **NEXT_STEPS.md** | 下一步操作指南 | ⭐⭐⭐ |
| **.gitignore** | Git 忽略配置（防止提交敏感文件） | ⭐⭐⭐⭐ |
| **start.bat** | Windows 一键启动脚本（双击即可运行） | ⭐⭐⭐ |

### 前端文件

| 文件名 | 用途 |
|--------|------|
| **index.html** | 唯一的前端文件，包含所有 HTML/CSS/JavaScript |
| **vercel.json** | Vercel 部署配置文件 |

### 后端文件

| 文件名 | 用途 |
|--------|------|
| **server.js** | Express 服务器入口，定义路由和中间件 |
| **package.json** | Node.js 项目配置，声明依赖包 |
| **railway.toml** | Railway 部署配置文件 |
| **.env** | 环境变量（Supabase URL 和密钥），**不要提交到 Git** |

#### 后端子目录

| 路径 | 用途 |
|------|------|
| `config/db.js` | Supabase 数据库连接配置 |
| `routes/books.js` | 图书 CRUD + 搜索接口 |
| `routes/users.js` | 用户注册/登录接口 |
| `routes/borrow.js` | 借书/还书/查询记录接口 |

#### SQL 脚本

| 文件名 | 用途 | 执行顺序 |
|--------|------|----------|
| **supabase-setup.sql** | 创建 users、books、borrow_records 三张表 | 1️⃣ 首先执行 |
| **add-more-books.sql** | 插入 54 本示例图书数据 | 2️⃣ 可选执行 |
| **add-book-descriptions.sql** | 为所有图书添加简介 | 3️ 可选执行 |

---

## 🔑 关键配置

### 1. 环境变量（backend/.env）

```env
SUPABASE_URL=https://你的项目ID.supabase.co
SUPABASE_KEY=你的anon公钥
PORT=3000
NODE_ENV=development
```

> ⚠️ **重要**：`.env` 文件已加入 `.gitignore`，不会提交到 GitHub。部署到 Railway 时需要在后台手动配置这些变量。

### 2. 前端 API 地址（frontend/index.html）

```javascript
// 本地开发
const API_BASE = 'http://localhost:3000/api';

// 生产环境（部署后修改）
const API_BASE = 'https://your-backend.railway.app/api';
```

### 3. Git 忽略规则（.gitignore）

以下文件/文件夹不会提交到 GitHub：
- `node_modules/` - npm 依赖包（太大，可重新安装）
- `.env` - 敏感的环境变量
- `*.log` - 日志文件
- `.DS_Store`、`Thumbs.db` - 系统临时文件

---

## 🛠️ 技术栈

### 前端
- **语言**：HTML5 + CSS3 + JavaScript (ES6+)
- **框架**：无（原生 DOM 操作）
- **部署**：Vercel（免费静态托管）

### 后端
- **运行时**：Node.js 16+
- **框架**：Express 5.x
- **数据库客户端**：@supabase/supabase-js
- **部署**：Railway（免费 Node.js 托管）

### 数据库
- **类型**：PostgreSQL
- **托管**：Supabase（免费云数据库，500MB 空间）
- **表结构**：
  - `users` - 用户表（id, username, password, email, phone）
  - `books` - 图书表（id, title, author, isbn, category, description...）
  - `borrow_records` - 借阅记录表（id, user_id, book_id, borrow_date, return_date, status）

---

## 📊 数据规模

- **图书数量**：59 本（5 本原始 + 54 本新增）
- **分类数量**：15 个（文学、历史、计算机科学、编程等）
- **用户容量**：无限制（取决于 Supabase 免费套餐的 50,000 行限制）
- **借阅记录**：无限制（同上）

---

## 🔄 工作流程

### 本地开发流程
1. 修改代码
2. 测试功能
3. `git add . && git commit -m "描述"`
4. `git push`

### 云端部署流程
1. 推送到 GitHub → Vercel/Railway 自动检测
2. 等待 2-5 分钟自动部署
3. 访问新网址验证功能

### 数据库管理流程
1. 在 Supabase SQL Editor 中执行 SQL 脚本
2. 或在 Dashboard 中直接编辑数据
3. 定期备份（Database → Backups → Create backup）

---

##  快速参考

### 启动本地服务
```bash
# 方法一：双击 start.bat（Windows）

# 方法二：命令行
cd backend
npm install      # 首次运行需要
node server.js   # 启动后端

# 然后用浏览器打开 frontend/index.html
```

### 部署到云端
1. 查看 `QUICKSTART.md`（3 分钟快速部署）
2. 或查看 `CHECKLIST.md`（详细步骤清单）

### 遇到问题？
1. 查看 `README.md` 的"常见问题"部分
2. 查看 `DEPLOYMENT.md` 的"故障排查"部分
3. 查看各平台的 Logs（Railway/Vercel）

---

## 📞 联系方式

作者：**雷依芸**  
项目时间：2026 年 7 月  
许可证：MIT License

如有问题，欢迎通过 GitHub Issues 反馈或直接联系作者！
