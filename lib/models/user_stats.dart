class UserStats {
  final int activities;
  final int distance;
  final double averageSpeed;

  UserStats({
    required this.activities,
    required this.distance,
    required this.averageSpeed,
  });

  factory UserStats.fromJson(Map<String, dynamic> json) {
    return UserStats(
      activities: json['activities'],
      distance: json['distance'],
      averageSpeed: json['average_speed'],
    );
  }
}
