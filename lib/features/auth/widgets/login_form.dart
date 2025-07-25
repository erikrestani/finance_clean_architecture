import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/form_validators.dart';
import '../../../shared/widgets/custom_text_field.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../presentation/providers/auth_provider.dart';

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key});

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  bool _obscurePassword = true;
  bool _isRegisterMode = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      bool success;
      
      if (_isRegisterMode) {
        success = await ref
            .read(authNotifierProvider.notifier)
            .register(_emailController.text.trim(), _passwordController.text, _nameController.text.trim());
      } else {
        success = await ref
            .read(authNotifierProvider.notifier)
            .login(_emailController.text.trim(), _passwordController.text);
      }

      if (!success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_isRegisterMode ? 'Registration failed' : 'Invalid email or password'),
            backgroundColor: AppTheme.errorColor,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  String? _validateEmail(String? value) => FormValidators.validateEmail(value);

  String? _validatePassword(String? value) =>
      FormValidators.validatePassword(value);

  String? _validateName(String? value) {
    if (_isRegisterMode && (value == null || value.trim().isEmpty)) {
      return 'Please enter your name';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_isRegisterMode) ...[
            CustomTextField(
              label: 'Name',
              hint: 'Enter your full name',
              controller: _nameController,
              validator: _validateName,
              prefixIcon: const Icon(Icons.person_outlined),
            ),
            const SizedBox(height: AppConstants.paddingLarge),
          ],
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
                _obscurePassword
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
              ),
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),
          ),
          const SizedBox(height: AppConstants.paddingMedium),
          if (!_isRegisterMode) ...[
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text(AppConstants.forgotPasswordText),
              ),
            ),
          ],
          const SizedBox(height: AppConstants.paddingLarge),
          CustomButton(
            text: _isRegisterMode ? 'Register' : AppConstants.loginButtonText,
            onPressed: authState.isLoading ? null : _handleSubmit,
            isLoading: authState.isLoading,
          ),
          const SizedBox(height: AppConstants.paddingLarge),
          Center(
            child: TextButton(
              onPressed: () {
                setState(() {
                  _isRegisterMode = !_isRegisterMode;
                });
              },
              child: Text(_isRegisterMode ? 'Already have an account? Login' : 'Don\'t have an account? Register'),
            ),
          ),
        ],
      ),
    );
  }
}
