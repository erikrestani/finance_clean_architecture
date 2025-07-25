import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../../domain/entities/login_credentials.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/repositories/auth_repository_impl.dart';
import '../../../domain/repositories/auth_repository.dart';

part 'auth_controller.g.dart';

@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepositoryImpl();
}

@riverpod
class AuthController extends _$AuthController {
  @override
  Future<User?> build() async {
    final repository = ref.read(authRepositoryProvider);
    return await repository.getCurrentUser();
  }

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();

    try {
      final repository = ref.read(authRepositoryProvider);
      final credentials = LoginCredentials(email: email, password: password);
      final user = await repository.login(credentials);
      state = AsyncValue.data(user);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> logout() async {
    try {
      final repository = ref.read(authRepositoryProvider);
      await repository.logout();
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  String? getWelcomeMessage() {
    return state.when(
      data: (user) => user != null ? 'Welcome, ${user.name}!' : null,
      loading: () => null,
      error: (error, stackTrace) => 'Error: ${error.toString()}',
    );
  }

  bool get isError => state.hasError;
  bool get isSuccess => state.hasValue && state.value != null;

  void showWelcomeMessage(BuildContext context) {
    final message = getWelcomeMessage();
    if (message != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: isError
                ? AppTheme.errorColor
                : AppTheme.secondaryColor,
          ),
        );
      });
    }
  }
}
