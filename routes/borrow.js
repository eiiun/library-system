const express = require('express');
const router = express.Router();
const { select, insert, update, supabase } = require('../config/db');

// 借书
router.post('/borrow', async (req, res) => {
    try {
        const { user_id, book_id } = req.body;
        
        // 验证必填字段
        if (!user_id || !book_id) {
            return res.status(400).json({
                success: false,
                message: '用户ID和图书ID不能为空'
            });
        }
        
        // 检查图书是否存在且可借
        const books = await select('books', '*', { id: parseInt(book_id) });
        
        if (books.length === 0) {
            return res.status(404).json({
                success: false,
                message: '图书不存在'
            });
        }
        
        if (books[0].available_copies <= 0) {
            return res.status(400).json({
                success: false,
                message: '该图书已全部借出'
            });
        }
        
        // 检查用户是否已经借了这本书且未归还
        const existingBorrow = await select('borrow_records', '*', { 
            user_id: parseInt(user_id), 
            book_id: parseInt(book_id), 
            status: 'borrowed' 
        });
        
        if (existingBorrow.length > 0) {
            return res.status(400).json({
                success: false,
                message: '您已经借阅了这本书，尚未归还'
            });
        }
        
        // 创建借阅记录
        await insert('borrow_records', {
            user_id: parseInt(user_id),
            book_id: parseInt(book_id),
            status: 'borrowed'
        });
        
        // 更新图书的可借数量
        await update('books', {
            available_copies: books[0].available_copies - 1
        }, { id: parseInt(book_id) });
        
        res.json({
            success: true,
            message: '借书成功'
        });
    } catch (error) {
        res.status(500).json({
            success: false,
            message: '借书失败',
            error: error.message
        });
    }
});

// 还书
router.post('/return', async (req, res) => {
    try {
        const { user_id, book_id } = req.body;
        
        // 验证必填字段
        if (!user_id || !book_id) {
            return res.status(400).json({
                success: false,
                message: '用户ID和图书ID不能为空'
            });
        }
        
        // 查找借阅记录
        const borrowRecords = await select('borrow_records', '*', { 
            user_id: parseInt(user_id), 
            book_id: parseInt(book_id), 
            status: 'borrowed' 
        });
        
        if (borrowRecords.length === 0) {
            return res.status(404).json({
                success: false,
                message: '未找到借阅记录'
            });
        }
        
        const recordId = borrowRecords[0].id;
        
        // 更新借阅记录（设置归还日期和状态）
        await update('borrow_records', {
            return_date: new Date().toISOString(),
            status: 'returned'
        }, { id: recordId });
        
        // 获取当前图书信息以更新可借数量
        const books = await select('books', 'available_copies', { id: parseInt(book_id) });
        
        // 更新图书的可借数量
        await update('books', {
            available_copies: books[0].available_copies + 1
        }, { id: parseInt(book_id) });
        
        res.json({
            success: true,
            message: '还书成功'
        });
    } catch (error) {
        res.status(500).json({
            success: false,
            message: '还书失败',
            error: error.message
        });
    }
});

// 获取用户的借阅记录
router.get('/records/:user_id', async (req, res) => {
    try {
        const { user_id } = req.params;
        
        // Supabase 不支持 JOIN，需要分别查询然后组合数据
        const records = await select('borrow_records', '*', { user_id: parseInt(user_id) }, {
            orderBy: { column: 'borrow_date', ascending: false }
        });
        
        // 为每条记录获取对应的图书信息
        const recordsWithBooks = await Promise.all(records.map(async (record) => {
            const books = await select('books', 'title, author, isbn', { id: record.book_id });
            return {
                ...record,
                title: books[0]?.title || '',
                author: books[0]?.author || '',
                isbn: books[0]?.isbn || ''
            };
        }));
        
        res.json({
            success: true,
            data: recordsWithBooks
        });
    } catch (error) {
        res.status(500).json({
            success: false,
            message: '获取借阅记录失败',
            error: error.message
        });
    }
});

// 获取所有借阅记录（管理员功能）
router.get('/records', async (req, res) => {
    try {
        const records = await select('borrow_records', '*', {}, {
            orderBy: { column: 'borrow_date', ascending: false }
        });
        
        // 为每条记录获取对应的用户和图书信息
        const recordsWithDetails = await Promise.all(records.map(async (record) => {
            const [users, books] = await Promise.all([
                select('users', 'username', { id: record.user_id }),
                select('books', 'title, author', { id: record.book_id })
            ]);
            
            return {
                ...record,
                username: users[0]?.username || '',
                title: books[0]?.title || '',
                author: books[0]?.author || ''
            };
        }));
        
        res.json({
            success: true,
            data: recordsWithDetails
        });
    } catch (error) {
        res.status(500).json({
            success: false,
            message: '获取借阅记录失败',
            error: error.message
        });
    }
});

module.exports = router;
