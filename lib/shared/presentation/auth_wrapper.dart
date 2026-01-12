import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/user_model.dart';
import '../../pages/Auth/presentation/pages/login_page.dart';
import '../../pages/Profile/presentation/Providers/profile_user_provider.dart';
import '../../pages/Profile/presentation/pages/home_page.dart';


class AuthWrapper extends ConsumerWidget {
  final User? user;
  const AuthWrapper({super.key, this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(profileUserProvider);
    if (user == null) {
      return const LoginPage();
    } else {
      return const HomePage();
    }
  }
}
