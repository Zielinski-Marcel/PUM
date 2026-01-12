import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String? buttonText;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool fullWidth;
  final IconData? icon;
  final Color? iconColor;

  const Button({
    super.key,
    this.buttonText,
    this.onPressed,
    this.isLoading = false,
    this.fullWidth = true,
    this.icon,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final iconActualColor = iconColor ?? Colors.white;

    Widget child;

    if (isLoading) {
      child = const SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: Colors.white,
        ),
      );
    } else if (icon != null) {
      child = Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 20, color: iconActualColor),
          Text(
            buttonText ?? '',
            style: const TextStyle(
              fontSize: 15,
              color: Colors.white,
            ),
          ),
        ],
      );
    } else {
      child = Text(
        buttonText ?? '',
        style: const TextStyle(
          fontSize: 15,
          color: Colors.white,
        ),
      );
    }

    return SizedBox(
      width: fullWidth ? double.infinity : null,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF6FC2DF),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: child,
      ),
    );
  }
}
