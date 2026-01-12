import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/repositories/auth_repository.dart';
import '../repositories/remote_auth_repository.dart';
import 'auth_data_source_provider.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dataSource = ref.watch(authDataSourceProvider);
  return RemoteAuthRepository(dataSource);
});
