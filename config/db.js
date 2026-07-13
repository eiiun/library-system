const { createClient } = require('@supabase/supabase-js');
require('dotenv').config();

// 创建 Supabase 客户端（后端使用 secret key）
const supabaseUrl = process.env.SUPABASE_URL || 'https://xuxqwywszhbsejrrhmyr.supabase.co';
const supabaseKey = process.env.SUPABASE_SECRET_KEY || process.env.SUPABASE_ANON_KEY;

if (!supabaseKey) {
    console.error('错误: 缺少 SUPABASE_SECRET_KEY 或 SUPABASE_ANON_KEY 环境变量');
    process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseKey);

// 初始化数据库（创建表和测试数据）
async function initDatabase() {
    try {
        console.log('正在连接 Supabase 数据库...');
        
        // 测试连接
        const { data, error } = await supabase.from('users').select('count').limit(1);
        
        if (error) {
            console.error('Supabase 连接失败:', error.message);
            console.log('\n请确保已在 Supabase SQL Editor 中执行建表 SQL 语句！');
            throw error;
        }
        
        console.log('✅ Supabase 数据库连接成功');
        return supabase;
    } catch (error) {
        console.error('数据库初始化失败:', error);
        throw error;
    }
}

// 通用查询函数 - 支持 SELECT
async function select(table, columns = '*', conditions = {}, options = {}) {
    try {
        let query = supabase.from(table).select(columns);
        
        // 添加 WHERE 条件
        if (conditions && Object.keys(conditions).length > 0) {
            for (const [key, value] of Object.entries(conditions)) {
                if (value !== undefined && value !== null) {
                    query = query.eq(key, value);
                }
            }
        }
        
        // 添加排序
        if (options.orderBy) {
            query = query.order(options.orderBy.column, { ascending: options.orderBy.ascending !== false });
        }
        
        // 添加限制
        if (options.limit) {
            query = query.limit(options.limit);
        }
        
        const { data, error } = await query;
        
        if (error) throw error;
        return data || [];
    } catch (error) {
        console.error(`SELECT 查询失败 (${table}):`, error);
        throw error;
    }
}

// 插入数据
async function insert(table, data) {
    try {
        const { data: result, error } = await supabase.from(table).insert(data).select();
        
        if (error) throw error;
        return result;
    } catch (error) {
        console.error(`INSERT 失败 (${table}):`, error);
        throw error;
    }
}

// 更新数据
async function update(table, data, conditions) {
    try {
        let query = supabase.from(table).update(data);
        
        // 添加 WHERE 条件
        for (const [key, value] of Object.entries(conditions)) {
            if (value !== undefined && value !== null) {
                query = query.eq(key, value);
            }
        }
        
        const { data: result, error } = await query.select();
        
        if (error) throw error;
        return result;
    } catch (error) {
        console.error(`UPDATE 失败 (${table}):`, error);
        throw error;
    }
}

// 删除数据
async function remove(table, conditions) {
    try {
        let query = supabase.from(table).delete();
        
        // 添加 WHERE 条件
        for (const [key, value] of Object.entries(conditions)) {
            if (value !== undefined && value !== null) {
                query = query.eq(key, value);
            }
        }
        
        const { data, error } = await query.select();
        
        if (error) throw error;
        return data;
    } catch (error) {
        console.error(`DELETE 失败 (${table}):`, error);
        throw error;
    }
}

// 执行原始 SQL（用于复杂查询）
async function executeSql(sql, params = {}) {
    try {
        const { data, error } = await supabase.rpc('execute_sql', { sql_query: sql, params: params });
        
        if (error) throw error;
        return data;
    } catch (error) {
        console.error('SQL 执行失败:', error);
        throw error;
    }
}

module.exports = {
    supabase,
    initDatabase,
    select,
    insert,
    update,
    remove,
    executeSql
};
