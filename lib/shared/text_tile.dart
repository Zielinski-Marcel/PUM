import 'package:flutter/material.dart';

class TextTile extends StatelessWidget {
  final Widget? leading;
  final String label;
  final Widget? value;

  const TextTile({
    super.key,
    this.leading,
    required this.label,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            if (leading != null) ...[
              leading!,
              const SizedBox(width: 12),
            ],
            Expanded(child: Text(label)),
            if (value != null) ...[
              value!
            ],
          ],
        ),
      ),
    );
  }
}
