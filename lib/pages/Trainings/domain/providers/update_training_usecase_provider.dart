import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/providers/training_repository_provider.dart';
import '../usecases/update_training_usecase.dart';


final updateTrainingUseCaseProvider = Provider<UpdateTrainingUseCase>((ref) {
  final repository = ref.watch(trainingRepositoryProvider);
  return UpdateTrainingUseCase(repository);
});
