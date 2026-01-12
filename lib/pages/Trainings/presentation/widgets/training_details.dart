import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../../../shared/text_tile.dart';

class TrainingDetails extends ConsumerWidget {

  const TrainingDetails({super.key,});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextTile(label: t.time, value: Text(' ',    style: const TextStyle(fontWeight: FontWeight.bold),),),

        TextTile(label: t.distance, value: Text(' ',    style: const TextStyle(fontWeight: FontWeight.bold),),),

        TextTile(label: t.averageSpeed, value: Text(' ',    style: const TextStyle(fontWeight: FontWeight.bold),),),

        TextTile(label: t.rate, value: Text(' ',    style: const TextStyle(fontWeight: FontWeight.bold),),),
      ],
    );
  }}