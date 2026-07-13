const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
require('dotenv').config();

// 导入数据库模块
const { initDatabase } = require('./config/db');

// 导入路由
const booksRouter = require('./routes/books');
const usersRouter = require('./routes/users');
const borrowRouter = require('./routes/borrow');

const app = express();
const PORT = process.env.PORT || 3000;

// 初始化数据库
initDatabase().then(() => {
    console.log('数据库初始化完成');
}).catch(err => {
    console.error('数据库初始化失败:', err);
    process.exit(1);
});

// 中间件
app.use(cors()); // 允许跨域请求
app.use(bodyParser.json()); // 解析 JSON 请求体
app.use(bodyParser.urlencoded({ extended: true })); // 解析 URL 编码的请求体

// 日志中间件（开发环境使用）
app.use((req, res, next) => {
    console.log(`[${new Date().toISOString()}] ${req.method} ${req.path}`);
    next();
});

// API 路由
app.use('/api/books', booksRouter);
app.use('/api/users', usersRouter);
app.use('/api', borrowRouter);

// 健康检查接口
app.get('/api/health', (req, res) => {
    res.json({
        success: true,
        message: '服务器运行正常',
        timestamp: new Date().toISOString()
    });
});

// 404 处理 - 放在所有路由之后
app.use((req, res) => {
    res.status(404).json({
        success: false,
        message: '接口不存在'
    });
});

// 错误处理中间件
app.use((err, req, res, next) => {
    console.error('服务器错误:', err);
    res.status(500).json({
        success: false,
        message: '服务器内部错误',
        error: err.message
    });
});

// 启动服务器
app.listen(PORT, () => {
    console.log(`========================================`);
    console.log(`图书管理系统后端服务器已启动`);
    console.log(`端口: ${PORT}`);
    console.log(`访问地址: http://localhost:${PORT}`);
    console.log(`========================================`);
});

module.exports = app;
