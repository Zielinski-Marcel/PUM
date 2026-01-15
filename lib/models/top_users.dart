class TopUser {
  final int id;
  final String firstName;
  final String lastName;
  final int totalDistance;

  TopUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.totalDistance,
  });

  factory TopUser.fromJson(Map<String, dynamic> json) {
    return TopUser(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      totalDistance: json['total_distance'],
    );
  }

  String get username => '$firstName $lastName';
}
