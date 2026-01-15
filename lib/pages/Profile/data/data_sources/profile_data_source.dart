import 'package:flutter/material.dart';
import 'package:untitled/network/http_client.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../models/top_users.dart';
import '../../../../models/user_model.dart';
import '../../../../models/user_stats.dart';

class ProfileDataSource {
  final HttpClient httpClient;

  ProfileDataSource(this.httpClient);

  Future<User> getProfile() async {
    final response = await httpClient.get('/api/profile');
    return User.fromJson(response['data']);
  }

  Future<UserStats> getStats() async {
    final response = await httpClient.get('/api/activities/stats');
    return UserStats.fromJson(response['overall']);
  }

  Future<List<TopUser>> getTopUsers() async {
    final response = await httpClient.get('/api/activities/top-users');
    final list = response['top_users'] as List;
    return list.map((e) => TopUser.fromJson(e)).toList();
  }

  Future<void> updateProfile({
    required BuildContext context,
    String? firstName,
    String? lastName,
    String? birthDate,
    String? gender,
    int? height,
    int? weight,
  }) async {
    final localizations = AppLocalizations.of(context)!;

    final body = <String, dynamic>{};
    if (firstName != null && firstName.isNotEmpty) {
      body['first_name'] = firstName;
    }
    if (lastName != null) {
      body['last_name'] = lastName;
    }

    if (birthDate != null && birthDate.isNotEmpty) {
      body['birth_date'] = birthDate;
    }

    if (gender != null && gender.isNotEmpty) {
      body['gender'] = gender;
    }

    if (height != null) {
      body['height'] = height;
    }

    if (weight != null) {
      body['weight'] = weight;
    }

    if (body.isEmpty) {
      throw Exception(localizations.error);
    }

    await httpClient.put('/api/profile', body: body);
  }

  Future<void> deleteUserRequest() async {
    await httpClient.post('/api/profile/delete-request');
  }
}
