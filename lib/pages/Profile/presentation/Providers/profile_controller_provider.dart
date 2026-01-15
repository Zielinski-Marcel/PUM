import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled/pages/Profile/domain/providers/get_top_users_usecase_provider.dart';
import 'package:untitled/pages/Profile/domain/providers/get_user_stats_usecase_provider.dart';
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
  final getUserStatsUseCase = ref.watch(getUserStatsUseCaseProvider);
  final getTopUsersUseCase = ref.watch(getTopUserUseCaseProvider);
  return ProfileController(
    ref,
      updateProfileUseCase,
      getProfileUseCase,
      deleteUserRequestUseCase,
      getTopUsersUseCase,
      getUserStatsUseCase
  );
});
