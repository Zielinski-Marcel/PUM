
class User {
  final int id;
  final String? firstName;
  final String? lastName;
  final String? gender;
  final int? height;
  final int? weight;
  final String? birthDate;
  final String email;
  final DateTime? emailVerifiedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  @override
  final String? avatarUrl;


  User({
    required this.id,
    this.firstName,
    this.lastName,
    this.gender,
    this.height,
    this.weight,
    this.birthDate,
    required this.email,
    this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
    this.avatarUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      gender: json['gender'],
      height: json['height'],
      weight: json['weight'],
      avatarUrl: json['avatar'],
      email: json['email'],
      birthDate: json['birth_date'],
      emailVerifiedAt: json['email_verified_at'] != null
          ? DateTime.tryParse(json['email_verified_at'])
          : null,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'gender': gender,
      'height': height,
      "weight": weight,
      "birth_date": birthDate,
      'avatar': avatarUrl,
      'email': email,
      'email_verified_at': emailVerifiedAt?.toIso8601String(),
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
