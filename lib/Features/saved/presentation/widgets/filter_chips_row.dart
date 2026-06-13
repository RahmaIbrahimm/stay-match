import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/Features/saved/data/models/my_saved_response.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_styles.dart';

import '../../../../core/constants/app_strings.dart';

class FilterChipsRow extends StatelessWidget {
  final String currentFilter;
  final ValueChanged<String> onFilterChanged;
  final Stats? stats;

  const FilterChipsRow({
    super.key,
    required this.currentFilter,
    required this.onFilterChanged,
    this.stats,
  });

  @override
  Widget build(BuildContext context) {
    int totalProperties = (stats?.rooms ?? 0) +
        (stats?.wholeApartments?? 0) +
        (stats?.sharedHouses ?? 0);
    final filters = [
      _FilterItem(
        label: 'All ($totalProperties)',
        value: 'all',
      ),      _FilterItem(
        label: '${AppStrings.rooms} (${stats?.rooms ?? 0})',
        value: 'rooms',
      ),
      _FilterItem(
        label:
        '${AppStrings.wholeApartments} (${stats?.wholeApartments ?? 0})',
        value: 'apartments',
      ),
      _FilterItem(
        label: '${AppStrings.shared} (${stats?.sharedHouses ?? 0})',
        value: 'shared',
      ),
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: filters.map((f) {
          final isSelected = currentFilter == f.value;
          return Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: GestureDetector(
              onTap: () => onFilterChanged(f.value),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(
                    horizontal: 16.w, vertical: 9.h),
                decoration: BoxDecoration(
                  color:
                  isSelected ? AppColors.primary : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  f.label,
                  style: AppStyles.medium12poppins.copyWith(
                    color: isSelected ? Colors.white : Colors.black87,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _FilterItem {
  final String label;
  final String value;
  const _FilterItem({required this.label, required this.value});
}