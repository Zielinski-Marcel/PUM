import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/button.dart';
import '../../../../shared/text_field.dart';
import '../../../../shared/user_avatar.dart';
import '../Providers/profile_controller_provider.dart';

class EditProfileFormFields extends ConsumerStatefulWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController birthDateController;
  final TextEditingController sexController;
  final TextEditingController heightController;
  final TextEditingController weightController;

  const EditProfileFormFields({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
    required this.birthDateController,
    required this.sexController,
    required this.heightController,
    required this.weightController,
  });

  @override
  ConsumerState<EditProfileFormFields> createState() => _EditProfileFormFieldsState();
}

class _EditProfileFormFieldsState extends ConsumerState<EditProfileFormFields> {
  String? _gender;


  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final profileController = ref.read(profileControllerProvider.notifier);
    final isLoading = ref.watch(profileControllerProvider).isLoading;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: Stack(
            children: [
              UserAvatar(size: 45),
              Positioned(
                bottom: 0,
                right: 0,
                child: CircleAvatar(
                  radius: 16,
                  backgroundColor: const Color(0xFF6FC2DF),
                  child: Consumer(
                    builder: (context, ref, child) {
                      final profileController = ref.read(profileControllerProvider.notifier);
                      final isLoading = ref.watch(profileControllerProvider).isLoading;

                      return Button(
                        icon: Icons.edit,
                        isLoading: isLoading,
                        onPressed: () {
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),


        const SizedBox(height: 24),

        TextFieldWidget(
          labelText: t.firstName,
          hintText: t.firstName,
          controller: widget.firstNameController,
        ),

        TextFieldWidget(
          labelText: t.lastName,
          hintText: t.lastName,
          controller: widget.lastNameController,
        ),

        Text(t.birthDate),
        const SizedBox(height: 6),
        TextField(
          controller: widget.birthDateController,
          readOnly: true,
          decoration: const InputDecoration(
            hintText: 'YYYY-MM-DD',
            border: OutlineInputBorder(),
            suffixIcon: Icon(Icons.calendar_today),
          ),
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: DateTime(2000),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );

            if (date != null) {
              widget.birthDateController.text =
              '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
            }
          },
        ),

        Text(t.sex),
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
          initialValue: _gender,
          items: [
            DropdownMenuItem(value: 'male', child: Text(t.man)),
            DropdownMenuItem(value: 'female', child: Text(t.woman)),
          ],
          onChanged: (value) {
            setState(() {
              _gender = value;
              widget.sexController.text = value ?? '';
            });
          },
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),

        TextFieldWidget(
          labelText: t.height,
          hintText: 'cm',
          controller: widget.heightController,
          keyboardType: TextInputType.number,
        ),

        TextFieldWidget(
          labelText: t.weight,
          hintText: 'kg',
          controller: widget.weightController,
          keyboardType: TextInputType.number,
        ),

        const SizedBox(height: 24),

        Button(
          buttonText: t.confirmChanges,
          isLoading: isLoading,
          onPressed: () {
            final heightText = widget.heightController.text.trim();
            final weightText = widget.weightController.text.trim();

            profileController.updateProfile(
              context: context,
              firstName: widget.firstNameController.text.trim(),
              lastName: widget.lastNameController.text.trim(),
              birthDate: widget.birthDateController.text.trim(),
              gender: widget.sexController.text.trim(),
              height: heightText.isNotEmpty ? int.tryParse(heightText) : null,
              weight: weightText.isNotEmpty ? int.tryParse(weightText) : null,
            );
          },
        )
      ],
    );
  }
}
