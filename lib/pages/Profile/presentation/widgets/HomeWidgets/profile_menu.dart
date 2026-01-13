import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../../../shared/user_avatar.dart';
import '../../../../Auth/presentation/providers/auth_controller_provider.dart';
import '../../pages/edit_profile_page.dart';
import '../../pages/your_profile_page.dart';

class ProfileMenu extends ConsumerWidget {
  const ProfileMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authController = ref.read(authControllerProvider.notifier);
    final user = ref.watch(authControllerProvider).value;

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const UserAvatar(size: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    user?.firstName != null && user!.firstName!.isNotEmpty
                        ? '${AppLocalizations.of(context)!.welcomeUser}, ${user.firstName}'
                        : AppLocalizations.of(context)!.welcomeUser,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const YourProfilePage(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.person),
                ),
                PopupMenuButton<String>(
                  icon: const Icon(Icons.settings),
                  onSelected: (value) async {
                    switch (value) {
                      case 'edit_profile':
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const EditProfilePage(),
                          ),
                        );
                        break;

                      case 'logout':
                            await authController.logout(context);
                        break;
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'edit_profile',
                      height: 55,
                      child: Row(
                        children: [
                          const Icon(Icons.manage_accounts_rounded),
                          const SizedBox(width: 8),
                          Text(
                            AppLocalizations.of(context)!.editProfile,
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'logout',
                      height: 55,
                      child: Row(
                        children: [
                          const Icon(
                            Icons.logout,
                            color: Color(0xFFCE1010),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            AppLocalizations.of(context)!.logOut,
                            style: const TextStyle(
                              color: Color(0xFFCE1010),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
