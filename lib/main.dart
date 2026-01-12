import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled/shared/presentation/app_setup.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  final app = await AppSetup.initialize();

  runApp(
    UncontrolledProviderScope(
      container: app.container,
      child: ProviderScope(overrides: app.overrides, child: app.child),
    ),
  );
}
