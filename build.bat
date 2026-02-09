@echo off
REM Build script for Essentials-New (Paper 1.21.11 compatible)

echo ==================================================
echo Building Essentials-New for Paper 1.21.11
echo ==================================================
echo.

REM Check if gradlew.bat exists
if not exist gradlew.bat (
    echo Error: gradlew.bat not found. Please run this script from the project root directory.
    exit /b 1
)

echo Step 1/3: Cleaning previous build...
call gradlew.bat clean
if errorlevel 1 (
    echo Error during clean step
    exit /b 1
)

echo.
echo Step 2/3: Building project (this may take a few minutes)...
call gradlew.bat build -x test
if errorlevel 1 (
    echo Error during build step
    exit /b 1
)

echo.
echo Step 3/3: Checking for JARs...
if not exist jars (
    echo Warning: jars directory not found. Build may have failed.
    echo Checking for JAR files in build directories...
    dir /s /b Essentials*.jar 2>nul | findstr /v "test .gradle"
) else (
    echo Build successful! JAR files are in the jars\ directory:
    dir /b jars\*.jar 2>nul
    if errorlevel 1 echo No JAR files found in jars\ directory
)

echo.
echo ==================================================
echo Build complete!
echo ==================================================
echo.
echo To test the plugin:
echo 1. Copy the Essentials.jar and required modules to your server's plugins\ folder
echo 2. Start your Paper 1.21.11 server
echo 3. Test with players who have essentials.joinfullserver permission
echo.

pause
