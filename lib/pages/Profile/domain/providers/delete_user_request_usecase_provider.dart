import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/providers/profile_repository_provider.dart';
import '../usecases/delete_user_request_usecase.dart';


final deleteUserRequestUseCaseProvider = Provider<DeleteUserRequestUseCase>((
  ref,
) {
  final repository = ref.watch(profileRepositoryProvider);
  return DeleteUserRequestUseCase(repository);
});
