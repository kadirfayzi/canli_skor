import 'package:flutter/material.dart';

class InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final TextTheme textTheme;

  const InfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12,
        children: [
          Icon(icon, size: 24, color: Colors.grey[700]),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 2,
              children: [
                Text(label, style: textTheme.labelLarge?.copyWith(color: Colors.grey[600])),
                Text(value, style: textTheme.titleMedium),
              ],
            ),
          ),
        ],
      );
}
