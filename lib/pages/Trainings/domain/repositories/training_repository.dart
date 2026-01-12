import 'package:flutter/material.dart';

import '../../../../models/training_model.dart';

abstract class TrainingRepository {
  Future<void> updateTraining({
    required BuildContext context,
    String? name,
    String? type,
    String? note,
  });

  Future<Training> getTraining(int id);
  Future<List<Training>> getTrainings({int page = 1});

}
