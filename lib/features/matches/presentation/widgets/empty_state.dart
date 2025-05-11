import 'package:flutter/material.dart';

import 'package:canli_skor/core/constants/app_colors.dart';

class EmptyState extends StatelessWidget {
  final String message;

  const EmptyState({super.key, required this.message});

  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 16,
          children: [
            const Icon(Icons.info_outline, size: 48, color: AppColors.textSecondary),
            Text(
              message,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
}
