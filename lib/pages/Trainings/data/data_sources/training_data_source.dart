import 'package:flutter/material.dart';
import 'package:untitled/network/http_client.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../models/training_model.dart';


class TrainingDataSource {
  final HttpClient httpClient;

  TrainingDataSource(this.httpClient);

  Future<void> createTraining(Training training) async {
    final body = training.toJson();
    await httpClient.post('/api/trainings', body: body);
  }

  Future<Training> getTraining(int id) async {
    final response = await httpClient.get('/api/trainings/$id');
    return Training.fromJson(response['data'] as Map<String, dynamic>);
  }

  Future<List<Training>> getTrainings({int page = 1}) async {
    final response = await httpClient.get('/api/trainings?page=$page');
    final List<dynamic> trainingsJson = response['data'];
    return trainingsJson
        .map((json) => Training.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<void> updateTraining({
    required BuildContext context,
    String? name,
    String? type,
    String? note,
  }) async {
    final localizations = AppLocalizations.of(context)!;

    final body = <String, dynamic>{};
    if (name != null) {
      body['name'] = name;
    }
    if (type != null) {
      body['type'] = type;
    }

    if (note != null) {
      body['note'] = note;
    }

    if (body.isEmpty) {
      throw Exception(localizations.error);
    }

    await httpClient.put('/api/trainings', body: body);
  }
}
