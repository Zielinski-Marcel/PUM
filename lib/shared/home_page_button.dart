import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled/pages/Profile/presentation/pages/home_page.dart';
import 'package:untitled/pages/Auth/presentation/pages/login_page.dart';
import '../../l10n/app_localizations.dart';
import '../pages/Auth/presentation/providers/auth_controller_provider.dart';

class HomePageButton extends ConsumerWidget {
  const HomePageButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authControllerProvider).value;

    return SizedBox(
      width: double.infinity,
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        onPressed: () {
          final targetPage = user != null ? const HomePage() : const LoginPage();
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => targetPage),
                (route) => false,
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.arrow_back, color: Color(0xFF00C2FF), size: 18),
            const SizedBox(width: 6),
            Text(AppLocalizations.of(context)!.backButton, style: const TextStyle(color: Color(0xFF00C2FF))),
          ],
        ),
      ),
    );
  }
}