import 'package:flutter/material.dart';
import 'package:untitled/pages/Trainings/presentation/pages/active_training_page.dart';

import '../../../../../l10n/app_localizations.dart';


class NewTrainingButton extends StatelessWidget {
  const NewTrainingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton.icon(
        onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (_) => const ActiveTrainingPage(),),
        );},
        icon: const Icon(Icons.add_circle),
        label: Text(AppLocalizations.of(context)!.startTraining),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF6FC2DF),
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(60),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
