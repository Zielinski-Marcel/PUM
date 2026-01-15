import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../exceptions/unauthorized_exception.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../models/user_model.dart';
import '../../../../models/top_users.dart';
import '../../../../models/user_stats.dart';

import '../../../Auth/presentation/pages/login_page.dart';
import '../../domain/usecases/delete_user_request_usecase.dart';
import '../../domain/usecases/get_profile_usecase.dart';
import '../../domain/usecases/update_profile_usecase.dart';
import '../../domain/usecases/get_top_users_usecase.dart';
import '../../domain/usecases/get_user_stats_usecase.dart';

import '../Providers/profile_user_provider.dart';

class ProfileController extends ChangeNotifier {
  final Ref ref;
  final UpdateProfileUseCase updateProfileUseCase;
  final GetProfileUseCase getProfileUseCase;
  final DeleteUserRequestUseCase deleteUserRequestUseCase;
  final GetTopUsersUseCase getTopUsersUseCase;
  final GetUserStatsUseCase getUserStatsUseCase;

  ProfileController(
      this.ref,
      this.updateProfileUseCase,
      this.getProfileUseCase,
      this.deleteUserRequestUseCase,
      this.getTopUsersUseCase,
      this.getUserStatsUseCase,
      ) {
    fetchUserProfile();
    fetchUserStats();
    fetchTopUsers();
  }


  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isEditing = false;
  bool get isEditing => _isEditing;

  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  User? get user => ref.read(profileUserProvider);


  UserStats? _userStats;
  UserStats? get userStats => _userStats;

  bool _statsLoading = false;
  bool get statsLoading => _statsLoading;



  List<TopUser> _topUsers = [];
  List<TopUser> get topUsers => _topUsers;

  bool _topUsersLoading = false;
  bool get topUsersLoading => _topUsersLoading;


  Future<void> fetchUserProfile({BuildContext? context}) async {
    final prefs = await SharedPreferences.getInstance();

    try {
      final userJson = prefs.getString('user');
      if (userJson != null) {
        ref.read(profileUserProvider.notifier).state =
            User.fromJson(jsonDecode(userJson));
      }

      final fetchedUser = await getProfileUseCase();
      ref.read(profileUserProvider.notifier).state = fetchedUser;

      await prefs.setString(
        'user',
        jsonEncode(fetchedUser.toJson()),
      );
    } on UnauthorizedException {
      if (context != null && context.mounted) {
        await _handleUnauthorized(context);
      }
    } catch (_) {
      if (context != null && context.mounted) {
        final localizations = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(localizations.error)),
        );
      }
    } finally {
      _isInitialized = true;
      notifyListeners();
    }
  }

  Future<void> fetchUserStats({BuildContext? context}) async {
    _statsLoading = true;
    notifyListeners();

    try {
      final stats = await getUserStatsUseCase();
      _userStats = stats;
    } on UnauthorizedException {
      if (context != null && context.mounted) {
        await _handleUnauthorized(context);
      }
    } catch (e) {
      _userStats = null;
      debugPrint('Error fetching user stats: $e');
      if (context != null && context.mounted) {
        final localizations = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(localizations.error)),
        );
      }
    } finally {
      _statsLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchTopUsers({BuildContext? context}) async {
    _topUsersLoading = true;
    notifyListeners();

    try {

      final top = await getTopUsersUseCase();
      _topUsers = top;
    } on UnauthorizedException {
      if (context != null && context.mounted) {
        await _handleUnauthorized(context);
      }
    } catch (e) {
      _topUsers = [];
      debugPrint('Error fetching top users: $e');
      if (context != null && context.mounted) {
        final localizations = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(localizations.error)),
        );
      }
    } finally {
      _topUsersLoading = false;
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
    int? weight,
  }) async {
    try {
      await updateProfileUseCase(
        context: context,
        firstName: firstName?.trim(),
        lastName: lastName?.trim().isNotEmpty == true ? lastName!.trim() : null,
        birthDate: birthDate?.isNotEmpty == true ? birthDate : null,
        gender: gender?.isNotEmpty == true ? gender : null,
        height: height,
        weight: weight,
      );

      await fetchUserProfile();

      final updatedUser = ref.read(profileUserProvider);
      if (updatedUser != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(
          'user',
          jsonEncode(updatedUser.toJson()),
        );
      }

      if (!context.mounted) return;
      final localizations = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(localizations.profileUpdateSuccess)),
      );

      toggleEdit();
    } catch (_) {
      if (!context.mounted) return;
      final localizations = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(localizations.error)),
      );
    }
  }

  Future<void> refreshData({BuildContext? context}) async {
    await Future.wait([
      fetchUserProfile(context: context),
      fetchUserStats(context: context),
      fetchTopUsers(context: context),
    ]);
  }

  Future<void> deleteUser({required BuildContext context}) async {
    _setLoading(true);
    try {
      await deleteUserRequestUseCase();

      if (!context.mounted) return;
      final localizations = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(localizations.profileDeleteRequestSuccess)),
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
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginPage()),
          (route) => false,
    );
  }
}