@echo off
REM 运行 GitHub Actions 工作流的脚本 / Script to trigger GitHub Actions workflow
REM 使用方法 / Usage: trigger-release.bat

setlocal enabledelayedexpansion

echo ================================================================
echo   GitHub Actions 工作流触发器 / Workflow Trigger
echo ================================================================
echo.

REM 检查是否安装了 gh CLI
where gh >nul 2>nul
if %errorlevel% neq 0 (
    echo X GitHub CLI ^(gh^) 未安装 / not installed
    echo.
    echo 请安装 GitHub CLI:
    echo   下载: https://github.com/cli/cli/releases
    echo   或使用 winget: winget install GitHub.cli
    echo.
    echo 或使用下面的其他方法...
    echo.
)

echo 请选择触发方法 / Please choose a trigger method:
echo.
echo 1. 使用 GitHub CLI 触发 ^(推荐^)
echo 2. 推送标签触发 ^(自动^)
echo 3. 查看 GitHub Actions 页面 ^(手动触发^)
echo 4. 显示完整说明
echo.
set /p choice="选择 (1-4): "

if "%choice%"=="1" goto method1
if "%choice%"=="2" goto method2
if "%choice%"=="3" goto method3
if "%choice%"=="4" goto method4
goto invalid

:method1
echo.
echo ================================================================
echo 方法 1: 使用 GitHub CLI
echo ================================================================
echo.

where gh >nul 2>nul
if %errorlevel% neq 0 (
    echo X 请先安装 GitHub CLI
    exit /b 1
)

REM 检查是否已登录
gh auth status >nul 2>nul
if %errorlevel% neq 0 (
    echo 请先登录 GitHub:
    echo   gh auth login
    exit /b 1
)

set /p tag="输入发布标签 (例如: 1.21.11): "
set /p release_name="输入发布名称 (例如: EssentialsX 1.21.11 for Paper 1.21.11): "

echo.
echo 触发工作流...
gh workflow run create-release.yml -f tag=%tag% -f release_name="%release_name%" -f prerelease=false

echo.
echo √ 工作流已触发！
echo.
echo 查看运行状态:
echo   gh run list --workflow=create-release.yml
echo.
echo 或访问: https://github.com/YHXJLB/Essentials-New/actions
goto end

:method2
echo.
echo ================================================================
echo 方法 2: 推送标签
echo ================================================================
echo.

set /p tag="输入标签名称 (例如: 1.21.11): "

echo.
echo 执行命令:
echo   git tag -a %tag% -m "EssentialsX %tag% for Paper 1.21.11"
echo   git push origin %tag%
echo.
set /p confirm="是否执行? (y/n): "

if /i "%confirm%"=="y" (
    git tag -a %tag% -m "EssentialsX %tag% for Paper 1.21.11"
    git push origin %tag%
    echo.
    echo √ 标签已推送，工作流将自动触发！
    echo.
    echo 访问: https://github.com/YHXJLB/Essentials-New/actions
) else (
    echo 已取消
)
goto end

:method3
echo.
echo ================================================================
echo 方法 3: GitHub 网页界面
echo ================================================================
echo.
echo 步骤:
echo 1. 访问: https://github.com/YHXJLB/Essentials-New/actions
echo 2. 选择 'Create Release' 工作流
echo 3. 点击 'Run workflow' 按钮
echo 4. 填写表单:
echo    - Tag: 1.21.11
echo    - Release name: EssentialsX 1.21.11 for Paper 1.21.11
echo    - Prerelease: 不勾选
echo 5. 点击绿色的 'Run workflow' 按钮
echo.
echo 正在打开浏览器...
start https://github.com/YHXJLB/Essentials-New/actions
goto end

:method4
echo.
echo ================================================================
echo 完整说明
echo ================================================================
echo.
echo 有三种方法可以触发 GitHub Actions 工作流:
echo.
echo 方法 1: GitHub CLI ^(最简单^)
echo ---------------------------
echo 前提: 安装并配置 GitHub CLI ^(gh^)
echo.
echo 安装:
echo   下载: https://github.com/cli/cli/releases
echo   或 winget: winget install GitHub.cli
echo.
echo 配置:
echo   gh auth login
echo.
echo 触发工作流:
echo   gh workflow run create-release.yml \
echo     -f tag=1.21.11 \
echo     -f release_name="EssentialsX 1.21.11 for Paper 1.21.11" \
echo     -f prerelease=false
echo.
echo 查看状态:
echo   gh run list --workflow=create-release.yml
echo   gh run watch
echo.
echo 方法 2: 推送标签 ^(自动触发^)
echo ---------------------------
echo 创建并推送标签会自动触发 release-1.21.11.yml 工作流:
echo.
echo   git tag -a 1.21.11 -m "EssentialsX 1.21.11 for Paper 1.21.11"
echo   git push origin 1.21.11
echo.
echo 注意: 如果标签已存在，需要先删除:
echo   git tag -d 1.21.11
echo   git push origin :refs/tags/1.21.11
echo.
echo 方法 3: GitHub 网页界面 ^(最直观^)
echo ---------------------------------
echo 访问并手动触发工作流
echo.
echo 更多信息
echo --------
echo 详细文档: 快速使用指南.md
echo 完整指南: GITHUB_ACTIONS_GUIDE.md
echo 架构说明: WORKFLOW_ARCHITECTURE.md
echo.
goto end

:invalid
echo 无效选择
exit /b 1

:end
echo.
echo ================================================================
echo 完成！/ Done!
echo ================================================================
pause
