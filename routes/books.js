const express = require('express');
const router = express.Router();
const { select, insert, update, remove } = require('../config/db');

// 管理员验证中间件
function requireAdmin(req, res, next) {
    const username = req.headers['x-username'];
    const adminUsers = (process.env.ADMIN_USERS || 'admin').split(',').map(u => u.trim());
    if (!username || !adminUsers.includes(username)) {
        return res.status(403).json({ success: false, message: '权限不足，仅管理员可操作' });
    }
    next();
}

// 获取所有图书
router.get('/', async (req, res) => {
    try {
        const books = await select('books', '*', {}, { 
            orderBy: { column: 'created_at', ascending: false } 
        });
        
        res.json({
            success: true,
            data: books
        });
    } catch (error) {
        res.status(500).json({
            success: false,
            message: '获取图书列表失败',
            error: error.message
        });
    }
});

// 搜索图书（必须在 /:id 之前定义）
router.get('/search', async (req, res) => {
    try {
        const { keyword } = req.query;
        
        if (!keyword) {
            return res.status(400).json({
                success: false,
                message: '请输入搜索关键词'
            });
        }
        
        // Supabase 使用 ilike 进行不区分大小写的模糊查询
        const { supabase } = require('../config/db');
        
        // 构建搜索条件：在 title、author、isbn、category 中搜索
        const { data: books, error } = await supabase
            .from('books')
            .select('*')
            .or(`title.ilike.%${keyword}%,author.ilike.%${keyword}%,isbn.ilike.%${keyword}%,category.ilike.%${keyword}%`)
            .order('created_at', { ascending: false });
        
        if (error) throw error;
        
        console.log(`搜索关键词: ${keyword}, 结果数量: ${books ? books.length : 0}`);
        
        res.json({
            success: true,
            data: books || []
        });
    } catch (error) {
        console.error('搜索错误:', error);
        res.status(500).json({
            success: false,
            message: '搜索失败',
            error: error.message
        });
    }
});

// 根据ID获取单本图书
router.get('/:id', async (req, res) => {
    try {
        const { id } = req.params;
        const bookId = parseInt(id);
        
        // 验证 ID 是否为有效数字
        if (isNaN(bookId)) {
            return res.status(400).json({
                success: false,
                message: '无效的图书ID'
            });
        }
        
        const books = await select('books', '*', { id: bookId });
        
        if (books.length === 0) {
            return res.status(404).json({
                success: false,
                message: '图书不存在'
            });
        }
        
        res.json({
            success: true,
            data: books[0]
        });
    } catch (error) {
        console.error('获取图书详情错误:', error);
        res.status(500).json({
            success: false,
            message: '获取图书失败',
            error: error.message
        });
    }
});

// 添加图书（仅管理员）
router.post('/', requireAdmin, async (req, res) => {
    try {
        const { title, author, isbn, publisher, publish_date, category, total_copies } = req.body;
        
        // 验证必填字段
        if (!title || !author) {
            return res.status(400).json({
                success: false,
                message: '书名和作者不能为空'
            });
        }
        
        const available_copies = total_copies || 1;
        
        await insert('books', {
            title,
            author,
            isbn: isbn || null,
            publisher: publisher || null,
            publish_date: publish_date || null,
            category: category || null,
            total_copies: total_copies || 1,
            available_copies
        });
        
        res.json({
            success: true,
            message: '图书添加成功'
        });
    } catch (error) {
        res.status(500).json({
            success: false,
            message: '添加图书失败',
            error: error.message
        });
    }
});

// 修改图书（仅管理员）
router.put('/:id', requireAdmin, async (req, res) => {
    try {
        const { id } = req.params;
        const { title, author, isbn, publisher, publish_date, category, total_copies } = req.body;
        
        await update('books', {
            title,
            author,
            isbn: isbn || null,
            publisher: publisher || null,
            publish_date: publish_date || null,
            category: category || null,
            total_copies: total_copies || 1
        }, { id: parseInt(id) });
        
        res.json({
            success: true,
            message: '图书更新成功'
        });
    } catch (error) {
        res.status(500).json({
            success: false,
            message: '更新图书失败',
            error: error.message
        });
    }
});

// 删除图书（仅管理员）
router.delete('/:id', requireAdmin, async (req, res) => {
    try {
        const { id } = req.params;
        
        // 检查是否有借阅记录
        const borrowRecords = await select('borrow_records', '*', { 
            book_id: parseInt(id), 
            status: 'borrowed' 
        });
        
        if (borrowRecords.length > 0) {
            return res.status(400).json({
                success: false,
                message: '该图书有未归还的借阅记录，无法删除'
            });
        }
        
        await remove('books', { id: parseInt(id) });
        
        res.json({
            success: true,
            message: '图书删除成功'
        });
    } catch (error) {
        res.status(500).json({
            success: false,
            message: '删除图书失败',
            error: error.message
        });
    }
});

module.exports = router;
