import '../../../../models/user_stats.dart';
import '../repositories/profile_repository.dart';

class GetUserStatsUseCase {
  final ProfileRepository repository;

  GetUserStatsUseCase(this.repository);

  Future<UserStats> call() {
    return repository.getStats();
  }
}
