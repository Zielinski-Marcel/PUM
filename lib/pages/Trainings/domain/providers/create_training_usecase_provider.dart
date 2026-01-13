import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/providers/training_repository_provider.dart';
import '../usecases/create_training_usecase.dart';


final createTrainingUseCaseProvider = Provider<CreateTrainingUseCase>((ref) {
  final repository = ref.watch(trainingRepositoryProvider);
  return CreateTrainingUseCase(repository);
});
