import 'dart:async';

import 'package:flutter/material.dart';
import 'package:untitled/pages/Trainings/domain/usecases/create_training_usecase.dart';
import '../../../../exceptions/http_exception.dart';
import '../../../../exceptions/no_internet_exception.dart';
import '../../../../exceptions/unauthorized_exception.dart';
import '../../../../models/RoutePoint.dart';
import '../../../../models/training_model.dart';
import '../../domain/usecases/get_training_usecase.dart';
import '../../domain/usecases/get_trainings_usecase.dart';
import '../../domain/usecases/update_training_usecase.dart';

class TrainingController extends ChangeNotifier {
  final UpdateTrainingUseCase updateTrainingUseCase;
  final GetTrainingsUseCase getTrainingsUseCase;
  final GetTrainingUseCase getTrainingUseCase;
  final CreateTrainingUseCase createTrainingUseCase;

  TrainingController({
    required this.updateTrainingUseCase,
    required this.getTrainingsUseCase,
    required this.getTrainingUseCase,
    required this.createTrainingUseCase,
  });

  final List<Training> _trainings = [];
  final Set<int> _shownTrainingIds = {};
  List<RoutePoint> _currentRoute = [];
  List<RoutePoint> get currentRoute => _currentRoute;

  bool _isRecording = false;
  bool get isRecording => _isRecording;

  void startRecording() {
    _currentRoute = [];
    _isRecording = true;
    notifyListeners();
  }

  void stopRecording() {
    _isRecording = false;
    notifyListeners();
  }

  void addRoutePoint(RoutePoint point) {
    if (_isRecording) {
      _currentRoute.add(point);
      notifyListeners();
    }
  }


  int _currentPage = 1;
  final int _limit = 10;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isEditing = false;
  bool get isEditing => _isEditing;

  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  Training? _selectedTraining;
  Training? get selectedTraining => _selectedTraining;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _isUpdating = false;
  bool get isUpdating => _isUpdating;

  String? _updateError;
  String? get updateError => _updateError;

  bool _hasMore = true;
  bool get hasMore => _hasMore;

  Timer? _debounceTimer;

  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  List<Training> get trainings => _trainings;

  List<Training> get filteredTrainings {
    if (_trainings.isEmpty) return [];

    if (_searchQuery.isEmpty) {
      return _trainings.toList();
    }

    final lowerQuery = _searchQuery.toLowerCase();

    return _trainings.where((t) {
      final words = (t.name ?? '').toLowerCase().split(RegExp(r'\s+'));
      return words.any((word) => word.startsWith(lowerQuery));
    }).toList();
  }

  void toggleEdit() {
    _isEditing = !_isEditing;
    notifyListeners();
  }

  Future<void> loadTrainings({bool refresh = false}) async {
    if (_isLoading) return;

    if (refresh) {
      _reset();
      _searchQuery = '';
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await getTrainingsUseCase(page: _currentPage);

      final newTrainings = result
          .where((t) => !_shownTrainingIds.contains(t.id))
          .toList();

      _trainings.addAll(newTrainings);
      _shownTrainingIds.addAll(newTrainings.map((t) => t.id));

      if (result.length < _limit) {
        _hasMore = false;
      } else {
        _currentPage++;
      }
    } on NoInternetException catch (e) {
      _errorMessage = e.message;
    } on HttpException catch (e) {
      _errorMessage = 'Server error: ${e.message} (code ${e.statusCode})';
    } on UnauthorizedException catch (e) {
      _errorMessage = 'Authorization error: ${e.message}';
    } catch (e) {
      _errorMessage = 'Unexpected error: $e';
    } finally {
      _isLoading = false;
      _isInitialized = true;
      notifyListeners();
    }
  }

  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void selectTraining(Training? training) {
    _selectedTraining = training;
    notifyListeners();
  }

  void _reset() {
    _trainings.clear();
    _shownTrainingIds.clear();
    _currentPage = 1;
    _hasMore = true;
  }

  Future<void> loadAllTrainings() async {
    if (_isLoading) return;

    _reset();
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      while (_hasMore) {
        final result = await getTrainingsUseCase(page: _currentPage);
        final newTrainings = result
            .where((t) => !_shownTrainingIds.contains(t.id))
            .toList();

        _trainings.addAll(newTrainings);
        _shownTrainingIds.addAll(newTrainings.map((t) => t.id));

        if (result.length < _limit) {
          _hasMore = false;
        } else {
          _currentPage++;
        }
      }
    } catch (e) {
      _errorMessage = '$e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createTraining(Training training) async {
    _isUpdating = true;
    _updateError = null;
    notifyListeners();

    try {
      await createTrainingUseCase.call(training);
      await loadTrainings(refresh: true);
    } catch (e) {
      _updateError = 'Error creating training: $e';
    } finally {
      _isUpdating = false;
      notifyListeners();
    }
  }

  Future<void> finishTraining({
    required String name,
    required String type,
    String? note,
  }) async {
    final training = Training(
      id: 0,
      name: name,
      type: type,
      note: note,
      distance: null,
      time: 0,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      route: _currentRoute,
    );

    await createTraining(training);

    _currentRoute = [];
  }



  void searchWithDebounce(
      String query, {
        Duration delay = const Duration(milliseconds: 400),
      }) {
    if (query.trim().length < 2 && query.isNotEmpty) return;

    _debounceTimer?.cancel();
    _debounceTimer = Timer(delay, () async {
      await _searchAllTrainings(query);
    });
  }

  Future<void> _searchAllTrainings(String query) async {
    _searchQuery = query;
    await loadAllTrainings();
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }
}