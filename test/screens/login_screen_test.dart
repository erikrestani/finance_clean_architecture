import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:finance_clean_architecture/presentation/screens/login_screen.dart';

void main() {
  group('LoginPage', () {
    testWidgets('deve renderizar todos os componentes principais', (tester) async {
      // Arrange
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LoginScreen(),
          ),
        ),
      );

      // Assert - Verifica se os widgets principais estão presentes
      expect(find.byType(LoginScreen), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(SafeArea), findsOneWidget);
      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });

    testWidgets('deve ter layout responsivo com ConstrainedBox', (tester) async {
      // Arrange
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LoginScreen(),
          ),
        ),
      );

      // Assert
      expect(find.byType(ConstrainedBox), findsWidgets);
      expect(find.byType(IntrinsicHeight), findsOneWidget);
    });

    testWidgets('deve usar o tema correto', (tester) async {
      // Arrange
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LoginScreen(),
          ),
        ),
      );

      // Assert
      final scaffold = tester.widget<Scaffold>(find.byType(Scaffold));
      expect(scaffold.backgroundColor, isNotNull);
    });
  });
} 