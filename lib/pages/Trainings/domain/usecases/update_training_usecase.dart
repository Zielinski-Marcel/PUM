import 'package:flutter/material.dart';

import '../repositories/training_repository.dart';


class UpdateTrainingUseCase {
  final TrainingRepository repository;

  UpdateTrainingUseCase(this.repository);

  Future<void> call({
    required BuildContext context,
    String? name,
    String? type,
    String? note,
  }) {
    return repository.updateTraining(
      context: context,
      name: name,
      type: type,
      note: note,
    );
  }
}

