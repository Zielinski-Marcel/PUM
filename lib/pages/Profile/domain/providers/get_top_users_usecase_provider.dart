import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/providers/profile_repository_provider.dart';
import '../usecases/get_top_users_usecase.dart';


final getTopUserUseCaseProvider = Provider<GetTopUsersUseCase>((ref) {
  final repository = ref.watch(profileRepositoryProvider);
  return GetTopUsersUseCase(repository);
});
