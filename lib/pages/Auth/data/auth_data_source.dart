import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/network/http_client.dart';

import '../../../models/user_model.dart';

class AuthDataSource {
  final HttpClient httpClient;

  AuthDataSource(this.httpClient);

  Future<User> login(String email, String password) async {
    final response = await httpClient.post(
      '/api/login',
      body: {'email': email, 'password': password},
    );

    final token = response['token'];
    final user = User.fromJson(response['user']);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    await prefs.setString('user', jsonEncode(user.toJson()));
    return user;
  }

  Future<void> register(
    String email,
    String password,
    String confirmPassword,
  ) async {
    await httpClient.post(
      '/api/register',
      body: {
        'email': email,
        'password': password,
        'password_confirmation': confirmPassword,
      },
    );
  }

  Future<void> logout() async {
    await httpClient.post('/api/logout');
  }

  Future<void> forgotPassword(String email) async {
    await httpClient.post('/api/forgot-password', body: {'email': email});
  }
}
