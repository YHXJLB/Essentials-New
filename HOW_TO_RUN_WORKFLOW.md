# 🚀 如何运行 GitHub Actions 工作流

## 📋 概述

本文档提供三种方法来触发 GitHub Actions 工作流，创建 EssentialsX 1.21.11 发布版本。

---

## ✅ 方法 1: GitHub 网页界面（推荐 - 最简单）

### 步骤：

1. **打开 GitHub Actions 页面**
   ```
   https://github.com/YHXJLB/Essentials-New/actions
   ```

2. **选择工作流**
   - 在左侧列表中找到 "Create Release" 工作流
   - 点击它

3. **触发工作流**
   - 在右上角找到 "Run workflow" 下拉按钮
   - 点击它展开表单

4. **填写表单**
   ```
   Tag: 1.21.11
   Release name: EssentialsX 1.21.11 for Paper 1.21.11
   Prerelease: □ 不勾选（正式版）
   ```

5. **运行**
   - 点击绿色的 "Run workflow" 按钮
   - 页面会刷新，显示新的工作流运行

6. **查看进度**
   - 点击新出现的工作流运行记录
   - 查看实时构建日志
   - 等待 5-10 分钟完成

7. **下载结果**
   - 完成后访问: https://github.com/YHXJLB/Essentials-New/releases
   - 找到 "1.21.11" 发布版本
   - 下载所有 JAR 文件

### 🎥 视觉指南

```
GitHub 页面顶部
┌─────────────────────────────────────────────────────────┐
│ Code  Issues  Pull requests  Actions  Projects  ...    │
└─────────────────────────────────────────────────────────┘
                                  ↑
                              点击这里

Actions 页面
┌──────────────┬────────────────────────────────────────┐
│ 工作流列表    │                                        │
│              │  Create Release  [Run workflow ▼]      │
│ □ All        │                                        │
│ ☑ Create     │  最近的运行记录会显示在这里...           │
│   Release    │                                        │
│              │                                        │
└──────────────┴────────────────────────────────────────┘
     ↑                                    ↑
  选择工作流                          点击运行
```

---

## ✅ 方法 2: 使用命令行脚本（快速）

### 使用提供的脚本

我已经创建了两个脚本来帮助您：

**Linux/macOS:**
```bash
./trigger-release.sh
```

**Windows:**
```batch
trigger-release.bat
```

### 脚本功能

脚本会提示您选择：
1. 使用 GitHub CLI 触发（需要先安装 `gh`）
2. 推送标签触发（自动）
3. 打开网页界面
4. 显示完整说明

---

## ✅ 方法 3: 使用 GitHub CLI（专业用户）

### 前提条件

安装 GitHub CLI:

**macOS:**
```bash
brew install gh
```

**Linux (Debian/Ubuntu):**
```bash
sudo apt install gh
```

**Windows:**
```powershell
winget install GitHub.cli
```

或下载: https://github.com/cli/cli/releases

### 登录 GitHub

```bash
gh auth login
```

按照提示完成登录。

### 触发工作流

```bash
gh workflow run create-release.yml \
  -f tag=1.21.11 \
  -f release_name="EssentialsX 1.21.11 for Paper 1.21.11" \
  -f prerelease=false
```

### 查看运行状态

```bash
# 列出最近的运行
gh run list --workflow=create-release.yml

# 实时查看运行日志
gh run watch

# 查看特定运行的详情
gh run view <run-id>
```

---

## ✅ 方法 4: 推送标签（自动触发）

### 创建并推送标签

```bash
# 创建标签
git tag -a 1.21.11 -m "EssentialsX 1.21.11 for Paper 1.21.11"

# 推送标签到 GitHub（会自动触发工作流）
git push origin 1.21.11
```

### 如果标签已存在

```bash
# 删除本地标签
git tag -d 1.21.11

# 删除远程标签
git push origin :refs/tags/1.21.11

# 重新创建标签
git tag -a 1.21.11 -m "EssentialsX 1.21.11 for Paper 1.21.11"
git push origin 1.21.11
```

---

## 📊 工作流执行流程

```
触发工作流
    ↓
设置构建环境 (Java 17 + Gradle)
    ↓
检出代码
    ↓
构建项目 (./gradlew clean build)
    ↓
收集 JAR 文件 (从 jars/ 目录)
    ↓
创建 Git 标签 (如果需要)
    ↓
创建 GitHub Release
    ↓
上传 JAR 文件到 Release
    ↓
完成！✅
```

