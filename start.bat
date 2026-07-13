@echo off
echo ========================================
echo   图书管理系统 - 一键启动脚本
echo ========================================
echo.

REM 检查 Node.js 是否安装
where node >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo [错误] 未检测到 Node.js，请先安装 Node.js
    echo 下载地址：https://nodejs.org/
    pause
    exit /b 1
)

echo [1/3] 检查后端依赖...
cd backend
if not exist node_modules (
    echo 正在安装后端依赖...
    call npm install
    if %ERRORLEVEL% NEQ 0 (
        echo [错误] 后端依赖安装失败
        pause
        exit /b 1
    )
) else (
    echo 后端依赖已存在
)

echo.
echo [2/3] 启动后端服务器...
start "Backend Server" cmd /k "cd backend && node server.js"
timeout /t 3 /nobreak >nul

echo.
echo [3/3] 打开前端页面...
start "" "%~dp0frontend\index.html"

echo.
echo ========================================
echo   启动完成！
echo ========================================
echo.
echo 后端服务器：http://localhost:3000
echo 前端页面：已在默认浏览器中打开
echo.
echo 提示：
echo - 如果前端无法连接后端，请检查后端是否成功启动
echo - 关闭命令行窗口会停止后端服务器
echo - 首次使用需要注册账号
echo.
pause
