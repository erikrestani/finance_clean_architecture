# CI/CD Documentation

This document explains the Continuous Integration and Continuous Deployment setup for the Finance Clean Architecture project.

## Overview

We use GitHub Actions for CI/CD with the following workflows:

1. **CI/CD Pipeline** (`.github/workflows/ci_cd.yml`)
2. **Development Checks** (`.github/workflows/development.yml`)

## Workflows

### 1. CI/CD Pipeline

**Triggers:**
- Push to `main` or `develop` branches
- Pull requests to `main` branch

**Jobs:**
- **Test**: Runs code analysis, tests, and uploads coverage
- **Build Android**: Creates APK for Android
- **Build iOS**: Creates iOS build
- **Build Artifacts**: Creates artifacts for manual distribution

### 2. Development Checks

**Triggers:**
- Pull requests to `main` or `develop`
- Push to `develop`, `feature/*`, or `bugfix/*` branches

**Jobs:**
- **Quality Check**: Code analysis, tests, formatting, dependency check
- **Build Check**: Ensures the app builds successfully

## Setup Instructions

### 1. Distribution Options

#### Current Setup (Free):
- **Android**: Manual APK distribution via GitHub artifacts
- **iOS**: Manual distribution via Xcode
- **Build Verification**: Ensures app builds successfully on both platforms

#### Optional Paid Services:
- **Apple Developer Account**: $99/year for TestFlight and App Store distribution
- **Firebase App Distribution**: Free tier available for Android testing
- **Google Play Console**: Free for internal testing

### 2. Codecov Integration

1. Sign up at [codecov.io](https://codecov.io)
2. Connect your GitHub repository
3. Add the repository token to GitHub secrets (optional)

### 3. Branch Protection Rules

Set up branch protection for `main`:
- Require status checks to pass
- Require branches to be up to date
- Require pull request reviews

## Local Development

### Running Tests with Coverage

```bash
# Run tests with coverage
flutter test --coverage

# Generate coverage report
genhtml coverage/lcov.info -o coverage/html
```

### Pre-commit Checks

```bash
# Analyze code
flutter analyze

# Run tests
flutter test

# Check formatting
dart format --set-exit-if-changed .

# Check dependencies
flutter pub deps --style=compact
```

## Deployment

### Android

1. Build APK: `flutter build apk --release`
2. APK location: `build/app/outputs/flutter-apk/app-release.apk`

### iOS

1. Build iOS: `flutter build ios --release`
2. Archive and upload to App Store Connect

## Troubleshooting

### Common Issues

1. **Flutter version mismatch**: Update `flutter-version` in workflows
2. **Java version issues**: Ensure Java 17 is used for Android builds
3. **iOS signing issues**: Configure proper certificates and provisioning profiles

### Debugging

- Check GitHub Actions logs for detailed error messages
- Use `flutter doctor` locally to verify environment
- Ensure all dependencies are properly configured

## Best Practices

1. **Always run tests locally before pushing**
2. **Keep workflows up to date with Flutter versions**
3. **Use meaningful commit messages**
4. **Review pull requests thoroughly**
5. **Monitor test coverage trends**

## Resources

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Flutter CI/CD Guide](https://docs.flutter.dev/deployment/ci)
- [Firebase App Distribution](https://firebase.google.com/docs/app-distribution)
- [App Store Connect API](https://developer.apple.com/documentation/appstoreconnectapi) 