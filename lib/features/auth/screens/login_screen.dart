import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';
import '../widgets/login_header.dart';
import '../widgets/login_form_container.dart';
import '../../../shared/widgets/app_footer.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.paddingXLarge),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight:
                  MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top -
                  MediaQuery.of(context).padding.bottom,
            ),
            child: const IntrinsicHeight(
              child: Column(
                children: [
                  Spacer(),
                  LoginHeader(),
                  SizedBox(height: AppConstants.paddingXLarge),
                  LoginFormContainer(),
                  Spacer(),
                  AppFooter(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