**预计时间**: 5-10 分钟

---

## 🔍 验证工作流配置

在运行之前，可以验证工作流配置是否正确：

### 检查工作流语法

```bash
# 查看工作流文件
cat .github/workflows/create-release.yml

# 检查 YAML 语法
python3 -c "import yaml; yaml.safe_load(open('.github/workflows/create-release.yml'))"
```

### 验证工作流已推送

```bash
# 确认工作流文件在仓库中
git ls-files .github/workflows/

# 确认已推送到 GitHub
git log --oneline origin/copilot/fix-paper-server-full-bug -1
```

---

## 📦 预期输出

### 成功后您将获得：

在 GitHub Releases 页面看到新发布版本，包含以下文件：

1. ✅ **Essentials-2.22.0-dev+xx-xxxxxxx.jar** (核心)
2. ✅ **EssentialsAntiBuild-2.22.0-dev+xx-xxxxxxx.jar**
3. ✅ **EssentialsChat-2.22.0-dev+xx-xxxxxxx.jar**
4. ✅ **EssentialsDiscord-2.22.0-dev+xx-xxxxxxx.jar**
5. ✅ **EssentialsDiscordLink-2.22.0-dev+xx-xxxxxxx.jar**
6. ✅ **EssentialsGeoIP-2.22.0-dev+xx-xxxxxxx.jar**
7. ✅ **EssentialsProtect-2.22.0-dev+xx-xxxxxxx.jar**
8. ✅ **EssentialsSpawn-2.22.0-dev+xx-xxxxxxx.jar**
9. ✅ **EssentialsXMPP-2.22.0-dev+xx-xxxxxxx.jar**

### 发布说明包含：

- Paper 1.21.11 兼容性信息
- 修复的 bug 说明
- 安装指南
- 完整变更日志链接

---

## ❓ 常见问题

### Q: 工作流没有出现在 Actions 页面？

**A:** 确保您已经：
1. 将包含工作流的分支推送到 GitHub
2. 工作流文件在 `.github/workflows/` 目录下
3. 刷新 Actions 页面

检查：
```bash
git push origin copilot/fix-paper-server-full-bug
```

### Q: 没有 "Run workflow" 按钮？

**A:** 确保：
1. 工作流中有 `workflow_dispatch` 触发器
2. 您有仓库的写权限
3. 您在正确的分支上

### Q: 构建失败？

**A:** 查看 Actions 日志：
1. 点击失败的运行
2. 查看具体步骤的日志
3. 检查错误信息

常见问题：
- 网络连接问题（下载依赖失败）
- Gradle 构建错误
- 权限问题

### Q: 标签冲突？

**A:** 如果标签已存在：
```bash
# 删除现有标签
git tag -d 1.21.11
git push origin :refs/tags/1.21.11

# 或者在 GitHub Releases 页面删除对应的 Release
```

---

## 🎯 快速命令参考

### 最快的方法（如果已安装 gh CLI）：

```bash
gh workflow run create-release.yml \
  -f tag=1.21.11 \
  -f release_name="EssentialsX 1.21.11 for Paper 1.21.11"
```

### 检查状态：

```bash
gh run list --workflow=create-release.yml --limit 1
```

### 查看日志：

```bash
gh run watch
```

---

## 📚 相关文档

- **完整指南**: [GITHUB_ACTIONS_GUIDE.md](./GITHUB_ACTIONS_GUIDE.md)
- **快速入门**: [快速使用指南.md](./快速使用指南.md)
- **架构说明**: [WORKFLOW_ARCHITECTURE.md](./WORKFLOW_ARCHITECTURE.md)
- **Paper 修复**: [PAPER_1.21.11_FIX.md](./PAPER_1.21.11_FIX.md)

---

## 💡 提示

1. **首次运行**：建议使用 GitHub 网页界面，可以直观地看到每个步骤
2. **频繁使用**：安装 GitHub CLI 可以更快捷
3. **自动化**：使用标签推送可以集成到 CI/CD 流程

---

## ✅ 总结

**最简单**: 使用 GitHub 网页界面（方法 1）

**最快速**: 使用提供的脚本（方法 2）

**最专业**: 使用 GitHub CLI（方法 3）

**最自动**: 推送标签触发（方法 4）

选择适合您的方法，开始构建和发布吧！🚀
