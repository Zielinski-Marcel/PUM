import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/button.dart';
import '../providers/auth_controller_provider.dart';

class ForgotPasswordForm extends ConsumerWidget {
  final TextEditingController emailController;

  const ForgotPasswordForm({
    super.key,
    required this.emailController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context)!;
    final authState = ref.watch(authControllerProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: t.recoverAccount,
            hintText: 'example@gmail.com',
            border: const OutlineInputBorder(),
          ),
        ),

        const SizedBox(height: 16),

        Button(
          buttonText: t.send,
          isLoading: authState.isLoading,
          onPressed: () {
            ref
                .read(authControllerProvider.notifier)
                .forgotPassword(
              context,
              emailController.text.trim(),
            );
          },
        ),
      ],
    );
  }
}
