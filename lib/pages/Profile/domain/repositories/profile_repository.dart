import 'package:flutter/material.dart';

import '../../../../models/user_model.dart';

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
  Future<void> deleteUserRequest();
}
