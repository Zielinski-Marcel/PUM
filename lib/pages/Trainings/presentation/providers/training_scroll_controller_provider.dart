import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled/pages/Trainings/presentation/providers/training_controller_provider.dart';


final trainingScrollControllerProvider = Provider.autoDispose<ScrollController>((ref) {
  final controller = ScrollController();

  controller.addListener(() {
    final state = ref.read(trainingControllerProvider);
    final notifier = ref.read(trainingControllerProvider.notifier);

    if (controller.position.pixels < controller.position.maxScrollExtent - 200) {
      return;
    }

    if (!state.hasMore || state.isLoading) {
      return;
    }

    notifier.loadTrainings();
  });

  ref.onDispose(() {
    controller.dispose();
  });

  return controller;
});
