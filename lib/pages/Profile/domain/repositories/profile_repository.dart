import 'package:flutter/material.dart';

import '../../../../models/top_users.dart';
import '../../../../models/user_model.dart';
import '../../../../models/user_stats.dart';

abstract class ProfileRepository {
  Future<void> updateProfile({
    required BuildContext context,
    String? firstName,
    String? lastName,
    String? birthDate,
    String? gender,
    int? height,
    int? weight,
  });

  Future<User> getProfile();
  Future<UserStats> getStats();
  Future<List<TopUser>> getTopUsers();
  Future<void> deleteUserRequest();
}
