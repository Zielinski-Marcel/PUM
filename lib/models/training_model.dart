import 'package:latlong2/latlong.dart';

class Training {
  final int id;
  final List<LatLng>? route;
  final String? name;
  final String? type;
  final String? note;
  final int? distance;
  final int time;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? photoUrl;

  Training({
    required this.id,
    this.route,
    this.name,
    this.type,
    this.note,
    this.distance,
    required this.time,
    required this.createdAt,
    required this.updatedAt,
    this.photoUrl,
  });

  factory Training.fromJson(Map<String, dynamic> json) {
    return Training(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      note: json['note'],
      distance: json['distance'],
      time: json['time'],
      photoUrl: json['photo_url'],
      route: (json['route'] as List?)
          ?.map(
            (e) => LatLng(
          (e['lat'] as num).toDouble(),
          (e['lng'] as num).toDouble(),
        ),
      )
          .toList(),
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'note': note,
      'distance': distance,
      'time': time,
      'photo_url': photoUrl,
      'route': route
          ?.map(
            (e) => {
          'lat': e.latitude,
          'lng': e.longitude,
        },
      )
          .toList(),
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
