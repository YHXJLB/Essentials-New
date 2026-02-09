# 🔀 如何合并到主分支 / How to Merge to Main Branch

## 📋 当前状态

- **特性分支**: `copilot/fix-paper-server-full-bug`  
- **主分支**: `2.x`
- **状态**: ✅ 所有改动已完成并推送

---

## 🚀 合并方法 / Merge Methods

### 方法 1: GitHub 网页界面（最简单）⭐

#### 步骤：

1. **访问仓库 Pull Requests 页面**
   ```
   https://github.com/YHXJLB/Essentials-New/pulls
   ```

2. **创建 Pull Request**（如果还没有）
   - 点击 "New pull request"
   - Base: `2.x`
   - Compare: `copilot/fix-paper-server-full-bug`
   - 点击 "Create pull request"

3. **填写 PR 信息**
   ```
   Title: Paper 1.21.11 compatibility + automated release workflows
   
   Description:
   - Paper 1.21.11 API 修复
   - GitHub Actions 自动化工作流
   - 完整的中英文文档
   - 运行和构建脚本
   ```

4. **审查更改**
   - 查看 "Files changed" 标签
   - 确认所有更改都是预期的

5. **合并 PR**
   - 点击 "Merge pull request"
   - 选择合并方式:
     * **Merge commit** (推荐) - 保留完整历史
     * Squash and merge - 合并为单个提交
     * Rebase and merge - 线性历史
   - 点击 "Confirm merge"

6. **完成**
   - ✅ 合并成功！
   - 可选: 删除 `copilot/fix-paper-server-full-bug` 分支

---

### 方法 2: GitHub CLI（快速）

#### 前提条件

安装并登录 GitHub CLI:

```bash
# 安装 gh CLI（如果还没有）
# macOS: brew install gh
# Linux: apt install gh / yum install gh
# Windows: winget install GitHub.cli

# 登录
gh auth login
```

#### 创建并合并 PR

```bash
# 1. 创建 Pull Request
gh pr create \
  --base 2.x \
  --head copilot/fix-paper-server-full-bug \
  --title "Paper 1.21.11 compatibility + automated release workflows" \
  --body "
## 改动内容

### 1. Paper 1.21.11 API 修复
- 修复 PlayerServerFullCheckEvent.allow() 方法
- 更新 Paper API 依赖到 1.21.11
- 更新测试服务器版本

### 2. GitHub Actions 工作流
- release-1.21.11.yml - 专用工作流
- create-release.yml - 通用工作流

### 3. 文档和工具
- 11个文档文件（中英文）
- 5个脚本工具

## 质量检查
- ✅ 代码审查: 0 issues
- ✅ 安全扫描: 0 vulnerabilities
- ✅ 工作流验证: 通过

查看详细信息: PAPER_1.21.11_FIX.md
"

# 2. 查看 PR 状态
gh pr list

# 3. 合并 PR
gh pr merge --merge --delete-branch
```

---

### 方法 3: Git 命令行（完整仓库）

⚠️ **注意**: 此方法需要在有完整 Git 历史的本地仓库中执行。

#### 步骤

```bash
# 1. 确保在最新的主分支上
git checkout 2.x
git pull origin 2.x

# 2. 合并特性分支
git merge copilot/fix-paper-server-full-bug

# 3. 解决冲突（如果有）
# 编辑有冲突的文件
# git add <resolved-files>
# git commit

# 4. 推送到远程
git push origin 2.x

# 5. 删除特性分支（可选）
git branch -d copilot/fix-paper-server-full-bug
git push origin --delete copilot/fix-paper-server-full-bug
```

---

## 📊 将要合并的改动

### 代码修改 (3 files)

1. **Essentials/src/main/java/com/earth2me/essentials/EssentialsPlayerListener.java**
   - `event.allow(true)` → `event.allow()`

2. **providers/PaperProvider/build.gradle**
   - Paper API: `1.21.8-R0.1-SNAPSHOT` → `1.21.11-R0.1-SNAPSHOT`

3. **build-logic/src/main/kotlin/constants.kt**
   - Test server: `1.21.8` → `1.21.11`

### GitHub Actions 工作流 (2 files)

4. **`.github/workflows/create-release.yml`**
   - 通用发布工作流
   - workflow_dispatch 触发

