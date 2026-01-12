import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
class HomePageButton extends StatelessWidget {
  const HomePageButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),),
        onPressed: () {
          Navigator.pop(context);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.arrow_back, color: Color(0xFF00C2FF), size: 18),
            const SizedBox(width: 6),
            Text(AppLocalizations.of(context)!.backButton, style: TextStyle(color: Color(0xFF00C2FF)),),
          ],
        ),
      ),
    );
  }
}
