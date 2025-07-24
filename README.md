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
│   └── repositories/      # Repository interfaces
├── presentation/           # UI layer
│   ├── controllers/       # Riverpod providers
│   ├── pages/            # Application screens
│   └── widgets/          # Page-specific widgets
├── shared/                 # Shared components
│   └── widgets/          # Reusable widgets
└── main.dart              # Application entry point
```

### Architecture Layers

1. **Presentation Layer** (`presentation/`): UI components, pages, and state management
2. **Domain Layer** (`domain/`): Business logic, entities, and repository contracts
3. **Core Layer** (`core/`): Utilities, constants, and shared configurations
4. **Shared Layer** (`shared/`): Reusable components across the application

### Key Principles

- **Separation of Concerns**: Each layer has specific responsibilities
- **Dependency Inversion**: High-level modules don't depend on low-level modules
- **Single Responsibility**: Each class has one reason to change
- **Testability**: Architecture designed for easy testing

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (version 3.8.0 or higher)
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
- ✅ Automated deployment to Firebase App Distribution (Android)
- ✅ Automated deployment to TestFlight (iOS)

For detailed CI/CD documentation, see [docs/CI_CD.md](docs/CI_CD.md).

## 📄 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## 🤝 Contributing

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📞 Contact

- **Developer**: [Your Name]
- **Email**: [your-email@example.com]
- **LinkedIn**: [your-linkedin]

---

⭐ If this project helped you, consider giving it a star!
