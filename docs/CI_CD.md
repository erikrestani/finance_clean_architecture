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
- **Deploy Android**: Uploads to Firebase App Distribution (optional)
- **Deploy iOS**: Uploads to TestFlight (optional)

### 2. Development Checks

**Triggers:**
- Pull requests to `main` or `develop`
- Push to `develop`, `feature/*`, or `bugfix/*` branches

**Jobs:**
- **Quality Check**: Code analysis, tests, formatting, dependency check
- **Build Check**: Ensures the app builds successfully

## Setup Instructions

### 1. Required Secrets

Add these secrets to your GitHub repository settings:

#### For Firebase App Distribution:
```
FIREBASE_APP_ID=your_firebase_app_id
FIREBASE_SERVICE_ACCOUNT=your_service_account_json
```

#### For TestFlight:
```
APP_STORE_CONNECT_API_KEY=your_api_key
APP_STORE_CONNECT_API_KEY_ID=your_key_id
APP_STORE_CONNECT_ISSUER_ID=your_issuer_id
```

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