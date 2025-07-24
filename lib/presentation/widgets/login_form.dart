import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_constants.dart';
import '../../core/utils/form_validators.dart';
import '../../shared/widgets/custom_text_field.dart';
import '../../shared/widgets/custom_button.dart';
import '../controllers/auth_controller.dart';

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key});

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      ref.read(authControllerProvider.notifier).login(
        _emailController.text.trim(),
        _passwordController.text,
      );
    }
  }

  String? _validateEmail(String? value) => FormValidators.validateEmail(value);

  String? _validatePassword(String? value) => FormValidators.validatePassword(value);

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);
    
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
            label: 'Email',
            hint: AppConstants.emailHint,
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            validator: _validateEmail,
            prefixIcon: const Icon(Icons.email_outlined),
          ),
          const SizedBox(height: AppConstants.paddingLarge),
          CustomTextField(
            label: 'Password',
            hint: AppConstants.passwordHint,
            controller: _passwordController,
            obscureText: _obscurePassword,
            validator: _validatePassword,
            prefixIcon: const Icon(Icons.lock_outlined),
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
              ),
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),
          ),
          const SizedBox(height: AppConstants.paddingMedium),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
              },
              child: Text(AppConstants.forgotPasswordText),
            ),
          ),
          const SizedBox(height: AppConstants.paddingLarge),
          CustomButton(
            text: AppConstants.loginButtonText,
            onPressed: _handleLogin,
            isLoading: authState.isLoading,
          ),
          const SizedBox(height: AppConstants.paddingLarge),
          Center(
            child: TextButton(
              onPressed: () {
              },
              child: Text(AppConstants.signUpText),
            ),
          ),
        ],
      ),
    );
  }
} 