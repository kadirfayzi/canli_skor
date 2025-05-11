import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:canli_skor/features/matches/bloc/match_bloc.dart';
import 'package:canli_skor/features/matches/bloc/match_event.dart';

import 'package:canli_skor/core/constants/app_colors.dart';

class FilterDropdown extends StatelessWidget {
  const FilterDropdown({super.key});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(12),
        child: Card(
          margin: EdgeInsets.zero,
          child: DropdownMenu<String>(
            initialSelection: 'recent',
            expandedInsets: EdgeInsets.zero,
            inputDecorationTheme: const InputDecorationTheme(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left: 12),
            ),
            menuStyle: MenuStyle(
              backgroundColor: WidgetStateProperty.all(AppColors.cardLight),
              minimumSize: WidgetStateProperty.all(const Size.fromWidth(double.infinity)),
              shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
            ),
            trailingIcon: const Icon(Icons.filter_list, color: AppColors.primary),
            textStyle: Theme.of(context).textTheme.titleMedium,
            onSelected: (value) {
              if (value != null) {
                context.read<MatchBloc>().add(FilterMatches(value));
              }
            },
            dropdownMenuEntries: const [
              DropdownMenuEntry(value: 'recent', label: 'En Güncel'),
              DropdownMenuEntry(value: 'oldest', label: 'En Eski'),
            ],
          ),
        ),
      );
}
