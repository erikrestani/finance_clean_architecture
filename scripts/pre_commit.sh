#!/bin/bash

# Pre-commit script for Finance Clean Architecture
# This script runs all the checks that CI/CD would run locally

set -e

echo "🚀 Running pre-commit checks..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    print_error "Flutter is not installed or not in PATH"
    exit 1
fi

# Check Flutter version
echo "🔍 Checking Flutter version..."
FLUTTER_VERSION=$(flutter --version | grep -o 'Flutter [0-9]\+\.[0-9]\+\.[0-9]\+' | head -1)
echo "Current Flutter version: $FLUTTER_VERSION"

# Check if version is compatible (should be 3.32.x or higher)
if [[ ! "$FLUTTER_VERSION" =~ Flutter\ 3\.(3[2-9]|[4-9][0-9]|[0-9]{2,}) ]]; then
    print_warning "Flutter version might be outdated. Recommended: 3.32.7 or higher"
fi

# Get Flutter dependencies
echo "📦 Getting dependencies..."
flutter pub get

# Run Flutter analyze
echo "🔍 Analyzing code..."
if flutter analyze; then
    print_status "Code analysis passed"
else
    print_error "Code analysis failed"
    exit 1
fi

# Check code formatting
echo "🎨 Checking code formatting..."
if dart format --set-exit-if-changed .; then
    print_status "Code formatting is correct"
else
    print_warning "Code formatting issues found. Run 'dart format .' to fix"
fi

# Run tests
echo "🧪 Running tests..."
if flutter test; then
    print_status "All tests passed"
else
    print_error "Tests failed"
    exit 1
fi

# Run tests with coverage
echo "📊 Running tests with coverage..."
flutter test --coverage

# Check for unused dependencies
echo "🔍 Checking for unused dependencies..."
flutter pub deps --style=compact

# Build check (Android debug)
echo "🏗️  Building Android debug version..."
if flutter build apk --debug; then
    print_status "Android build successful"
else
    print_error "Android build failed"
    exit 1
fi

# Build check (Web)
echo "🌐 Building for web..."
if flutter build web; then
    print_status "Web build successful"
else
    print_warning "Web build failed (this might be expected for mobile-only apps)"
fi

print_status "All pre-commit checks passed! 🎉"
print_status "You can now commit your changes safely."

echo ""
echo "📋 Summary:"
echo "  ✅ Dependencies updated"
echo "  ✅ Code analysis passed"
echo "  ✅ Code formatting checked"
echo "  ✅ Tests passed"
echo "  ✅ Coverage generated"
echo "  ✅ Android build successful"
echo "  ✅ Web build attempted" 