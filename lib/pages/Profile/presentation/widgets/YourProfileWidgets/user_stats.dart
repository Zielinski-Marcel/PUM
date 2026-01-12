import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../l10n/app_localizations.dart';
import '../../../../../shared/text_tile.dart';
import '../../controllers/your_profile_controller.dart';


class UserStatsWidget extends ConsumerWidget {
  const UserStatsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(yourProfileControllerProvider.notifier);
    final stats = controller.userStats;

    return Column(
      key: const ValueKey('stats'),
      children: [
        TextTile(label: AppLocalizations.of(context)!.totalTrainings, value: null),
        TextTile(label: AppLocalizations.of(context)!.totalDistance, value: null),
        TextTile(label: AppLocalizations.of(context)!.averageSpeed, value: null),
      ],
    );
  }
}

