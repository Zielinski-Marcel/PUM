import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../../../shared/text_tile.dart';
import '../../../../../shared/user_avatar.dart';
import '../../Providers/profile_controller_provider.dart';
import 'package:intl/intl.dart';


class ProfileDetails extends ConsumerWidget {

  const ProfileDetails({super.key,});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context)!;
    final user = ref.watch(profileControllerProvider).user;

    if (user == null) {
      return Center(child: Text(t.error));
    }

    String formatBirthDate(String? birthDate) {
      if (birthDate == null || birthDate.isEmpty) return '-';
      try {
        final date = DateTime.parse(birthDate);
        return DateFormat('d MMM yyyy', 'pl_PL').format(date);
      } catch (_) {
        return birthDate;
      }
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

        TextTile(label: t.firstName, value: Text(user.firstName!= null ?'${user.firstName}' : '-',    style: const TextStyle(fontWeight: FontWeight.bold),),),

        TextTile(label: t.lastName, value: Text(user.lastName!=null ?'${user.lastName}': '-',    style: const TextStyle(fontWeight: FontWeight.bold),),),

        TextTile(label: t.birthDate, value: Text(user.birthDate!=null ?'${ formatBirthDate(user.birthDate)}': '-',    style: const TextStyle(fontWeight: FontWeight.bold),),),

        TextTile(label: t.sex, value: Text(user.gender!=null ?'${user.gender}': '-',    style: const TextStyle(fontWeight: FontWeight.bold),),),

        TextTile(label: t.height, value: Text(user.height!=null ?'${user.height} cm': '-',    style: const TextStyle(fontWeight: FontWeight.bold),),),

        TextTile(label: t.weight, value: Text(user.weight!=null ?'${user.weight} kg': '-',    style: const TextStyle(fontWeight: FontWeight.bold),),),
      ],
    );
  }}