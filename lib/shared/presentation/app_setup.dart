import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../pages/Auth/presentation/providers/auth_controller_provider.dart';
import '../../pages/Profile/presentation/Providers/profile_controller_provider.dart';
import '../presentation/app_initializer.dart';
import '../providers/localization_loader_provider.dart';


class AppSetup {
  static Future<ProviderScopeApp> initialize() async {
    await dotenv.load(fileName: '.env');

    final container = ProviderContainer();
    await container.read(localizationLoaderProvider.future);

    final authController = container.read(authControllerProvider.notifier);
    await authController.build();

    final profileController = container.read(profileControllerProvider.notifier,);
    await profileController.fetchUserProfile();

    return ProviderScopeApp(
      container: container,
      overrides: [],
      child: const AppInitializer(),
    );
  }
}

class ProviderScopeApp {
  final ProviderContainer container;
  final List<Override> overrides;
  final Widget child;

  ProviderScopeApp({
    required this.container,
    required this.overrides,
    required this.child,
  });
}
