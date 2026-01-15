import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../l10n/app_localizations.dart';
import '../../../../../shared/text_tile.dart';
import '../../providers/profile_controller_provider.dart';

class UserStatsWidget extends ConsumerWidget {
  const UserStatsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(profileControllerProvider);


    if (controller.statsLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final stats = controller.userStats;
    final t = AppLocalizations.of(context)!;

    if (stats == null) {
      return Center(child: Text(t.error));
    }

    return Column(
      key: const ValueKey('stats'),
      children: [
        TextTile(label: t.totalTrainings, value: Text('${stats.activities}', style: const TextStyle(fontWeight: FontWeight.bold))),
        TextTile(label: t.totalDistance, value: Text('${stats.distance} km', style: const TextStyle(fontWeight: FontWeight.bold))),
        TextTile(label: t.averageSpeed, value: Text('${stats.averageSpeed.toStringAsFixed(1)} km/h', style: const TextStyle(fontWeight: FontWeight.bold))),      ],
    );
  }
}
