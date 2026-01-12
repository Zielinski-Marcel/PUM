import 'package:flutter/material.dart';
import '../../../../shared/default_view.dart';
import '../widgets/profile_edit_form.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final birthDateController = TextEditingController();
  final sexController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: DefaultView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    EditProfileFormFields(
                      firstNameController: firstNameController,
                      lastNameController: lastNameController,
                      birthDateController: birthDateController,
                      sexController: sexController,
                      heightController: heightController,
                      weightController: weightController,
                    ),
                  ],
                ),
              ),
    );
  }
  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    birthDateController.dispose();
    heightController.dispose();
    weightController.dispose();
    super.dispose();
  }
}
