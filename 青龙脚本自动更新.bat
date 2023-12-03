@echo off
setlocal enabledelayedexpansion

:: 设置源仓库信息
set source_repo=https://github.com/leafTheFish/DeathNote.git
set source_branch=main
set source_path=58tc.js

:: 设置目标仓库信息
set target_repo=https://github.com/Cocoa520-love/Qinglong.git
set target_branch=main
set target_path=/

:: 设置 GitHub 用户名和访问令牌
set github_user=Cocoa520-love
set github_token=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

:: 创建临时目录
set temp_dir=%TEMP%\upload_files_temp
md "%temp_dir%" 2>nul

:: 克隆源仓库
git clone --depth=1 --branch %source_branch% %source_repo% "%temp_dir%\source_repo"

:: 进入临时目录
cd "%temp_dir%\source_repo"

:: 复制源文件到目标文件夹
xcopy /E /I "%source_path%" "%temp_dir%\target_repo\%target_path%"

:: 进入目标仓库目录
cd "%temp_dir%\target_repo"

:: 配置 Git 用户信息
git config user.name "%github_user%"
git config user.email "%github_user%@users.noreply.github.com"

:: 添加、提交和推送更改
git add .
git commit -m "Batch upload files"
git push --force %target_repo% %target_branch%

:: 清理临时目录
cd %TEMP%
rmdir /S /Q "%temp_dir%"

echo "文件上传完成!"
pause
