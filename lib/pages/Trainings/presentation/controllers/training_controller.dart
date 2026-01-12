import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../exceptions/http_exception.dart';
import '../../../../exceptions/no_internet_exception.dart';
import '../../../../exceptions/unauthorized_exception.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../models/training_model.dart';
import '../../../../models/user_model.dart';
import '../../domain/usecases/get_training_usecase.dart';
import '../../domain/usecases/update_training_usecase.dart';

class TrainingController extends ChangeNotifier {
  final UpdateTrainingUseCase updateTrainingUseCase;
  final GetTrainingUseCase getTrainingUseCase;

  TrainingController({
    required this.updateTrainingUseCase,
    required this.getTrainingUseCase,
  });

  final List<Training> _trainings = [];

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isEditing = false;
  bool get isEditing => _isEditing;

  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  void toggleEdit() {
    _isEditing = !_isEditing;
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
  Future<void> loadTrainings({bool refresh = false}) async {

  }

}
