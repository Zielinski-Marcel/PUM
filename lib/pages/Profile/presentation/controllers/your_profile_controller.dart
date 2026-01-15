import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/top_users.dart';
import '../../../../models/user_stats.dart';
import '../../data/providers/profile_repository_provider.dart';
import '../../domain/providers/get_top_users_usecase_provider.dart';
import '../../domain/providers/get_user_stats_usecase_provider.dart';
import '../Providers/profile_user_provider.dart';

enum ProfileSection { stats, ranking }

class YourProfileController extends StateNotifier<ProfileSection> {
  final Ref ref;

  YourProfileController(this.ref) : super(ProfileSection.stats);

  UserStats? userStats;
  List<TopUser> ranking = [];

  Future<void> loadProfileData() async {
    await Future.wait([
      _loadUser(),
      _loadStats(),
      _loadRanking(),
    ]);
  }

  Future<void> _loadUser() async {
    final repository = ref.read(profileRepositoryProvider);
    final user = await repository.getProfile();
    ref.read(profileUserProvider.notifier).state = user;
  }

  Future<void> _loadStats() async {
    final getStats = ref.read(getUserStatsUseCaseProvider);
    final stats = await getStats();

    userStats = UserStats(
      activities: stats.activities,
      distance: stats.distance,
      averageSpeed: stats.averageSpeed,
    );
  }

  Future<void> _loadRanking() async {
    final getTopUsers = ref.read(getTopUserUseCaseProvider);
    final topUsers = await getTopUsers();

    ranking = topUsers
        .map(
          (u) => TopUser(
        firstName: u.username,
        totalDistance: u.totalDistance, id: 0, lastName: '',
      ),
    )
        .toList();
  }

  void changeSection(ProfileSection section) {
    state = section;
  }
}
