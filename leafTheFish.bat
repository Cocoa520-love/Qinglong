@echo off
setlocal enabledelayedexpansion

REM 设置本地仓库路径
set "localRepoPath=C:\Users\Administrator\Desktop\Qinglong\Qinglong"

REM 设置其他 GitHub 仓库 URL
set "remoteRepoURL=https://github.com/leafTheFish/DeathNote.git"

REM 从文件读取要获取的文件列表
set "filesToCopyFile=filesToCopy.txt"
if not exist %filesToCopyFile% (
    echo Error: %filesToCopyFile% not found.
    exit /b 1
)

REM 切换到本地仓库目录
cd %localRepoPath%

REM 如果本地仓库不存在，则克隆远程仓库
if not exist %localRepoPath% (
    git clone %remoteRepoURL%
    cd %localRepoPath%
) else (
    REM 如果本地仓库已存在，则更新到最新版本
    git pull
)

REM 从文件读取文件列表并复制到本地仓库
for /f "delims=" %%i in (%filesToCopyFile%) do (
    copy /Y NUL %%i
    xcopy /Y /I "%localRepoPath%\%%i" "%localRepoPath%\.."
    git add %%i
)

REM 添加本地仓库中的所有文件到暂存区
git add .

REM 提交更改
git commit -m "Update files from %filesToCopyFile%"

REM 推送更改到远程仓库
git push

endlocal