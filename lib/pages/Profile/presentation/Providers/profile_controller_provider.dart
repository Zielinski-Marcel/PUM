import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/providers/delete_user_request_usecase_provider.dart';
import '../../domain/providers/get_profile_usecase_provider.dart';
import '../../domain/providers/update_profile_usecase_provider.dart';
import '../controllers/profile_controller.dart';


final profileControllerProvider = ChangeNotifierProvider<ProfileController>((
    ref,
    ) {
  final getProfileUseCase = ref.watch(getProfileUseCaseProvider);
  final updateProfileUseCase = ref.watch(updateProfileUseCaseProvider);
  final deleteUserRequestUseCase = ref.watch(deleteUserRequestUseCaseProvider);
  return ProfileController(
    ref,
    updateProfileUseCase,
    getProfileUseCase,
    deleteUserRequestUseCase,
  );
});
