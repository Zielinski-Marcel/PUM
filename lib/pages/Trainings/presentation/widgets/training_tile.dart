import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../models/training_model.dart';
import '../../../../shared/text_tile.dart';

class TrainingTile extends StatelessWidget {
  final Training training;
  final VoidCallback? onPressed;

  const TrainingTile({
    super.key,
    required this.training,
    this.onPressed,
  });

  Icon get activityTypeIcon {
    switch (training.type) {
      case 'run':
        return const Icon(Icons.directions_run, size: 32, color: Colors.blue);
      case 'bike':
        return const Icon(Icons.directions_bike, size: 32, color: Colors.blue);
      default:
        return const Icon(Icons.directions_walk, size: 32, color: Colors.blue);
    }
  }

  String get formattedDuration {
    final minutes = training.time ~/ 60;
    final seconds = training.time % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;

    return Slidable(
      key: ValueKey(training.name),
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        extentRatio: 0.2,
        children: [
          SlidableAction(
            onPressed: (_) => onPressed?.call(),
            backgroundColor: Colors.transparent,
            foregroundColor: const Color(0xFF6FC2DF),
            icon: Icons.arrow_forward_rounded,
          ),
        ],
      ),
      child: TextTile(
        leading: activityTypeIcon,
        label: training.name ?? '-',
        value: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('${text.time}: $formattedDuration min'),
            const SizedBox(height: 4),
            Text('${text.distance}: ${training.distance} m'),
          ],
        ),
      ),
    );
  }
}