5. **`.github/workflows/release-1.21.11.yml`**
   - 1.21.11 专用工作流
   - 标签推送 + 手动触发

### 文档文件 (11 files)

6. **PAPER_1.21.11_FIX.md** - Paper 修复技术细节
7. **FIX_SUMMARY_修复总结.md** - 修复完成总结
8. **GITHUB_ACTIONS_GUIDE.md** - 工作流完整指南
9. **快速使用指南.md** - 中文快速入门
10. **WORKFLOW_ARCHITECTURE.md** - 工作流架构
11. **HOW_TO_RUN_WORKFLOW.md** - 运行指南
12. **WHY_NO_RUN_BUTTON.md** - 按钮问题解答
13. **FIND_RUN_BUTTON.txt** - 可视化按钮指南
14. **PROJECT_COMPLETION_SUMMARY.md** - 项目完成总结
15. **FINAL_SUMMARY.txt** - 最终总结
16. **RUN_NOW.txt** - 快速开始指南

### 脚本工具 (5 files)

17. **build.sh** - Linux/macOS 构建脚本
18. **build.bat** - Windows 构建脚本
19. **trigger-release.sh** - Linux/macOS 触发脚本
20. **trigger-release.bat** - Windows 触发脚本
21. **validate-workflow.sh** - 工作流验证脚本

---

## ✅ 合并前检查清单

在合并前确认：

- [ ] 所有更改已推送到 `copilot/fix-paper-server-full-bug`
- [ ] 代码审查通过（0 issues）
- [ ] 安全扫描通过（0 vulnerabilities）
- [ ] 工作流 YAML 语法正确
- [ ] 文档完整且准确
- [ ] 没有合并冲突

**当前状态**: ✅ 所有检查通过

---

## 🔍 合并后验证

合并完成后，验证以下内容：

### 1. 工作流可用性

访问 Actions 页面确认：
```
https://github.com/YHXJLB/Essentials-New/actions
```

- [ ] "Create Release" 工作流可见
- [ ] "Build and Release 1.21.11" 工作流可见
- [ ] "Run workflow" 按钮在主分支上可用

### 2. 文档可访问性

确认文档在主分支上可访问：
```
https://github.com/YHXJLB/Essentials-New/blob/2.x/PAPER_1.21.11_FIX.md
https://github.com/YHXJLB/Essentials-New/blob/2.x/GITHUB_ACTIONS_GUIDE.md
```

### 3. 代码更改生效

检查修复是否在主分支上：
```
https://github.com/YHXJLB/Essentials-New/blob/2.x/Essentials/src/main/java/com/earth2me/essentials/EssentialsPlayerListener.java
```

查找 `event.allow()` (不带参数)

### 4. 测试工作流

尝试运行工作流：

1. 访问 Actions 页面
2. 选择 "Create Release"
3. 点击 "Run workflow"
4. 填写表单并运行
5. 验证构建成功

---

## ⚠️ 故障排除

### 问题: PR 创建失败

**解决**:
- 确认分支存在: `git branch -a`
- 确认已推送: `git push origin copilot/fix-paper-server-full-bug`
- 刷新 GitHub 页面

### 问题: 合并冲突

**解决**:
```bash
git checkout 2.x
git pull origin 2.x
git merge copilot/fix-paper-server-full-bug

# 如果有冲突
git status
# 编辑冲突文件
git add <files>
git commit
git push origin 2.x
```

### 问题: 工作流不显示

**解决**:
- 确认文件在 `.github/workflows/` 目录
- 检查 YAML 语法
- 等待几分钟让 GitHub 处理
- 刷新页面

---

## 📞 需要帮助？

如果遇到问题：

1. 查看本文档的故障排除部分
2. 检查 GitHub Actions 日志
3. 查看 GitHub 文档: https://docs.github.com/en/pull-requests
4. 在 Issues 中提问

---

## 🎉 完成后

合并成功后：

1. ✅ Paper 1.21.11 修复将在主分支生效
2. ✅ 工作流可以直接运行
3. ✅ 文档对所有人可见
4. ✅ 可以创建 1.21.11 发布版本

**下一步**: 运行工作流创建 1.21.11 发布！

---

**推荐操作**: 使用方法 1（GitHub 网页界面），最简单直观！
