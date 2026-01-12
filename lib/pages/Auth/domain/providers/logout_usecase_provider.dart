import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/providers/auth_repository_provider.dart';
import '../usecases/logout_usecase.dart';


final logoutUseCaseProvider = Provider<LogoutUseCase>((ref) {
  final repo = ref.watch(authRepositoryProvider);
  return LogoutUseCase(repo);
});
