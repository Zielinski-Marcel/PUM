import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'localization_controller_provider.dart';

final localizationLoaderProvider = FutureProvider<void>((ref) async {
  final controller = ref.read(localizationControllerProvider);
  await controller.loadLocale();
});
