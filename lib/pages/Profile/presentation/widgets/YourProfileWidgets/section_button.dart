import 'package:flutter/material.dart';

class SectionButton extends StatelessWidget {
  final String text;
  final bool isActive;
  final VoidCallback onTap;

  const SectionButton({
    required this.text,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor:
        isActive ? const Color(0xFF6FC2DF) : Colors.grey.shade200,
        foregroundColor: isActive ? Colors.white : Colors.black,
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      child: Text(text),
    );
  }
}
