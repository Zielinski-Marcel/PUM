import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../l10n/app_localizations.dart';
import '../../../../../shared/text_tile.dart';
import '../../providers/profile_controller_provider.dart';

class RankingWidget extends ConsumerWidget {
  const RankingWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(profileControllerProvider);

    if (controller.topUsersLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final ranking = controller.topUsers;
    if (ranking.isEmpty) {
      return Center(child: Text(AppLocalizations.of(context)!.error));
    }

    return Column(
      key: const ValueKey('ranking'),
      children: ranking.asMap().entries.map((entry) {
        final index = entry.key;
        final user = entry.value;

        return TextTile(
          leading: CircleAvatar(
            radius: 10,
            child: Text('${index + 1}', style: const TextStyle(fontSize: 12)),
          ),
          label: '${user.firstName} ${user.lastName}',
          value: Text('${user.totalDistance} km',
              style: const TextStyle(fontWeight: FontWeight.bold)),
        );
      }).toList(),
    );
  }
}

