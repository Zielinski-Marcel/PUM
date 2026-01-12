import '../../../../models/training_model.dart';
import '../repositories/training_repository.dart';

class GetTrainingsUseCase {
  final TrainingRepository repository;

  GetTrainingsUseCase(this.repository);

  Future<List<Training>> call({int page = 1}) {
    return repository.getTrainings(page: page);
  }
}
