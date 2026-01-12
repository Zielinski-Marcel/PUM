import 'package:flutter/material.dart';
import '../../../../shared/default_view.dart';
import '../widgets/your_profile_form.dart';

class YourProfilePage extends StatefulWidget {
  const YourProfilePage({super.key});

  @override
  State<YourProfilePage> createState() => _YourProfilePageState();
}

class _YourProfilePageState extends State<YourProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: DefaultView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            YourProfileForm(),
          ],
        ),
      ),
    );
  }
}
