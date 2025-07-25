# Finance Clean Architecture

A personal finance application built with Flutter using Clean Architecture principles and Riverpod for state management.

## 🚀 Features

- **Authentication**: Secure login system
- **Dashboard**: Financial overview and insights
- **Wallet**: Portfolio and investment management
- **Reports**: Financial analysis and reporting
- **Tips**: Financial education and tips

## 🛠️ Tech Stack

- **Flutter**: Cross-platform development framework
- **Dart**: Programming language
- **Riverpod**: State management and dependency injection
- **Clean Architecture**: Separation of concerns across layers
- **Google Fonts**: Typography

## 📱 Supported Platforms

- iOS
- Android

## 🏗️ Architecture

This project follows Clean Architecture principles with a clear separation of concerns:

### Project Structure

```
lib/
├── core/                    # Core utilities and configurations
│   ├── constants/          # Application constants
│   ├── navigation/         # Route management
│   ├── theme/             # App theming
│   └── utils/             # Utility functions
├── domain/                 # Business logic layer
│   ├── entities/          # Domain entities
│   └── repositories/      # Repository interfaces and implementations
├── features/               # Feature-based modules
│   ├── auth/               # Authentication feature
│   │   ├── controllers/    # Auth state management
│   │   ├── screens/        # Auth screens (login, register, profile)
│   │   └── widgets/        # Auth-specific widgets
│   ├── dashboard/          # Dashboard feature
│   │   ├── controllers/    # Dashboard state management
│   │   ├── screens/        # Dashboard screens
│   │   └── widgets/        # Dashboard-specific widgets
│   ├── wallet/             # Wallet management feature
│   │   ├── controllers/    # Wallet state management
│   │   ├── screens/        # Wallet screens
│   │   └── widgets/        # Wallet-specific widgets
│   ├── reports/            # Reports and analytics feature
│   │   ├── controllers/    # Reports state management
│   │   ├── screens/        # Reports screens
│   │   └── widgets/        # Reports-specific widgets
│   └── tips/               # Financial tips feature
│       ├── controllers/    # Tips state management
│       ├── screens/        # Tips screens
│       └── widgets/        # Tips-specific widgets
├── shared/                 # Shared components
│   └── widgets/            # Common widgets (AppBar, AppFooter, etc.)
└── main.dart               # Application entry point
```

### Architecture Layers

1. **Features Layer** (`features/`): Feature-based modules with screens, controllers, and widgets
2. **Domain Layer** (`domain/`): Business logic, entities, and repository contracts
3. **Core Layer** (`core/`): Utilities, constants, and shared configurations
4. **Shared Layer** (`shared/`): Reusable components across the application

### Feature Organization

Each feature follows a consistent structure:
- **controllers/**: Riverpod providers for state management
- **screens/**: Main screens and sub-screens for the feature
- **widgets/**: Feature-specific reusable widgets

Features are organized by business functionality, not by individual pages. Sub-pages and related functionality are grouped within their respective features.

### Key Principles

- **Separation of Concerns**: Each layer has specific responsibilities
- **Dependency Inversion**: High-level modules don't depend on low-level modules
- **Single Responsibility**: Each class has one reason to change
- **Testability**: Architecture designed for easy testing

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (version 3.32.7 or higher)
- Dart SDK
- Android Studio / Xcode (for mobile development)

### Installation

1. Clone the repository:
```bash
git clone https://github.com/your-username/finance_clean_architecture.git
cd finance_clean_architecture
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the project:
```bash
flutter run
```

## 🧪 Testing

To run tests:

```bash
flutter test
```

### Running Tests with Coverage

```bash
# Run tests with coverage
flutter test --coverage

# Generate HTML coverage report
genhtml coverage/lcov.info -o coverage/html
```

### Pre-commit Checks

We provide a script to run all checks locally before committing:

```bash
# Run all pre-commit checks
./scripts/pre_commit.sh
```

This script will:
- ✅ Get dependencies
- ✅ Analyze code
- ✅ Check formatting
- ✅ Run tests
- ✅ Generate coverage
- ✅ Build Android debug version
- ✅ Attempt web build

## 🚀 CI/CD

This project uses GitHub Actions for Continuous Integration and Continuous Deployment.

### Workflows

- **CI/CD Pipeline**: Runs on main branch pushes and PRs
- **Development Checks**: Runs on feature branches and PRs

### Features

- ✅ Automated testing and code analysis
- ✅ Build verification for Android and iOS
- ✅ Test coverage reporting with Codecov
- ✅ Build artifacts generation for manual distribution

For detailed CI/CD documentation, see [docs/CI_CD.md](docs/CI_CD.md).

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

### What this means:
- ✅ **Free to use**: You can use this code for personal and commercial projects
- ✅ **Modify**: You can modify and adapt the code
- ✅ **Distribute**: You can distribute copies of the code
- ✅ **Attribution**: You must include the original license and copyright notice

For more information about the MIT License, visit: https://opensource.org/licenses/MIT

## 🤝 Contributing

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📞 Contact

- **Developer**: Érik Restani
- **Email**: erikeduardorestani@gmail.com
- **LinkedIn**: https://www.linkedin.com/in/erikrestani

---

⭐ If this project helped you, consider giving it a star!
