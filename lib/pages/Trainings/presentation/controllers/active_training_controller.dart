import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../../../../exceptions/http_exception.dart';
import '../../../../exceptions/no_internet_exception.dart';
import '../../../../exceptions/unauthorized_exception.dart';
import '../../../../models/RoutePoint.dart';
import '../../../../models/training_model.dart';
import '../../domain/usecases/create_training_usecase.dart';
import '../../domain/usecases/get_training_usecase.dart';
import '../../domain/usecases/get_trainings_usecase.dart';
import '../../domain/usecases/update_training_usecase.dart';

class ActiveTrainingController extends ChangeNotifier {
  final UpdateTrainingUseCase updateTrainingUseCase;
  final GetTrainingsUseCase getTrainingsUseCase;
  final GetTrainingUseCase getTrainingUseCase;
  final CreateTrainingUseCase createTrainingUseCase;

  ActiveTrainingController({
    required this.updateTrainingUseCase,
    required this.getTrainingsUseCase,
    required this.getTrainingUseCase,
    required this.createTrainingUseCase,
  });

  // TRAININGS
  final List<Training> _trainings = [];
  final Set<int> _shownTrainingIds = {};
  List<Training> get trainings => _trainings;

  // CURRENT ROUTE
  List<RoutePoint> _currentRoute = [];
  List<RoutePoint> get currentRoute => _currentRoute;

  // GPS STREAM
  StreamSubscription<Position>? _positionStream;

  // RECORDING STATE
  bool _isRecording = false;
  bool get isRecording => _isRecording;

  // TRAINING TIMER
  DateTime? _startTime;
  int get elapsedSeconds => _startTime == null ? 0 : DateTime.now().difference(_startTime!).inSeconds;

  // LOADING / ERROR STATE
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _isUpdating = false;
  bool get isUpdating => _isUpdating;

  String? _updateError;
  String? get updateError => _updateError;

  // SEARCH
  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  Timer? _debounceTimer;

  // PAGINATION
  int _currentPage = 1;
  final int _limit = 10;
  bool _hasMore = true;
  bool get hasMore => _hasMore;

  // ---------------- GPS / TRAINING ----------------
  // In ActiveTrainingController

  Future<bool> createTraining(Training training) async {
    _isUpdating = true;
    _updateError = null;
    notifyListeners();
    try {
      // Dodany print do debugowania: wypisuje JSON obiektu Training przed wysłaniem
      print(jsonEncode(training.toJson()));  // Lub print(training); jeśli nie ma toJson()

      await createTrainingUseCase.call(training);
      await loadTrainings(refresh: true);
      return true;  // Success
    } catch (e) {
      print('Error creating training: $e');  // Log for debugging
      _updateError = 'Error creating training: $e';
      return false;  // Failure
    } finally {
      _isUpdating = false;
      notifyListeners();
    }
  }

// Update finishTraining to propagate the success flag
  Future<bool> finishTraining({
    required String name,
    required String type,
    String? note,
  }) async {
    _isRecording = false;
    await _positionStream?.cancel();
    _positionStream = null;

    double totalDistance = 0.0;
    if (_currentRoute.length >= 2) {
      for (int i = 1; i < _currentRoute.length; i++) {
        totalDistance += Geolocator.distanceBetween(
          _currentRoute[i - 1].lat,
          _currentRoute[i - 1].lng,
          _currentRoute[i].lat,
          _currentRoute[i].lng,
        );
      }
    }

    final training = Training(
      id: 0,
      name: name,
      type: type,
      note: note,
      distance: 0,
      time: elapsedSeconds,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      route: _currentRoute,
    );

    final success = await createTraining(training);
    _currentRoute = [];
    _startTime = null;
    notifyListeners();
    return success;
  }

  Future<void> startTraining() async {
    _currentRoute = [];
    _isRecording = true;
    _startTime = DateTime.now();
    notifyListeners();

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _errorMessage = 'Location services are disabled.';
      notifyListeners();
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _errorMessage = 'Location permissions are denied';
        notifyListeners();
        return;
      }
    }

    _positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 5,
      ),
    ).listen((Position pos) {
      addRoutePoint(RoutePoint(
        lat: pos.latitude,
        lng: pos.longitude,
        timestamp: DateTime.now(),
      ));
    });
  }



  void addRoutePoint(RoutePoint point) {
    if (_isRecording) {
      _currentRoute.add(point);
      notifyListeners();
    }
  }

  // ---------------- TRAININGS FETCH / CRUD ----------------



  Future<void> loadTrainings({bool refresh = false}) async {
    if (_isLoading) return;

    if (refresh) {
      _trainings.clear();
      _shownTrainingIds.clear();
      _currentPage = 1;
      _hasMore = true;
      _searchQuery = '';
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await getTrainingsUseCase(page: _currentPage);
      final newTrainings = result.where((t) => !_shownTrainingIds.contains(t.id)).toList();
      _trainings.addAll(newTrainings);
      _shownTrainingIds.addAll(newTrainings.map((t) => t.id));

      if (result.length < _limit) _hasMore = false;
      else _currentPage++;
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
      notifyListeners();
    }
  }

  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  List<Training> get filteredTrainings {
    if (_searchQuery.isEmpty) return _trainings.toList();
    final q = _searchQuery.toLowerCase();
    return _trainings.where((t) {
      final words = (t.name ?? '').toLowerCase().split(RegExp(r'\s+'));
      return words.any((w) => w.startsWith(q));
    }).toList();
  }

  @override
  void dispose() {
    _positionStream?.cancel();
    _debounceTimer?.cancel();
    super.dispose();
  }
}