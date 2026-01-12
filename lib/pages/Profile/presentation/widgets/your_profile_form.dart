import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/button.dart';
import '../../../../shared/user_avatar.dart';
import '../pages/details_profile_page.dart';
import 'YourProfileWidgets/user_stats.dart';
import 'YourProfileWidgets/ranking.dart';
import 'YourProfileWidgets/section_button.dart';
import '../controllers/your_profile_controller.dart';

class YourProfileForm extends ConsumerWidget {
  const YourProfileForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSection = ref.watch(yourProfileControllerProvider);
    final controller = ref.read(yourProfileControllerProvider.notifier);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(child: UserAvatar(size: 45)),
          const SizedBox(height: 24),
          Button(
            buttonText: AppLocalizations.of(context)!.viewProfile,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ProfileDetailsPage(),
                ),
              );
            },
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: SectionButton(
                  text: AppLocalizations.of(context)!.statistics,
                  isActive: currentSection == ProfileSection.stats,
                  onTap: () => controller.changeSection(ProfileSection.stats),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SectionButton(
                  text: AppLocalizations.of(context)!.ranking,
                  isActive: currentSection == ProfileSection.ranking,
                  onTap: () => controller.changeSection(ProfileSection.ranking),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: currentSection == ProfileSection.stats
                ? const UserStatsWidget()
                : const RankingWidget(),
          ),
        ],
      ),
    );
  }
}
