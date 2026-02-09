#!/bin/bash
# Build script for Essentials-New (Paper 1.21.11 compatible)

set -e  # Exit on error

echo "=================================================="
echo "Building Essentials-New for Paper 1.21.11"
echo "=================================================="
echo ""

# Check if gradlew exists
if [ ! -f "gradlew" ]; then
    echo "Error: gradlew not found. Please run this script from the project root directory."
    exit 1
fi

# Make gradlew executable
chmod +x gradlew

echo "Step 1/3: Cleaning previous build..."
./gradlew clean

echo ""
echo "Step 2/3: Building project (this may take a few minutes)..."
./gradlew build -x test

echo ""
echo "Step 3/3: Copying JARs to output directory..."
if [ ! -d "jars" ]; then
    echo "Warning: jars directory not found. Build may have failed."
    echo "Checking for JAR files in build directories..."
    find . -name "Essentials*.jar" -not -path "*/test/*" -not -path "*/.gradle/*" | while read jar; do
        echo "Found: $jar"
    done
else
    echo "Build successful! JAR files are in the jars/ directory:"
    ls -lh jars/*.jar 2>/dev/null || echo "No JAR files found in jars/ directory"
fi

echo ""
echo "=================================================="
echo "Build complete!"
echo "=================================================="
echo ""
echo "To test the plugin:"
echo "1. Copy the Essentials.jar and required modules to your server's plugins/ folder"
echo "2. Start your Paper 1.21.11 server"
echo "3. Test with players who have essentials.joinfullserver permission"
echo ""
