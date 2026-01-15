import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/your_profile_controller.dart';

final yourProfileControllerProvider =
StateNotifierProvider<YourProfileController, ProfileSection>(
      (ref) => YourProfileController(ref),
);
