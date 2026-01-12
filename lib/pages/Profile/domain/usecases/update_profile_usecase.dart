import 'package:flutter/material.dart';

import '../repositories/profile_repository.dart';


class UpdateProfileUseCase {
  final ProfileRepository repository;

  UpdateProfileUseCase(this.repository);

  Future<void> call({
    required BuildContext context,
    String? firstName,
    String? lastName,
    String? birthDate,
    String? gender,
    int? height,
    int? weight,
  }) {
    return repository.updateProfile(
      context: context,
      firstName: firstName,
      lastName: lastName,
      birthDate: birthDate,
      gender: gender,
      height: height,
      weight: weight,
    );
  }
}

