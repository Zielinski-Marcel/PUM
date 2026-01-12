import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/providers/training_repository_provider.dart';
import '../usecases/get_trainings_usecase.dart';


final getTrainingsUseCaseProvider = Provider<GetTrainingsUseCase>((ref) {
  final repo = ref.watch(trainingRepositoryProvider);
  return GetTrainingsUseCase(repo);
});
