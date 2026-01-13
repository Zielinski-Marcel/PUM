import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled/pages/Trainings/presentation/widgets/training_map.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../../../shared/text_tile.dart';
import '../../../../models/training_model.dart';

class TrainingDetails extends ConsumerWidget {
  final Training training;

  const TrainingDetails({super.key, required this.training});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context)!;

    double? averageSpeed;
    String? paceStr;
    String? timeStr;

    if ( training.time > 0) {
      final minutes = training.time ~/ 60;
      final seconds = training.time % 60;
      timeStr = '$minutes:${seconds.toString().padLeft(2, '0')} min';
    }

    if (training.distance != null  && training.time > 0) {
      averageSpeed = (training.distance! / 1000) / (training.time / 3600);
      final paceSeconds = training.time / (training.distance! / 1000);
      final paceMinutes = paceSeconds ~/ 60;
      final paceRemSeconds = (paceSeconds % 60).round();
      paceStr = '$paceMinutes:${paceRemSeconds.toString().padLeft(2, '0')} min/km';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TrainingMap(training: training),
        TextTile(
          label: t.time,
          value: Text(
            timeStr ?? '-',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        TextTile(
          label: t.distance,
          value: Text(
            training.distance != null ? '${training.distance! / 1000} km' : '-',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        TextTile(
          label: t.averageSpeed,
          value: Text(
            averageSpeed != null ? '${averageSpeed.toStringAsFixed(1)} km/h' : '-',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        TextTile(
          label: t.pace,
          value: Text(
            paceStr ?? '-',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 16),

        if (training.note != null && training.note!.trim().isNotEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.note,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  training.note!,
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
