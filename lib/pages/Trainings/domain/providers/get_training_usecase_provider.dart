import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/providers/training_repository_provider.dart';
import '../usecases/get_training_usecase.dart';


final getTrainingUseCaseProvider = Provider<GetTrainingUseCase>((ref) {
  final repository = ref.watch(trainingRepositoryProvider);
  return GetTrainingUseCase(repository);
});
