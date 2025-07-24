import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../presentation/pages/login_page.dart';
import '../../presentation/pages/home_page.dart';
import '../../presentation/controllers/auth_controller.dart';

class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);
    return authState.when(
      data: (user) => user == null ? const LoginPage() : const HomePage(),
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text('Error: $e'))),
    );
  }
} 