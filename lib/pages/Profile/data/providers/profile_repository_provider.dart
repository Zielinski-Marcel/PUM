import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled/pages/Profile/data/providers/profile_data_source_provider.dart';

import '../../domain/repositories/profile_repository.dart';
import '../repositories/remote_profile_repository.dart';


final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  final dataSource = ref.watch(profileDataSourceProvider);
  return RemoteProfileRepository(dataSource);
});
