import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/providers/get_training_usecase_provider.dart';
import '../../domain/providers/update_training_usecase_provider.dart';
import '../controllers/training_controller.dart';


final trainingControllerProvider = ChangeNotifierProvider<TrainingController>((ref,) {
  final getTrainingUseCase = ref.watch(getTrainingUseCaseProvider);
  final updateTrainingUseCase = ref.watch(updateTrainingUseCaseProvider);
  return TrainingController(
    getTrainingUseCase: getTrainingUseCase,
    updateTrainingUseCase: updateTrainingUseCase,
  )..loadTrainings();
});
