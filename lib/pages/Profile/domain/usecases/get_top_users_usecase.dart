import 'package:untitled/models/top_users.dart';

import '../repositories/profile_repository.dart';

class GetTopUsersUseCase {
  final ProfileRepository repository;

  GetTopUsersUseCase(this.repository);

  Future<List<TopUser>> call() {
    return repository.getTopUsers();
  }
}
