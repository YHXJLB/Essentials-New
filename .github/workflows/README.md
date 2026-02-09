# GitHub Actions Workflows

This directory contains automated workflows for building and releasing EssentialsX.

## Available Workflows

### 1. `release-1.21.11.yml` - Build and Release 1.21.11

**Purpose**: Automatically build and release version 1.21.11 with Paper 1.21.11 compatibility fixes.

**Triggers**:
- Push tag `1.21.11`
- Manual dispatch via GitHub Actions UI

**Actions**:
1. Checkout code
2. Setup Java 17 and Gradle
3. Build all modules with `./gradlew clean build`
4. Create GitHub Release with tag `1.21.11`
5. Upload all JAR files to the release

### 2. `create-release.yml` - Generic Release Workflow

**Purpose**: Create releases for any version.

**Triggers**:
- Manual dispatch only (via GitHub Actions UI)

**Parameters**:
- `tag`: Release tag (e.g., 1.21.11, 2.22.0)
- `release_name`: Display name for the release
- `prerelease`: Whether this is a pre-release (default: false)

**Actions**:
1. Checkout code
2. Setup build environment
3. Build with Gradle
4. Create and push Git tag
5. Create GitHub Release
6. Upload JAR files

### 3. `build-master.yml` - Main Branch Builds

**Purpose**: Build on pushes to main branches and releases.

**Triggers**:
- Push to `2.x` or `dev/*` branches
- Release published

**Actions**:
- Build and test
- Upload artifacts
- Deploy to Maven (if configured)
- Publish Javadocs

### 4. `build-pr.yml` - Pull Request Builds

**Purpose**: Build and test pull requests.

**Triggers**:
- Pull requests to `2.x`, `mc/*`, `dev/*` branches
- Push to `mc/*` or `pr/*` branches

**Actions**:
- Build and test
- Publish test results
- Upload artifacts

## Usage Examples

### Create 1.21.11 Release

**Option A - Push Tag:**
```bash
git tag 1.21.11
git push origin 1.21.11
```

**Option B - GitHub UI:**
1. Go to Actions tab
2. Select "Create Release"
3. Click "Run workflow"
4. Enter: tag=`1.21.11`, release_name=`EssentialsX 1.21.11 for Paper 1.21.11`
5. Click "Run workflow"

### Create Custom Release

1. Go to Actions → Create Release
2. Enter your parameters:
   - Tag: e.g., `2.23.0`
   - Release name: e.g., `EssentialsX 2.23.0`
   - Prerelease: Check if needed
3. Run workflow

## Build Outputs

All workflows produce:
- **JAR files**: Complete plugin modules ready for deployment
- **Artifacts**: Downloadable from the Actions run
- **Releases**: Published to GitHub Releases (for release workflows)

## Requirements

- Java 17
- Gradle (wrapper included)
- GitHub Actions environment

## Permissions

Workflows require:
- `contents: write` - For creating tags and releases
- `checks: write` - For publishing test results (PR builds)

## Troubleshooting

### Build Fails

Check the Actions log for:
- Dependency download issues
- Gradle configuration errors
- Test failures

### No JAR Files

Verify:
- `jars/` directory is created by Gradle
- Build completes successfully
- "Prepare release artifacts" step succeeds

### Tag Already Exists

Delete existing tag:
```bash
git tag -d <tag>
git push origin :refs/tags/<tag>
```

## More Information

See [GITHUB_ACTIONS_GUIDE.md](../../GITHUB_ACTIONS_GUIDE.md) for detailed documentation.
