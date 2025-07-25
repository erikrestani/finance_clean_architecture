import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:finance_clean_architecture/core/constants/app_constants.dart';
import 'package:finance_clean_architecture/features/auth/widgets/login_header.dart';

void main() {
  group('LoginHeader', () {
    testWidgets('deve exibir o título e subtítulo corretos', (tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: LoginHeader(),
          ),
        ),
      );

      // Assert
      expect(find.text(AppConstants.loginTitle), findsOneWidget);
      expect(find.text(AppConstants.loginSubtitle), findsOneWidget);
    });

    testWidgets('deve exibir o ícone de lock', (tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: LoginHeader(),
          ),
        ),
      );

      // Assert
      expect(find.byIcon(Icons.lock_outline), findsOneWidget);
    });

    testWidgets('deve ter o container com decoração correta', (tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: LoginHeader(),
          ),
        ),
      );

      // Assert
      final container = tester.widget<Container>(
        find.byType(Container).first,
      );
      
      expect(container.decoration, isNotNull);
      expect(container.constraints, isNotNull);
    });
  });
} 