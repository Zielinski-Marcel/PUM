import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/providers/profile_repository_provider.dart';
import '../usecases/update_profile_usecase.dart';


final updateProfileUseCaseProvider = Provider<UpdateProfileUseCase>((ref) {
  final repository = ref.watch(profileRepositoryProvider);
  return UpdateProfileUseCase(repository);
});
