import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled/pages/Trainings/presentation/widgets/training_list.dart';
import '../../../../shared/logo.dart';
import '../widgets/HomeWidgets/new_training_button.dart';
import '../widgets/HomeWidgets/profile_menu.dart';



class HomePage extends ConsumerWidget {

  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const LogoHeader(),
            const NewTrainingButton(),
            Expanded(
              child: TrainingList(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const ProfileMenu(),
    );
  }
}
