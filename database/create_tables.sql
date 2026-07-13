-- 图书管理系统数据库脚本
-- 在 SSMS 中执行此脚本前，先创建一个数据库：CREATE DATABASE LibraryDB;
-- 然后 USE LibraryDB; 再执行下面的脚本

USE LibraryDB;
GO

-- 1. 用户表
CREATE TABLE users (
    id INT IDENTITY(1,1) PRIMARY KEY,
    username NVARCHAR(50) NOT NULL UNIQUE,
    password NVARCHAR(255) NOT NULL,
    email NVARCHAR(100),
    phone NVARCHAR(20),
    created_at DATETIME DEFAULT GETDATE()
);
GO

-- 2. 图书表
CREATE TABLE books (
    id INT IDENTITY(1,1) PRIMARY KEY,
    title NVARCHAR(200) NOT NULL,
    author NVARCHAR(100) NOT NULL,
    isbn NVARCHAR(20) UNIQUE,
    publisher NVARCHAR(100),
    publish_date DATE,
    category NVARCHAR(50),
    total_copies INT DEFAULT 1,
    available_copies INT DEFAULT 1,
    created_at DATETIME DEFAULT GETDATE()
);
GO

-- 3. 借阅记录表
CREATE TABLE borrow_records (
    id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    book_id INT NOT NULL,
    borrow_date DATETIME DEFAULT GETDATE(),
    return_date DATETIME NULL,
    status NVARCHAR(20) DEFAULT 'borrowed', -- borrowed, returned, overdue
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (book_id) REFERENCES books(id)
);
GO

-- 插入一些测试数据
INSERT INTO users (username, password, email, phone) VALUES
('admin', 'admin123', 'admin@library.com', '1234567890'),
('zhangsan', 'password123', 'zhangsan@example.com', '0987654321');
GO

INSERT INTO books (title, author, isbn, publisher, publish_date, category, total_copies, available_copies) VALUES
('红楼梦', '曹雪芹', '978-7-02-000220-4', '人民文学出版社', '1980-01-01', '古典文学', 5, 5),
('西游记', '吴承恩', '978-7-02-000221-1', '人民文学出版社', '1980-01-01', '古典文学', 3, 3),
('JavaScript高级程序设计', 'Nicholas C. Zakas', '978-7-115-27579-0', '人民邮电出版社', '2012-10-01', '计算机', 2, 2);
GO

PRINT '数据库表创建成功！';
GO
