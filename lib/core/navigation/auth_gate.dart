import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/dashboard/screens/dashboard_screen.dart';
import '../../presentation/providers/auth_provider.dart';

class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);
    
    return authState.when(
      data: (user) => user == null ? const LoginScreen() : const DashboardScreen(),
      loading: () => const LoginScreen(),
      error: (error, stackTrace) => const LoginScreen(),
    );
  }
}
