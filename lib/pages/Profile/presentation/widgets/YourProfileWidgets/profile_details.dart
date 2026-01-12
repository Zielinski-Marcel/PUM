import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../../../shared/text_tile.dart';
import '../../../../../shared/user_avatar.dart';
import '../../Providers/profile_controller_provider.dart';

class ProfileDetails extends ConsumerWidget {

  const ProfileDetails({super.key,});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context)!;
    final user = ref.watch(profileControllerProvider).user;

    if (user == null) {
      return Center(child: Text(t.error));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: Stack(
            children: [
              UserAvatar(size: 45),
            ],
          ),
        ),


        const SizedBox(height: 24),

        TextTile(label: t.firstName, value: Text('${user.firstName}',    style: const TextStyle(fontWeight: FontWeight.bold),),),

        TextTile(label: t.lastName, value: Text('${user.lastName}',    style: const TextStyle(fontWeight: FontWeight.bold),),),

        TextTile(label: t.birthDate, value: Text('${user.birthDate}',    style: const TextStyle(fontWeight: FontWeight.bold),),),

        TextTile(label: t.sex, value: Text('${user.gender}',    style: const TextStyle(fontWeight: FontWeight.bold),),),

        TextTile(label: t.height, value: Text('${user.height} cm',    style: const TextStyle(fontWeight: FontWeight.bold),),),

        TextTile(label: t.weight, value: Text('${user.weight} kg',    style: const TextStyle(fontWeight: FontWeight.bold),),),
      ],
    );
  }}