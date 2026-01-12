import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../network/http_client_provider.dart';
import '../data_sources/profile_data_source.dart';


final profileDataSourceProvider = Provider<ProfileDataSource>((ref) {
  final httpClient = ref.watch(httpClientProvider);
  return ProfileDataSource(httpClient);
});
