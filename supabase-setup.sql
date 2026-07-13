-- Supabase 数据库初始化脚本
-- 请在 Supabase SQL Editor 中执行此脚本

-- ============================================
-- 1. 创建用户表
-- ============================================
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(20),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- ============================================
-- 2. 创建图书表
-- ============================================
CREATE TABLE IF NOT EXISTS books (
    id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    author VARCHAR(100) NOT NULL,
    isbn VARCHAR(20) UNIQUE,
    publisher VARCHAR(100),
    publish_date DATE,
    category VARCHAR(50),
    total_copies INTEGER DEFAULT 1,
    available_copies INTEGER DEFAULT 1,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- ============================================
-- 3. 创建借阅记录表
-- ============================================
CREATE TABLE IF NOT EXISTS borrow_records (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
    book_id INTEGER REFERENCES books(id) ON DELETE CASCADE,
    borrow_date TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    return_date TIMESTAMP WITH TIME ZONE,
    status VARCHAR(20) DEFAULT 'borrowed' CHECK (status IN ('borrowed', 'returned', 'overdue'))
);

-- ============================================
-- 4. 插入测试数据
-- ============================================

-- 插入测试用户（密码明文存储，生产环境应使用 bcrypt 加密）
INSERT INTO users (username, password, email, phone) VALUES 
('admin', 'admin123', 'admin@library.com', '13800138000'),
('testuser', 'test123', 'test@library.com', '13900139000')
ON CONFLICT (username) DO NOTHING;

-- 插入测试图书
INSERT INTO books (title, author, isbn, publisher, publish_date, category, total_copies, available_copies) VALUES 
('JavaScript高级程序设计', 'Nicholas C. Zakas', '978-7-115-27579-0', '人民邮电出版社', '2012-10-01', '编程', 3, 3),
('深入理解计算机系统', 'Randal E. Bryant', '978-7-111-54493-7', '机械工业出版社', '2016-11-01', '计算机基础', 2, 2),
('算法导论', 'Thomas H. Cormen', '978-7-111-40701-0', '机械工业出版社', '2013-01-01', '算法', 2, 2),
('设计模式：可复用面向对象软件的基础', 'Erich Gamma', '978-7-111-07575-2', '机械工业出版社', '2000-09-01', '软件工程', 1, 1),
('代码大全', 'Steve McConnell', '978-7-121-02476-4', '电子工业出版社', '2006-06-01', '编程实践', 2, 2)
ON CONFLICT (isbn) DO NOTHING;

-- ============================================
-- 5. 验证数据
-- ============================================
SELECT 'users' as table_name, COUNT(*) as count FROM users
UNION ALL
SELECT 'books' as table_name, COUNT(*) as count FROM books
UNION ALL
SELECT 'borrow_records' as table_name, COUNT(*) as count FROM borrow_records;

-- ============================================
-- 6. （可选）启用行级安全策略 RLS
-- ============================================
-- 如果希望所有用户都能访问数据（开发阶段），可以禁用 RLS
ALTER TABLE users DISABLE ROW LEVEL SECURITY;
ALTER TABLE books DISABLE ROW LEVEL SECURITY;
ALTER TABLE borrow_records DISABLE ROW LEVEL SECURITY;

-- 或者启用 RLS 并创建策略（生产环境推荐）
-- ALTER TABLE users ENABLE ROW LEVEL SECURITY;
-- CREATE POLICY "Allow all operations on users" ON users FOR ALL USING (true);
-- 
-- ALTER TABLE books ENABLE ROW LEVEL SECURITY;
-- CREATE POLICY "Allow all operations on books" ON books FOR ALL USING (true);
-- 
-- ALTER TABLE borrow_records ENABLE ROW LEVEL SECURITY;
-- CREATE POLICY "Allow all operations on borrow_records" ON borrow_records FOR ALL USING (true);
