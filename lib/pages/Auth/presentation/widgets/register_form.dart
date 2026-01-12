import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/button.dart';
import '../../../../shared/text_field.dart';
import '../providers/auth_controller_provider.dart';

class RegisterForm extends ConsumerStatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  const RegisterForm({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
  });
  @override
  ConsumerState<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends ConsumerState<RegisterForm> {
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final authController = ref.read(authControllerProvider.notifier);
    final t = AppLocalizations.of(context)!;
    final isLoading = ref.watch(authControllerProvider).isLoading;

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
        ),

        TextFieldWidget(
          labelText: t.password,
          hintText: t.passwordbox,
          controller: widget.passwordController,
          obscureText: true,
        ),

        TextFieldWidget(
          labelText: t.confirmPassword,
          hintText: t.confirmPasswordBox,
          controller: widget.confirmPasswordController,
          obscureText: true,
        ),

        Button(
          buttonText: t.registerButton,
          isLoading: isLoading,
          onPressed: () {
            if (widget.formKey.currentState!.validate()) {
              authController.register(
                context,
                widget.emailController.text,
                widget.passwordController.text,
                widget.confirmPasswordController.text,
              );
            }
          },
        ),

      ],
    ),
    );
  }
}
