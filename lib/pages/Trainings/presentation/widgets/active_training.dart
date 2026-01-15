import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../l10n/app_localizations.dart';
import '../providers/active_training_controller_provider.dart';

class TrainingButtons extends ConsumerWidget {
  const TrainingButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(activeTrainingControllerProvider);
    final t = AppLocalizations.of(context)!;


    return Column(
      children: [
        ElevatedButton(
          onPressed: controller.isRecording
              ? () async {
            await showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) {
                final nameController = TextEditingController();
                final noteController = TextEditingController();
                String selectedType = 'run';
                Timer? timer;  // Declare outside StatefulBuilder
                bool timerStarted = false;  // Flag to prevent recreation

                return Padding(
                  padding: MediaQuery.of(context).viewInsets,
                  child: StatefulBuilder(
                    builder: (context, setState) {
                      if (!timerStarted) {
                        timerStarted = true;
                        timer = Timer.periodic(const Duration(seconds: 1), (_) {
                          setState(() {});
                        });
                      }

                      return Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              t.endTraining,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 12),
                            TextField(
                              controller: nameController,
                              decoration: InputDecoration(
                                labelText: t.trainingName,
                              ),
                            ),
                            const SizedBox(height: 8),
                            DropdownButtonFormField<String>(
                              value: selectedType,
                              items: [
                                DropdownMenuItem(value: 'run', child: Text(t.run)),
                                DropdownMenuItem(value: 'bike', child: Text(t.bike)),
                                DropdownMenuItem(value: 'walk', child: Text(t.walk)),
                              ],
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() {
                                    selectedType = value;
                                  });
                                }
                              },
                              decoration: InputDecoration(
                                labelText: t.trainingType,
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              controller: noteController,
                              decoration: InputDecoration(
                                labelText: t.note,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                                "${t.duration}: ${_formatDuration(Duration(seconds: controller.elapsedSeconds))}"),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    timer?.cancel();
                                    Navigator.pop(context);
                                  },
                                  child: Text(t.cancel),
                                ),
                                const SizedBox(width: 8),
                                ElevatedButton(
                                  onPressed: () async {
                                    timer?.cancel();
                                    final success = await controller.finishTraining(
                                      name: nameController.text.isEmpty
                                          ? t.training
                                          : nameController.text,
                                      type: selectedType,
                                      note: noteController.text.isEmpty
                                          ? null
                                          : noteController.text,
                                    );
                                    Navigator.pop(context);
                                    if (success) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(t.trainingSentSuccess),
                                        backgroundColor: Colors.green,
                                      ));
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(controller.updateError ??
                                            t.trainingSendError),
                                        backgroundColor: Colors.red,
                                      ));
                                    }
                                  },
                                  child: Text(t.endTraining),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
              : () {
            controller.startTraining();
          },
          child: Text(controller.isRecording ? t.endTraining : t.startTraining),
        ),
        const SizedBox(height: 16),
        Text("${t.distance}: ${controller.currentRoute.length}"),
      ],
    );
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    final hours = duration.inHours.toString().padLeft(2, '0');
    return hours != '00' ? "$hours:$minutes:$seconds" : "$minutes:$seconds";
  }
}