import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../l10n/app_localizations.dart';
import '../pages/training_details_page.dart';
import '../providers/training_controller_provider.dart';
import '../providers/training_scroll_controller_provider.dart';
import 'training_tile.dart';

class TrainingList extends ConsumerWidget {
  const TrainingList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(trainingControllerProvider);
    final notifier = ref.read(trainingControllerProvider.notifier);
    final scrollController = ref.watch(trainingScrollControllerProvider);

    if (controller.isLoading && controller.trainings.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (controller.errorMessage != null && controller.trainings.isEmpty) {
      return Center(child: Text(controller.errorMessage!));
    }

    final trainingsToShow = controller.filteredTrainings;

    return RefreshIndicator(
      onRefresh: () => notifier.loadTrainings(refresh: true),
      child: ListView.builder(
        controller: scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: trainingsToShow.length + (controller.hasMore ? 1 : 0),
        itemBuilder: (context, index) {

          if (index < trainingsToShow.length) {
            final training = trainingsToShow[index];

            return TrainingTile(
              training: training,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TrainingDetailsPage(training: training),
                  ),
                );
              },

            );
          }

          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}
