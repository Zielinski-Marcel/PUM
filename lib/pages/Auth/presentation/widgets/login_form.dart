import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../shared/button.dart';
import '../../../../shared/text_field.dart';
import '../providers/auth_controller_provider.dart';
import '../pages/forgot_password_page.dart';
import '../pages/register_page.dart';

class LoginForm extends ConsumerStatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginForm({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
  });

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final authController = ref.read(authControllerProvider.notifier);
    final state = ref.watch(authControllerProvider);
    final t = AppLocalizations.of(context)!;

    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFieldWidget(
            labelText: t.email,
            hintText: t.emailbox,
            controller: widget.emailController,
            keyboardType: TextInputType.emailAddress,
            validator: (value) =>
            value == null || value.isEmpty ? t.emailRequiredError : null,
          ),

          const SizedBox(height: 18),

          TextFieldWidget(
            labelText: t.password,
            hintText: t.passwordbox,
            controller: widget.passwordController,
            obscureText: !isPasswordVisible,
            validator: (value) =>
            value == null || value.isEmpty ? t.passwordRequiredError : null,
          ),

          const SizedBox(height: 22),

          Button(
            buttonText: t.loginButton,
            fullWidth: true,
            isLoading: state.isLoading,
            onPressed: () {
              if (widget.formKey.currentState!.validate()) {
                authController.login(
                  context,
                  widget.emailController.text,
                  widget.passwordController.text,
                );
              }
            },
          ),

          const SizedBox(height: 18),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(t.dontHaveAccount),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const RegisterPage(),
                    ),
                  );
                },
                child: Text(t.createAccount),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Center(
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ForgotPasswordPage(),
                  ),
                );
              },
              child: Text(t.forgotPassword),
            ),
          ),
        ],
      ),
    );
  }
}
