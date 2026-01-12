import '../../../../models/training_model.dart';
import '../repositories/training_repository.dart';

class GetTrainingUseCase {
  final TrainingRepository repository;

  GetTrainingUseCase(this.repository);

  Future<Training> call(int id) {
    return repository.getTraining(id);
  }
}
