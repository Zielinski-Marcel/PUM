import '../../../../models/training_model.dart';
import '../repositories/training_repository.dart';

class CreateTrainingUseCase {
  final TrainingRepository repository;

  CreateTrainingUseCase(this.repository);

  Future<void> call(Training training) {
    return repository.createTraining(training);
  }
}
