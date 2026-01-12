import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/localization_controller.dart';

final localizationControllerProvider =
    ChangeNotifierProvider<LocalizationController>((ref) {
      return LocalizationController();
    });
