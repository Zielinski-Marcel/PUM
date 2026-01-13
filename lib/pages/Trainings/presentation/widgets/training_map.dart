import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import '../../../../models/training_model.dart';

class TrainingMap extends StatelessWidget {
  final Training training;

  const TrainingMap({
    super.key,
    required this.training,
  });

  @override
  Widget build(BuildContext context) {
    final route = training.route;

    if (route == null || route.length < 2) {
      return const SizedBox.shrink();
    }

    return Container(
      height: 260,
      margin: const EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.hardEdge,
      child: FlutterMap(
        options: MapOptions(
          initialCenter: route.first,
          initialZoom: 15,
        ),
        children: [
          TileLayer(
            urlTemplate:
            'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: const ['a', 'b', 'c'],
          ),
          PolylineLayer(
            polylines: [
              Polyline(
                points: route,
                strokeWidth: 4,
                color: Colors.blue,
              ),
            ],
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: route.first,
                width: 40,
                height: 40,
                child: const Icon(Icons.play_arrow, color: Colors.green),
              ),
              Marker(
                point: route.last,
                width: 40,
                height: 40,
                child: const Icon(Icons.flag, color: Colors.red),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
