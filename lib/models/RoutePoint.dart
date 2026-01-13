import 'package:latlong2/latlong.dart';

class RoutePoint {
  final double lat;
  final double lng;
  final DateTime? timestamp;

  RoutePoint({required this.lat, required this.lng, this.timestamp});


  LatLng toLatLng() {
    return LatLng(lat, lng);
  }

  factory RoutePoint.fromJson(Map<String, dynamic> json) {
    return RoutePoint(
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      timestamp: json['timestamp'] != null
          ? DateTime.tryParse(json['timestamp'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lng': lng,
      'timestamp': timestamp?.toIso8601String(),
    };
  }
}
