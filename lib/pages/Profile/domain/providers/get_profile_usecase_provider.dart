import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/providers/profile_repository_provider.dart';
import '../usecases/get_profile_usecase.dart';


final getProfileUseCaseProvider = Provider<GetProfileUseCase>((ref) {
  final repository = ref.watch(profileRepositoryProvider);
  return GetProfileUseCase(repository);
});
