import 'package:flutter/material.dart';

class LogoHeader extends StatelessWidget {
  const LogoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        SizedBox(height: 20),
        Text(
          'S(IŁ)EX',
          style: TextStyle(
            fontSize: 36,
            letterSpacing: 4,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4AA3C3),
            shadows: [
              Shadow(offset: Offset(1, 1), color: Colors.black),
            ],
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
