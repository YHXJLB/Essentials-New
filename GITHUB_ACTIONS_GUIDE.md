# GitHub Actions 自动构建和发布指南 / GitHub Actions Build and Release Guide

## 概述 / Overview

本项目配置了 GitHub Actions 工作流来自动构建 JAR 文件并创建发布版本。

This project is configured with GitHub Actions workflows to automatically build JAR files and create releases.

---

## 工作流文件 / Workflow Files

### 1. `release-1.21.11.yml` - 1.21.11 专用发布工作流

**触发方式 / Triggers:**
- 推送标签 `1.21.11` 时自动触发
- 手动触发（workflow_dispatch）

**使用方法 / Usage:**

#### 方法 A: 推送标签触发 / Trigger by Pushing Tag
```bash
git tag 1.21.11
git push origin 1.21.11
```

#### 方法 B: 手动触发 / Manual Trigger
1. 访问 GitHub 仓库
2. 进入 `Actions` 标签页
3. 选择 "Build and Release 1.21.11" 工作流
4. 点击 "Run workflow"
5. 确认并运行

### 2. `create-release.yml` - 通用发布工作流

这是一个可重用的工作流，适用于创建任何版本的发布。

This is a reusable workflow for creating any version release.

**使用方法 / Usage:**

1. 访问 GitHub 仓库的 `Actions` 页面
2. 选择 "Create Release" 工作流
3. 点击 "Run workflow"
4. 填写参数：
   - **Tag**: 例如 `1.21.11`, `2.22.0`
   - **Release name**: 例如 `EssentialsX 1.21.11`
   - **Prerelease**: 是否为预发布版本（默认否）
5. 点击 "Run workflow" 执行

---

## 快速开始 / Quick Start

### 创建 1.21.11 发布 / Create 1.21.11 Release

**最简单的方法 - 使用 GitHub 网页界面:**

1. 进入 GitHub 仓库: https://github.com/YHXJLB/Essentials-New
2. 点击 `Actions` 标签
3. 点击左侧的 "Create Release" 工作流
4. 点击右侧的 "Run workflow" 按钮
5. 填写表单：
   ```
   Tag: 1.21.11
   Release name: EssentialsX 1.21.11 for Paper 1.21.11
   Prerelease: 不勾选
   ```
6. 点击绿色的 "Run workflow" 按钮
7. 等待构建完成（约 5-10 分钟）
8. 完成后，在 `Releases` 页面查看新发布的版本

**使用命令行:**

```bash
# 确保在正确的分支上
git checkout copilot/fix-paper-server-full-bug

# 创建并推送标签
git tag -a 1.21.11 -m "EssentialsX 1.21.11 for Paper 1.21.11"
git push origin 1.21.11

# 工作流将自动触发并创建发布
```

---

## 工作流详细说明 / Workflow Details

### 构建步骤 / Build Steps

1. **检出代码** / Checkout code
   - 获取完整的 Git 历史记录

2. **设置 Java 17** / Setup Java 17
   - 使用 Temurin 发行版

3. **配置 Gradle** / Setup Gradle
   - 配置 Gradle 缓存以加快构建速度

4. **构建项目** / Build project
   ```bash
   ./gradlew clean build --stacktrace
   ```

5. **准备发布文件** / Prepare release artifacts
   - 收集所有构建的 JAR 文件
   - 验证文件完整性

6. **创建 GitHub Release** / Create GitHub Release
   - 创建标签和发布说明
   - 上传所有 JAR 文件

### 发布包含的模块 / Released Modules

构建将生成以下 JAR 文件：

The build will generate the following JAR files:

- `Essentials-<version>.jar` - 核心模块 / Core module
- `EssentialsAntiBuild-<version>.jar` - 反建筑模块
- `EssentialsChat-<version>.jar` - 聊天模块
- `EssentialsDiscord-<version>.jar` - Discord 集成
- `EssentialsDiscordLink-<version>.jar` - Discord 链接
- `EssentialsGeoIP-<version>.jar` - GeoIP 模块
- `EssentialsProtect-<version>.jar` - 保护模块
- `EssentialsSpawn-<version>.jar` - 出生点模块
- `EssentialsXMPP-<version>.jar` - XMPP 模块

---

## 查看发布 / View Releases

发布完成后，可以在以下位置查看：

After the release is created, you can view it at:

- **Releases 页面**: https://github.com/YHXJLB/Essentials-New/releases
- **特定版本**: https://github.com/YHXJLB/Essentials-New/releases/tag/1.21.11

---

## 故障排除 / Troubleshooting

### 问题: 构建失败 / Build Failed

**解决方法:**
1. 检查 Actions 日志中的错误信息
2. 确认所有依赖项可以正常下载
3. 验证 Gradle 配置正确

### 问题: 没有 JAR 文件 / No JAR Files

**解决方法:**
1. 检查构建日志中的 "Prepare release artifacts" 步骤
2. 确认 `jars/` 目录是否生成
3. 检查 Gradle 构建配置

### 问题: 标签已存在 / Tag Already Exists

**解决方法:**
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

## 高级用法 / Advanced Usage

### 创建预发布版本 / Create Pre-release

使用 `create-release.yml` 工作流，并勾选 "Prerelease" 选项。

Use the `create-release.yml` workflow and check the "Prerelease" option.

### 自定义发布说明 / Custom Release Notes

编辑工作流文件中的 `body` 或 `release_notes.md` 部分。

Edit the `body` or `release_notes.md` section in the workflow file.

### 修改构建参数 / Modify Build Parameters

在工作流文件中修改 Gradle 构建命令：

Modify the Gradle build command in the workflow file:

```yaml
- name: Build with Gradle
  run: ./gradlew clean build --stacktrace --no-daemon
```

---

## 安全注意事项 / Security Notes

- `GITHUB_TOKEN` 由 GitHub Actions 自动提供
- 不需要额外配置 secrets（除非需要部署到外部服务）
- 工作流具有 `contents: write` 权限以创建标签和发布

---

## 相关文档 / Related Documentation

- [GitHub Actions 文档](https://docs.github.com/en/actions)
- [Gradle 构建文档](https://docs.gradle.org/)
- [Paper 1.21.11 修复说明](./PAPER_1.21.11_FIX.md)
- [完整修复总结](./FIX_SUMMARY_修复总结.md)

---

## 联系支持 / Contact Support

如有问题，请在 GitHub Issues 中提出：
https://github.com/YHXJLB/Essentials-New/issues

For questions, please create a GitHub Issue at:
https://github.com/YHXJLB/Essentials-New/issues
