import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled/shared/providers/localization_controller_provider.dart';

class LanguageSwitchButton extends ConsumerWidget {
  const LanguageSwitchButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(localizationControllerProvider);
   
    final currentLang = controller.locale.languageCode;
    final isPolish = currentLang == 'pl';
    final label = isPolish ? 'PL' : 'EN';

    return OutlinedButton.icon(
      onPressed: () {
        final newLang = isPolish ? 'en' : 'pl';
        controller.setLocale(newLang);
      },
      icon: Icon(Icons.language, color: Color(0xFF6FC2DF)),
      label: Text(label, style:  TextStyle(color: Color(0xFF6FC2DF))),
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Color(0xFF6FC2DF), width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        foregroundColor: Color(0xFF6FC2DF),
      ).copyWith(overlayColor: WidgetStateProperty.all(Colors.black12)),
    );
  }
}
