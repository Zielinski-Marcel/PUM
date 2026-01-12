import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ProfileSection { stats, ranking }

class UserStats {
  final int workouts;
  final double totalDistance; // w km
  final double averageSpeed; // w km/h

  UserStats({
    required this.workouts,
    required this.totalDistance,
    required this.averageSpeed,
  });
}

class RankingEntry {
  final String username;
  final double distance; // km

  RankingEntry({required this.username, required this.distance});
}

class YourProfileController extends StateNotifier<ProfileSection> {
  YourProfileController() : super(ProfileSection.stats);

  // Dane statystyk
  UserStats userStats = UserStats(workouts: 42, totalDistance: 315, averageSpeed: 9.4);

  // Ranking
  List<RankingEntry> ranking = [
    RankingEntry(username: 'Użytkownik 1', distance: 52),
    RankingEntry(username: 'Użytkownik 2', distance: 48),
    RankingEntry(username: 'Użytkownik 3', distance: 44),
  ];

  void changeSection(ProfileSection section) {
    state = section;
  }

  // Funkcja do aktualizacji statystyk (np. z API)
  void updateStats(UserStats stats) {
    userStats = stats;
  }

  // Funkcja do aktualizacji rankingu (np. z API)
  void updateRanking(List<RankingEntry> newRanking) {
    ranking = newRanking;
  }
}

// Provider
final yourProfileControllerProvider = StateNotifierProvider<YourProfileController, ProfileSection>(
      (ref) => YourProfileController(),
);
