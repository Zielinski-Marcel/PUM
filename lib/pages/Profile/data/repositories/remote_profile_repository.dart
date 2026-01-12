import 'package:flutter/material.dart';

import '../../../../models/user_model.dart';
import '../../domain/repositories/profile_repository.dart';
import '../data_sources/profile_data_source.dart';


class RemoteProfileRepository implements ProfileRepository {
  final ProfileDataSource dataSource;

  RemoteProfileRepository(this.dataSource);

  @override
  Future<void> updateProfile({
    required BuildContext context,
    String? firstName,
    String? lastName,
    String? birthDate,
    String? gender,
    int? height,
    int? weight,
  }) =>
      dataSource.updateProfile(
        context: context,
        firstName: firstName,
        lastName: lastName,
        birthDate: birthDate,
        gender: gender,
        height: height,
        weight: weight,
      );

  @override
  Future<User> getProfile() => dataSource.getProfile();

  @override
  Future<void> deleteUserRequest() => dataSource.deleteUserRequest();
}

