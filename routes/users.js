const express = require('express');
const router = express.Router();
const { select, insert } = require('../config/db');

// 用户注册
router.post('/register', async (req, res) => {
    try {
        const { username, password, email, phone } = req.body;
        
        // 验证必填字段
        if (!username || !password) {
            return res.status(400).json({
                success: false,
                message: '用户名和密码不能为空'
            });
        }
        
        // 检查用户名是否已存在
        const existingUsers = await select('users', '*', { username });
        
        if (existingUsers.length > 0) {
            return res.status(400).json({
                success: false,
                message: '用户名已存在'
            });
        }
        
        // 插入新用户
        await insert('users', {
            username,
            password, // TODO: 实际项目中应该使用 bcrypt 加密
            email: email || null,
            phone: phone || null
        });
        
        res.json({
            success: true,
            message: '注册成功'
        });
    } catch (error) {
        res.status(500).json({
            success: false,
            message: '注册失败',
            error: error.message
        });
    }
});

// 用户登录
router.post('/login', async (req, res) => {
    try {
        const { username, password } = req.body;
        
        // 验证必填字段
        if (!username || !password) {
            return res.status(400).json({
                success: false,
                message: '用户名和密码不能为空'
            });
        }
        
        // 查询用户
        const users = await select('users', 'id, username, email, phone, created_at', { 
            username, 
            password 
        });
        
        if (users.length === 0) {
            return res.status(401).json({
                success: false,
                message: '用户名或密码错误'
            });
        }
        
        res.json({
            success: true,
            message: '登录成功',
            data: users[0]
        });
    } catch (error) {
        res.status(500).json({
            success: false,
            message: '登录失败',
            error: error.message
        });
    }
});

// 获取用户信息
router.get('/:id', async (req, res) => {
    try {
        const { id } = req.params;
        const users = await select('users', 'id, username, email, phone, created_at', { id: parseInt(id) });
        
        if (users.length === 0) {
            return res.status(404).json({
                success: false,
                message: '用户不存在'
            });
        }
        
        res.json({
            success: true,
            data: users[0]
        });
    } catch (error) {
        res.status(500).json({
            success: false,
            message: '获取用户信息失败',
            error: error.message
        });
    }
});

module.exports = router;
