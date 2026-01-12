import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../models/training_model.dart';
import '../../../../shared/default_view.dart';
import '../widgets/training_details.dart';

class TrainingDetailsPage extends ConsumerWidget {
  final Training training;
  const TrainingDetailsPage({super.key,
    required this.training});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: DefaultView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TrainingDetails(training: training)
          ],
        ),
      ),
    );
  }
}