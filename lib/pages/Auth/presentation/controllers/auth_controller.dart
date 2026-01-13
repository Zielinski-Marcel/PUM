import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../exceptions/auth_exception.dart';
import '../../../../exceptions/http_exception.dart';
import '../../../../exceptions/no_internet_exception.dart';
import '../../../../exceptions/unauthorized_exception.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../models/user_model.dart';
import '../../../Profile/presentation/pages/home_page.dart';
import '../../domain/providers/forgot_password_usecase_provider.dart';
import '../../domain/providers/login_usecase_provider.dart';
import '../../domain/providers/logout_usecase_provider.dart';
import '../../domain/providers/register_usecase_provider.dart';
import '../../domain/usecases/forgot_password_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
import '../pages/login_page.dart';

class AuthController extends AsyncNotifier<User?> {
  late final RegisterUseCase _registerUseCase = ref.read(
    registerUseCaseProvider,
  );
  late final LoginUseCase _loginUseCase = ref.read(loginUseCaseProvider);
  late final LogoutUseCase _logoutUseCase = ref.read(logoutUseCaseProvider);
  late final ForgotPasswordUseCase _forgotPasswordUseCase = ref.read(
    forgotPasswordUseCaseProvider,
  );

  @override
  Future<User?> build() async {
    return _loadUser();
  }

  Future<void> login(
      BuildContext context,
      String email,
      String password,
      ) async {
    final localizations = AppLocalizations.of(context)!;
    final navigator = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);

    state = const AsyncLoading();

    try {
      await _loginUseCase(email, password);
      final user = await _loadUser();
      state = AsyncData(user);

      if (context.mounted) {
        Navigator.push( context, MaterialPageRoute(builder: (context) => const HomePage()), );
        messenger.showSnackBar(
          SnackBar(content: Text(localizations.loginButton)),
        );
      }
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
      if (context.mounted) {
        _showError(context, _resolveErrorMessage(e, localizations));
      }
    }
  }

  Future<void> register(
      BuildContext context,
      String email,
      String password,
      String confirmPassword,
      ) async {
    final localizations = AppLocalizations.of(context)!;

    state = const AsyncLoading();

    try {
      await _registerUseCase(
        email,
        password,
        confirmPassword,
      );
      state = AsyncData(await build());

      if (context.mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const LoginPage()),
              (route) => false,
        );
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(localizations.loginButton)));
      }
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
      if (context.mounted) {
        _showError(context, _resolveErrorMessage(e, localizations));
      }
    }
  }

  Future<void> logout(BuildContext context) async {
    final localizations = AppLocalizations.of(context)!;
    final navigator = Navigator.of(context);

    state = const AsyncLoading();

    try {
      await _logoutUseCase();
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');
      await prefs.remove('user');

      state = const AsyncData(null);

      if (context.mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const LoginPage()),
              (route) => false,
        );
      }
    } on Exception {
      if (!context.mounted) return;
      await _handleUnauthorized(context);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
      if (context.mounted) {
        _showError(context, _resolveErrorMessage(e, localizations));
      }
    }
  }

  Future<void> forgotPassword(BuildContext context, String email) async {
    final localizations = AppLocalizations.of(context)!;
    final messenger = ScaffoldMessenger.of(context);

    state = const AsyncLoading();

    try {
      await _forgotPasswordUseCase(email);
      state = AsyncData(await build());

      if (context.mounted) {
        messenger.showSnackBar(
          SnackBar(content: Text(localizations.loginButton)),
        );
      }
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
      if (context.mounted) {
        _showError(context, _resolveErrorMessage(e, localizations));
      }
    }
  }

  Future<User?> _loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('user');
    if (jsonString == null) return null;
    return User.fromJson(jsonDecode(jsonString));
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  String _resolveErrorMessage(Object e, AppLocalizations localizations) {
    if (e is HttpException) return e.message;
    if (e is AuthException) return e.message;
    if (e is NoInternetException) return e.message;
    if (e is UnauthorizedException) return e.message;
    return 'error';
  }

  Future<void> _handleUnauthorized(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    state = const AsyncData(null);

    if (!context.mounted) return;

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginPage()),
          (route) => false,
    );
  }


}
