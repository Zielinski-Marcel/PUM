import 'package:flutter/material.dart';
import '../../../../models/RoutePoint.dart';
import '../../../../models/training_model.dart';
import '../../domain/providers/create_training_usecase_provider.dart';
import '../../domain/providers/get_training_usecase_provider.dart';
import '../../domain/providers/get_trainings_usecase_provider.dart';
import '../../domain/providers/update_training_usecase_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/training_controller.dart';

final trainingControllerProvider =
ChangeNotifierProvider((ref) => TrainingController(
  updateTrainingUseCase: ref.read(updateTrainingUseCaseProvider),
  getTrainingsUseCase: ref.read(getTrainingsUseCaseProvider),
  getTrainingUseCase: ref.read(getTrainingUseCaseProvider),
  createTrainingUseCase: ref.read(createTrainingUseCaseProvider),
));

class FakeTrainingButton extends ConsumerWidget {
  const FakeTrainingButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(trainingControllerProvider);

    return ElevatedButton(
      onPressed: () async {
        final route = [
          RoutePoint(lat: 52.2297, lng: 21.0122, timestamp: DateTime.now()),
          RoutePoint(lat: 52.2305, lng: 21.0140, timestamp: DateTime.now().add(const Duration(minutes: 1))),
        ];

        final training = Training(
          id: 0,
          name: "Sztuczny Bieg",
          type: "run",
          note: "To jest testowy trening",
          distance: 1000,
          time: 180,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          route: route,
          photoUrl: null,
        );

        // Wysyłamy trening na backend
        await controller.createTraining(training);

        // Informacja w konsoli
        print("Trening wysłany!");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Trening wysłany na serwer!")),
        );
      },
      child: const Text("Wyślij sztuczny trening"),
    );
  }
}
