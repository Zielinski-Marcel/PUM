import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../shared/text_tile.dart';
import '../../controllers/your_profile_controller.dart';

class RankingWidget extends ConsumerWidget {
  const RankingWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(yourProfileControllerProvider.notifier);
    final ranking = controller.ranking;

    return Column(
      key: const ValueKey('ranking'),
      children: ranking.asMap().entries.map((entry) {
        final index = entry.key;
        final user = entry.value;

        return TextTile(
          leading: CircleAvatar( radius: 10,
            child: Text('${index + 1}'),
          ),
          label: user.username,
          value: null,
        );
      }).toList(),
    );
  }
}
