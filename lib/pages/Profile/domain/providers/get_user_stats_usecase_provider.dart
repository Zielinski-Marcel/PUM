import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/providers/profile_repository_provider.dart';
import '../usecases/get_user_stats_usecase.dart';


final getUserStatsUseCaseProvider = Provider<GetUserStatsUseCase>((ref) {
  final repository = ref.watch(profileRepositoryProvider);
  return GetUserStatsUseCase(repository);
});
