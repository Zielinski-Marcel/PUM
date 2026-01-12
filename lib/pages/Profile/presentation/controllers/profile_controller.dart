import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../exceptions/http_exception.dart';
import '../../../../exceptions/no_internet_exception.dart';
import '../../../../exceptions/unauthorized_exception.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../models/user_model.dart';
import '../../domain/usecases/delete_user_request_usecase.dart';
import '../../domain/usecases/get_profile_usecase.dart';
import '../../domain/usecases/update_profile_usecase.dart';
import '../Providers/profile_user_provider.dart';

class ProfileController extends ChangeNotifier {
  final Ref ref;
  final UpdateProfileUseCase updateProfileUseCase;
  final GetProfileUseCase getProfileUseCase;
  final DeleteUserRequestUseCase deleteUserRequestUseCase;

  ProfileController(
      this.ref,
      this.updateProfileUseCase,
      this.getProfileUseCase,
      this.deleteUserRequestUseCase,
      );

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isEditing = false;
  bool get isEditing => _isEditing;

  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  User? get user => ref.read(profileUserProvider);

  Future<void> fetchUserProfile({BuildContext? context}) async {
    final prefs = await SharedPreferences.getInstance();

    try {
      final userJson = prefs.getString('user');
      if (userJson != null) {
        final user = User.fromJson(jsonDecode(userJson));
        ref.read(profileUserProvider.notifier).state = user;
      }

      final fetchUser = await getProfileUseCase();
      ref.read(profileUserProvider.notifier).state = fetchUser;
      await prefs.setString('user', jsonEncode(fetchUser.toJson()));
    } on UnauthorizedException {
      if (context != null && context.mounted) {
        await _handleUnauthorized(context);
      }
    } catch (_) {
      if (context != null && context.mounted) {
        final messenger = ScaffoldMessenger.of(context);
        final localizations = AppLocalizations.of(context)!;
        messenger.showSnackBar(
          SnackBar(content: Text(localizations.error)),
        );
      }
    } finally {
      _isInitialized = true;
      notifyListeners();
    }
  }

  void toggleEdit() {
    _isEditing = !_isEditing;
    notifyListeners();
  }

  Future<void> updateProfile({
    required BuildContext context,
    String? firstName,
    String? lastName,
    String? birthDate,
    String? gender,
    int? height,
    int? weight
  }) async {
    try {
      await updateProfileUseCase(
        context: context,
        firstName: firstName?.trim(),
        lastName: (lastName != null && lastName.trim().isNotEmpty)
            ? lastName.trim()
            : null,
        birthDate: (birthDate != null && birthDate.isNotEmpty)
            ? birthDate
            : null,
        gender: (gender != null && gender.isNotEmpty)
            ? gender
            : null,
        height: height,
        weight: weight,
      );


      await fetchUserProfile();

      final updatedUser = ref.read(profileUserProvider);
      if (updatedUser != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user', jsonEncode(updatedUser.toJson()));
      }

      if (!context.mounted) return;

      final localizations = AppLocalizations.of(context)!;
      final messenger = ScaffoldMessenger.of(context);

      messenger.showSnackBar(
        SnackBar(content: Text(localizations.profileUpdateSuccess)),
      );

      toggleEdit();
    } on UnauthorizedException {
      if (!context.mounted) return;
      await _handleUnauthorized(context);
    } on HttpException catch (e) {
      if (!context.mounted) return;
      final messenger = ScaffoldMessenger.of(context);
      messenger.showSnackBar(SnackBar(content: Text(e.message)));
    } on NoInternetException {
      if (!context.mounted) return;
      final localizations = AppLocalizations.of(context)!;
      final messenger = ScaffoldMessenger.of(context);
      messenger.showSnackBar(
        SnackBar(content: Text(localizations.noInternetError)),
      );
    }  catch (_) {
      if (!context.mounted) return;
      final localizations = AppLocalizations.of(context)!;
      final messenger = ScaffoldMessenger.of(context);
      messenger.showSnackBar(
        SnackBar(content: Text(localizations.error)),
      );
    }
  }

  Future<void> deleteUser({required BuildContext context}) async {
    _setLoading(true);

    try {
      await deleteUserRequestUseCase();

      if (!context.mounted) return;
      final localizations = AppLocalizations.of(context)!;
      final messenger = ScaffoldMessenger.of(context);
      messenger.showSnackBar(
        SnackBar(content: Text(localizations.profileDeleteRequestSuccess)),
      );
    } on UnauthorizedException {
      if (!context.mounted) return;
      await _handleUnauthorized(context);
    } on NoInternetException {
      if (!context.mounted) return;
      final localizations = AppLocalizations.of(context)!;
      final messenger = ScaffoldMessenger.of(context);
      messenger.showSnackBar(
        SnackBar(content: Text(localizations.noInternetError)),
      );
    } on HttpException catch (e) {
      if (!context.mounted) return;
      final messenger = ScaffoldMessenger.of(context);
      messenger.showSnackBar(SnackBar(content: Text(e.message)));
    } catch (_) {
      if (!context.mounted) return;
      final localizations = AppLocalizations.of(context)!;
      final messenger = ScaffoldMessenger.of(context);
      messenger.showSnackBar(
        SnackBar(content: Text(localizations.error)),
      );
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> _handleUnauthorized(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    ref.read(profileUserProvider.notifier).state = null;
    if (!context.mounted) return;

    Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
  }
}
