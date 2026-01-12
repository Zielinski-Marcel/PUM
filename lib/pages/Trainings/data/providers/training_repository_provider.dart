import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled/pages/Trainings/data/providers/training_data_source_provider.dart';

import '../../domain/repositories/training_repository.dart';
import '../repositories/remote_training_repository.dart';


final trainingRepositoryProvider = Provider<TrainingRepository>((ref) {
  final dataSource = ref.watch(trainingDataSourceProvider);
  return RemoteTrainingRepository(dataSource);
});
