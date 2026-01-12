import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../network/http_client_provider.dart';
import '../auth_data_source.dart';

final authDataSourceProvider = Provider<AuthDataSource>((ref) {
  final httpClient = ref.watch(httpClientProvider);
  return AuthDataSource(httpClient);
});
