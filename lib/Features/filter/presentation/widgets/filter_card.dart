import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/Features/apartments/presentation/widgets/shared/apartment_helper.dart';
import 'package:stay_match/Features/filter/presentation/manager/filter_cubit.dart';
import 'package:stay_match/Features/filter/presentation/widgets/sort_by_oldest.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_strings.dart';
import 'package:stay_match/core/constants/app_styles.dart';

import 'filter_helper.dart';
import 'filter_sheet_when.dart';
import 'filter_sheet_where.dart';
import 'filter_sheet_who.dart';
class FilterCard extends StatelessWidget {
  final PropertyType filterType;

  const FilterCard({super.key, required this.filterType});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.all(16.r),
        margin: EdgeInsets.only(top: 16.h),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.grey),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          spacing: 8.h,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Apartmenthelper.buildFilterPrompt(
              titleText: AppStrings.where,
              prompt: _getWherePrompt(context),
              onTap: () {
                _showWhereFilterSheet(context);
              },
            ),
            Divider(color: AppColors.grey),

            Apartmenthelper.buildFilterPrompt(
              titleText: AppStrings.when,
              prompt: _getWhenPrompt(context),
              onTap: () {
                // TODO: Implement WHEN filter
                _showWhenFilterSheet(context);
              },
            ),
            Divider(color: AppColors.grey),

            // WHO search (fully implemented)
            Apartmenthelper.buildFilterPrompt(
              titleText: AppStrings.who,
              prompt: _getWhoPrompt(context),
              onTap: () {
                _showWhoFilterSheet(context);
              },
            ),

            // Sort by
            SortedByOldest(
              isApartmentFilter: filterType == PropertyType.apartment,
            ),

            // Reset filters button (only show if filters are active)
            if (_hasActiveFilters(context))
              Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: TextButton(
                  onPressed: () => _resetFilters(context),
                  child: Text(
                    'Reset all filters',
                    style: AppStyles.medium14poppins.copyWith(
                      color: AppColors.textColorError,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Helper methods
  String _getWherePrompt(BuildContext context) {
    final cubit = context.read<FilterCubit>();

    if (filterType == PropertyType.apartment) {
      final filters = cubit.currentApartmentFilters;
      final government = filters.government;
      if (government != null && government.isNotEmpty) {
        return '\n$government';
      }
    } else {
      final filters = cubit.currentRoomsFilters;
      final government = filters.government;
      if (government != null && government.isNotEmpty) {
        return '\n$government';
      }
    }
    return '\nSearch Destinations';
  }

  String _getWhenPrompt(BuildContext context) {
    final cubit = context.read<FilterCubit>();

    if (filterType == PropertyType.apartment) {
      final filters = cubit.currentApartmentFilters;
      final start = filters.start;
      final monthsCount = filters.monthsCount;

      final formattedStart = FilterHelper.formatDate(start);
      if (formattedStart.isNotEmpty) {
        if (monthsCount != null) {
          return '\n$formattedStart ($monthsCount months)';
        }
        return '\n$formattedStart';
      }
    } else {
      final filters = cubit.currentRoomsFilters;
      final start = filters.start;
      final monthsCount = filters.monthsCount;

      final formattedStart = FilterHelper.formatDate(start);
      if (formattedStart.isNotEmpty) {
        if (monthsCount != null) {
          return '\n$formattedStart ($monthsCount months)';
        }
        return '\n$formattedStart';
      }
    }

    return '\nSearch Dates';
  }

  String _getWhoPrompt(BuildContext context) {
    final cubit = context.read<FilterCubit>();
    final List<String> preferences = [];

    if (filterType == PropertyType.apartment) {
      final filters = cubit.currentApartmentFilters;
      if (filters.allowsFamilies == true) preferences.add('Families');
      if (filters.allowsChildren == true) preferences.add('Children');
      // if (filters.allowsStudents == true) preferences.add('Students');
      if (filters.allowsStudents == true)
        preferences.add(
          'Students: ${(filters.studentGender == null || filters.studentGender!.isEmpty) ? 'Male' : 'Female'}',
        );
      if (filters.allowsWorkers == true)
        preferences.add(
          'Worker: ${(filters.workerGender == null || filters.workerGender!.isEmpty) ? 'Male' : 'Female'}',
        );
    } else {
      final filters = cubit.currentRoomsFilters;
      if (filters.allowsFamilies == true) preferences.add('Families');
      if (filters.allowsChildren == true) preferences.add('Children');
      if (filters.allowsStudents == true) preferences.add('Students');
      if (filters.workerGender != null && filters.workerGender!.isNotEmpty) {
        preferences.add('Worker: ${filters.workerGender}');
      }
    }

    if (preferences.isNotEmpty) {
      return '\n${preferences.join(', ')}';
    }
    return '\nAdd Guests';
  }

  bool _hasActiveFilters(BuildContext context) {
    final cubit = context.read<FilterCubit>();

    if (filterType == PropertyType.apartment) {
      final filters = cubit.currentApartmentFilters;
      return filters.government != null ||
          filters.start != null ||
          filters.monthsCount != null ||
          filters.allowsFamilies != null ||
          filters.allowsChildren != null ||
          filters.allowsStudents != null ||
          filters.allowsWorkers != null ||
          filters.onlyAvailable == true;
    } else {
      final filters = cubit.currentRoomsFilters;
      return filters.government != null ||
          filters.start != null ||
          filters.monthsCount != null ||
          filters.allowsFamilies != null ||
          filters.allowsChildren != null ||
          filters.allowsStudents != null ||
          filters.allowsWorkers != null ||
          filters.onlyAvailable == true;
    }
  }

  void _resetFilters(BuildContext context) {
    final cubit = context.read<FilterCubit>();

    if (filterType == PropertyType.apartment) {
      cubit.resetApartmentFilters();
    } else {
      cubit.resetRoomsFilters();
    }
  }

  void _showWhoFilterSheet(BuildContext context) {
    final cubit = context.read<FilterCubit>();

    if (filterType == PropertyType.apartment) {
      final currentFilters = cubit.currentApartmentFilters;

      FilterHelper.showFilterBottomSheet(
        context: context,
        builder: (context) {
          return FilterSheetWho(
            allowsFamilies: currentFilters.allowsFamilies,
            allowsChildren: currentFilters.allowsChildren,
            allowsStudents: currentFilters.allowsStudents,
            workerGender: currentFilters.workerGender,
            onlyAvailable: currentFilters.onlyAvailable,
            studentGender: currentFilters.studentGender,
            filterType: PropertyType.apartment,
            allowsWorkers: currentFilters.allowsWorkers,
          );
        },
      );
    } else {
      final currentFilters = cubit.currentRoomsFilters;

      FilterHelper.showFilterBottomSheet(
        context: context,
        builder: (context) {
          return FilterSheetWho(
            allowsFamilies: currentFilters.allowsFamilies,
            allowsChildren: currentFilters.allowsChildren,
            allowsStudents: currentFilters.allowsStudents,
            workerGender: currentFilters.workerGender,
            onlyAvailable: currentFilters.onlyAvailable,
            studentGender: currentFilters.studentGender,
            filterType: PropertyType.room,
            allowsWorkers: currentFilters.allowsWorkers,
          );
        },
      );
    }
  }

  void _showWhereFilterSheet(BuildContext context) {
    if (filterType == PropertyType.apartment) {
      FilterHelper.showFilterBottomSheet(
        context: context,
        builder: (context) {
          return FilterSheetWhere(propertyType: PropertyType.apartment);
        },
      );
    } else {
      FilterHelper.showFilterBottomSheet(
        context: context,
        builder: (context) {
          return FilterSheetWhere(propertyType: PropertyType.room);
        },
      );
    }
  }

  void _showWhenFilterSheet(BuildContext context) {
    if (filterType == PropertyType.apartment) {
      FilterHelper.showFilterBottomSheet(
        context: context,
        builder: (context) {
          return FilterSheetWhen(propertyType: PropertyType.apartment);
        },
      );
    } else {
      FilterHelper.showFilterBottomSheet(
        context: context,
        builder: (context) {
          return FilterSheetWhen(propertyType: PropertyType.room);
        },
      );
    }
  }
}