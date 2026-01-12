import 'package:flutter/material.dart';

import '../../../../models/training_model.dart';
import '../../domain/repositories/training_repository.dart';
import '../data_sources/training_data_source.dart';


class RemoteTrainingRepository implements TrainingRepository {
  final TrainingDataSource dataSource;

  RemoteTrainingRepository(this.dataSource);

  @override
  Future<void> updateTraining({
    required BuildContext context,
    String? name,
    String? type,
    String? note,
  }) =>
      dataSource.updateTraining(
        context: context,
        name: name,
        type: type,
        note: note,
      );

  @override
  Future<Training> getTraining(int id) => dataSource.getTraining(id);

  @override
  Future<List<Training>> getTrainings({int page = 1}) {
    return dataSource.getTrainings(page: page);
  }

}

