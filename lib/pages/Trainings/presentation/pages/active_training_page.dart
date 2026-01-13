import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/default_view.dart';
import '../widgets/active_training.dart';

class ActiveTrainingPage extends ConsumerWidget {
  const ActiveTrainingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: DefaultView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FakeTrainingButton(),
          ],
        ),
      ),
    );
  }
}