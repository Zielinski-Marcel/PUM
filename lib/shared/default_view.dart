import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'home_page_button.dart';
import 'logo.dart';

class DefaultView extends ConsumerWidget {
  final Widget child;
  final bool showBackButton;
  const DefaultView({super.key, required this.child,this.showBackButton=true});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const LogoHeader(),
            const SizedBox(height: 30),
            const Divider(
              color: Color(0xFF8ECAE6),
              thickness: 1.5,

            ),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  child,
                  const SizedBox(height: 18),
                  if(showBackButton)const HomePageButton(),
                ],
              ),
            ),),
            const Divider(
              color: Color(0xFF8ECAE6),
              thickness: 1.5,
            ),
          ],
        ),
      ),
    );
  }
}
