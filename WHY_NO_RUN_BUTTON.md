# ❓ 为什么找不到 "Run workflow" 按钮？

## 问题原因 / Root Cause

您在 GitHub Actions 页面找不到"Run workflow"按钮，这是因为：

**工作流文件当前在特性分支上** (`copilot/fix-paper-server-full-bug`)

GitHub Actions 的"Run workflow"按钮有以下显示规则：
1. ✅ 只在**包含工作流文件的分支**上显示
2. ✅ 默认在**默认分支**（main/master）上查找
3. ❌ 在其他分支上需要**手动切换分支**

---

## 解决方案 / Solutions

### 方法 1: 在 GitHub Actions 页面切换分支（立即可用）

1. 访问: https://github.com/YHXJLB/Essentials-New/actions

2. 选择工作流（例如 "Create Release"）

3. **重要**: 在页面顶部找到分支选择器
   ```
   This workflow has a workflow_dispatch event trigger.
   
   [Branch: main ▼]    ← 点击这里
   ```

4. 在下拉菜单中选择: **`copilot/fix-paper-server-full-bug`**

5. 现在"Run workflow"按钮应该出现了！

6. 点击"Run workflow"，填写参数并运行

### 方法 2: 合并到主分支（推荐）

将 PR 合并到主分支后，工作流会自动在主分支上可用：

```bash
# 这需要通过 GitHub PR 界面完成
# 或者如果您有权限，可以直接合并
```

合并后，访问 Actions 页面就能看到"Run workflow"按钮。

### 方法 3: 使用 GitHub CLI（任何分支都可以）

即使在特性分支上，也可以使用 GitHub CLI 触发：

```bash
# 确保在正确的分支
git checkout copilot/fix-paper-server-full-bug

# 触发工作流
gh workflow run create-release.yml \
  -f tag=1.21.11 \
  -f release_name="EssentialsX 1.21.11 for Paper 1.21.11" \
  -f prerelease=false

# 查看运行状态
gh run list --workflow=create-release.yml
```

### 方法 4: 推送标签（自动触发 release-1.21.11.yml）

```bash
# 创建并推送标签会自动触发工作流
git tag -a 1.21.11 -m "EssentialsX 1.21.11 for Paper 1.21.11"
git push origin 1.21.11
```

---

## 验证工作流配置 / Verify Configuration

两个工作流文件都已正确配置了 `workflow_dispatch`：

### ✅ create-release.yml
```yaml
on:
  workflow_dispatch:
    inputs:
      tag:
        description: 'Release tag (e.g., 1.21.11, 2.22.0)'
        required: true
      release_name:
        description: 'Release name (e.g., EssentialsX 1.21.11)'
        required: true
      prerelease:
        description: 'Mark as pre-release'
        required: false
        type: boolean
        default: false
```

### ✅ release-1.21.11.yml
```yaml
on:
  push:
    tags:
      - '1.21.11'
  workflow_dispatch:
    inputs:
      tag_name:
        description: 'Tag name for release'
        required: true
        default: '1.21.11'
```

两个工作流都有 `workflow_dispatch` 配置，所以不是配置问题。

---

## 📸 如何在 GitHub UI 中找到按钮

### 步骤截图说明：

1. **进入 Actions 页面**
   ```
   https://github.com/YHXJLB/Essentials-New/actions
   ```

2. **查看顶部提示**
   ```
   你会看到类似的提示:
   "This workflow has a workflow_dispatch event trigger."
   ```

3. **切换分支**
   ```
   在工作流列表上方有一个分支选择器:
   
   ┌─────────────────────────────────────────┐
   │ This workflow has a workflow_dispatch   │
   │ event trigger.                          │
   │                                         │
   │ [Branch: main ▼]   [Run workflow]      │
   └─────────────────────────────────────────┘
           ↑
      点击这里选择分支
   ```

4. **选择正确的分支**
   ```
   在下拉菜单中找到并选择:
   copilot/fix-paper-server-full-bug
   ```

5. **现在应该能看到"Run workflow"按钮了！**

---

## 🎯 推荐操作 / Recommended Action

**最简单的解决方案**:

1. 在 GitHub Actions 页面**切换到** `copilot/fix-paper-server-full-bug` **分支**
2. 立即就能看到"Run workflow"按钮

**长期解决方案**:

将 PR 合并到主分支，这样工作流就会在默认分支上可用。

---

## ❓ 常见问题 / FAQ

### Q: 为什么我看不到分支选择器？
**A**: 确保您：
1. 已经选择了一个具体的工作流（如"Create Release"）
2. 该工作流有 `workflow_dispatch` 触发器
3. 您有仓库的访问权限

### Q: 我切换了分支还是看不到按钮？
**A**: 尝试：
1. 刷新页面（Ctrl+F5 强制刷新）
2. 确认工作流文件已推送到该分支
3. 检查工作流文件的 YAML 语法是否正确

### Q: 可以在 PR 中运行工作流吗？
**A**: 不能直接在 PR 中运行 `workflow_dispatch`，但可以：
1. 切换到 PR 的源分支运行
2. 使用 GitHub CLI 指定分支运行
3. 合并后在主分支运行

---

## 📚 相关文档

- GitHub Actions 文档: https://docs.github.com/en/actions/using-workflows/manually-running-a-workflow
- 工作流触发器: https://docs.github.com/en/actions/using-workflows/events-that-trigger-workflows#workflow_dispatch

---

## ✅ 总结

**问题**: 找不到"Run workflow"按钮
**原因**: 工作流在特性分支上，GitHub 默认显示主分支
**解决**: 在 Actions 页面切换到 `copilot/fix-paper-server-full-bug` 分支

**立即尝试**:
1. 访问 https://github.com/YHXJLB/Essentials-New/actions
2. 选择 "Create Release" 或 "Build and Release 1.21.11"
3. 在顶部切换分支到 `copilot/fix-paper-server-full-bug`
4. 点击"Run workflow"
5. 填写参数并运行！
