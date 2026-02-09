#!/bin/bash
# 运行 GitHub Actions 工作流的脚本 / Script to trigger GitHub Actions workflow
# 使用方法 / Usage: ./trigger-release.sh

set -e

echo "════════════════════════════════════════════════════════════════"
echo "  GitHub Actions 工作流触发器 / Workflow Trigger"
echo "════════════════════════════════════════════════════════════════"
echo ""

# 检查是否安装了 gh CLI
if ! command -v gh &> /dev/null; then
    echo "❌ GitHub CLI (gh) 未安装 / not installed"
    echo ""
    echo "请安装 GitHub CLI:"
    echo "  macOS: brew install gh"
    echo "  Linux: https://github.com/cli/cli/blob/trunk/docs/install_linux.md"
    echo "  Windows: https://github.com/cli/cli/releases"
    echo ""
    echo "或使用下面的其他方法..."
    echo ""
fi

echo "请选择触发方法 / Please choose a trigger method:"
echo ""
echo "1. 使用 GitHub CLI 触发 (推荐)"
echo "2. 推送标签触发 (自动)"
echo "3. 查看 GitHub Actions 页面 (手动触发)"
echo "4. 显示完整说明"
echo ""
read -p "选择 (1-4): " choice

case $choice in
    1)
        echo ""
        echo "════════════════════════════════════════════════════════════════"
        echo "方法 1: 使用 GitHub CLI"
        echo "════════════════════════════════════════════════════════════════"
        echo ""
        
        if ! command -v gh &> /dev/null; then
            echo "❌ 请先安装 GitHub CLI"
            exit 1
        fi
        
        # 检查是否已登录
        if ! gh auth status &> /dev/null; then
            echo "请先登录 GitHub:"
            echo "  gh auth login"
            exit 1
        fi
        
        echo "输入发布标签 (例如: 1.21.11):"
        read -p "Tag: " tag
        
        echo "输入发布名称 (例如: EssentialsX 1.21.11 for Paper 1.21.11):"
        read -p "Release name: " release_name
        
        echo ""
        echo "触发工作流..."
        gh workflow run create-release.yml \
            -f tag="$tag" \
            -f release_name="$release_name" \
            -f prerelease=false
        
        echo ""
        echo "✅ 工作流已触发！"
        echo ""
        echo "查看运行状态:"
        echo "  gh run list --workflow=create-release.yml"
        echo ""
        echo "或访问: https://github.com/YHXJLB/Essentials-New/actions"
        ;;
        
    2)
        echo ""
        echo "════════════════════════════════════════════════════════════════"
        echo "方法 2: 推送标签"
        echo "════════════════════════════════════════════════════════════════"
        echo ""
        
        echo "输入标签名称 (例如: 1.21.11):"
        read -p "Tag: " tag
        
        echo ""
        echo "执行命令:"
        echo "  git tag -a $tag -m 'EssentialsX $tag for Paper 1.21.11'"
        echo "  git push origin $tag"
        echo ""
        read -p "是否执行? (y/n): " confirm
        
        if [ "$confirm" = "y" ] || [ "$confirm" = "Y" ]; then
            git tag -a "$tag" -m "EssentialsX $tag for Paper 1.21.11"
            git push origin "$tag"
            echo ""
            echo "✅ 标签已推送，工作流将自动触发！"
            echo ""
            echo "访问: https://github.com/YHXJLB/Essentials-New/actions"
        else
            echo "已取消"
        fi
        ;;
        
    3)
        echo ""
        echo "════════════════════════════════════════════════════════════════"
        echo "方法 3: GitHub 网页界面"
        echo "════════════════════════════════════════════════════════════════"
        echo ""
        echo "步骤:"
        echo "1. 访问: https://github.com/YHXJLB/Essentials-New/actions"
        echo "2. 选择 'Create Release' 工作流"
        echo "3. 点击 'Run workflow' 按钮"
        echo "4. 填写表单:"
        echo "   - Tag: 1.21.11"
        echo "   - Release name: EssentialsX 1.21.11 for Paper 1.21.11"
        echo "   - Prerelease: 不勾选"
        echo "5. 点击绿色的 'Run workflow' 按钮"
        echo ""
        echo "正在打开浏览器..."
        
        # 尝试打开浏览器
        if command -v xdg-open &> /dev/null; then
            xdg-open "https://github.com/YHXJLB/Essentials-New/actions" 2>/dev/null || true
        elif command -v open &> /dev/null; then
            open "https://github.com/YHXJLB/Essentials-New/actions" 2>/dev/null || true
        fi
        ;;
        
    4)
        echo ""
        echo "════════════════════════════════════════════════════════════════"
        echo "完整说明"
        echo "════════════════════════════════════════════════════════════════"
        echo ""
        cat << 'EOF'
有三种方法可以触发 GitHub Actions 工作流:

方法 1: GitHub CLI (最简单)
---------------------------
前提: 安装并配置 GitHub CLI (gh)

安装:
  macOS:   brew install gh
  Linux:   sudo apt install gh  (或其他包管理器)
  Windows: https://github.com/cli/cli/releases

配置:
  gh auth login

触发工作流:
  gh workflow run create-release.yml \
    -f tag=1.21.11 \
    -f release_name="EssentialsX 1.21.11 for Paper 1.21.11" \
    -f prerelease=false

查看状态:
  gh run list --workflow=create-release.yml
  gh run watch

方法 2: 推送标签 (自动触发)
---------------------------
创建并推送标签会自动触发 release-1.21.11.yml 工作流:

  git tag -a 1.21.11 -m "EssentialsX 1.21.11 for Paper 1.21.11"
  git push origin 1.21.11

注意: 如果标签已存在，需要先删除:
  git tag -d 1.21.11
  git push origin :refs/tags/1.21.11

方法 3: GitHub 网页界面 (最直观)
---------------------------------
1. 访问 GitHub Actions 页面:
   https://github.com/YHXJLB/Essentials-New/actions

2. 在左侧选择 "Create Release" 工作流

3. 点击右侧的 "Run workflow" 下拉按钮

4. 填写表单:
   - Tag: 1.21.11
   - Release name: EssentialsX 1.21.11 for Paper 1.21.11
   - Prerelease: 不勾选 (正式版)

5. 点击绿色的 "Run workflow" 按钮

6. 等待 5-10 分钟完成构建

7. 查看 Releases 页面下载 JAR:
   https://github.com/YHXJLB/Essentials-New/releases

常见问题
--------
Q: 工作流没有触发?
A: 确保已经将更改推送到 GitHub

Q: 构建失败?
A: 查看 Actions 日志检查错误信息

Q: 标签已存在?
A: 先删除旧标签再创建新标签

Q: 没有权限?
A: 确保您有仓库的写权限

更多信息
--------
详细文档: 快速使用指南.md
完整指南: GITHUB_ACTIONS_GUIDE.md
架构说明: WORKFLOW_ARCHITECTURE.md

EOF
        ;;
        
    *)
        echo "无效选择"
        exit 1
        ;;
esac

echo ""
echo "════════════════════════════════════════════════════════════════"
echo "完成！/ Done!"
echo "════════════════════════════════════════════════════════════════"
