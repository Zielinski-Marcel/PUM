import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/default_view.dart';
import '../widgets/training_details.dart';

class TrainingDetailsPage extends ConsumerWidget {
  const TrainingDetailsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: DefaultView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TrainingDetails()
          ],
        ),
      ),
    );
  }
}