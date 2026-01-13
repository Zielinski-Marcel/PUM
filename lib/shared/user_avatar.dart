import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../l10n/app_localizations.dart';
import '../pages/Auth/presentation/providers/auth_controller_provider.dart';

class UserAvatar extends ConsumerWidget {
  final double size;

  const UserAvatar({
    super.key,
    required this.size,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context)!;
    final user = ref.watch(authControllerProvider).value;

    if (user == null) {
      return Center(child: Text(t.error));
    }

    final String? avatarUrl = user.avatarUrl;

    return CircleAvatar(
      radius: size,
      backgroundColor: Colors.grey.shade200,
      backgroundImage: avatarUrl != null && avatarUrl.isNotEmpty
          ? NetworkImage(avatarUrl)
          : null,
      child: avatarUrl == null || avatarUrl.isEmpty
          ? Icon(
        Icons.person,
        size: size,
        color: Colors.grey,
      )
          : null,
    );
  }
}