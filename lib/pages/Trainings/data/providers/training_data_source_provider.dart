import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../network/http_client_provider.dart';
import '../data_sources/training_data_source.dart';


final trainingDataSourceProvider = Provider<TrainingDataSource>((ref) {
  final httpClient = ref.watch(httpClientProvider);
  return TrainingDataSource(httpClient);
});
