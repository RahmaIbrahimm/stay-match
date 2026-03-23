import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_strings.dart';
import 'package:stay_match/core/constants/app_styles.dart';
import 'package:stay_match/features/filter/presentation/manager/filter_cubit.dart';
import 'package:stay_match/features/filter/presentation/widgets/sort_by_oldest.dart';
import '../../data/models/rooms_filter_params.dart';
import 'filter_helper.dart';
import 'filter_sheet_who.dart';

class FilterCard extends StatelessWidget {
  final FilterTypeProperty filterType;


   FilterCard(
      {super.key, required this.filterType,});

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
            // WHERE search todo: implement logic
            _buildFilterPrompt(
              titleText: AppStrings.where,
              prompt: _getWherePrompt(context),
              onTap: () {
                // TODO: Implement WHERE filter
                // _showWhereFilterSheet(context);
              },
            ),
            Divider(color: AppColors.grey),

            // WHEN search todo: implement logic
            _buildFilterPrompt(
              titleText: AppStrings.when,
              prompt: _getWhenPrompt(context),
              onTap: () {
                // TODO: Implement WHEN filter
                // _showWhenFilterSheet(context);
              },
            ),
            Divider(color: AppColors.grey),

            // WHO search (fully implemented)
            _buildFilterPrompt(
              titleText: AppStrings.who,
              prompt: _getWhoPrompt(context),
              onTap: () {
                _showWhoFilterSheet(context);
              },
            ),

            // Sort by
            SortedByOldest(
              isApartmentFilter: filterType == FilterTypeProperty.apartment,
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

    if (filterType == FilterTypeProperty.apartment) {
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

    if (filterType == FilterTypeProperty.apartment) {
      final filters = cubit.currentApartmentFilters;
      final start = filters.start;
      final monthsCount = filters.monthsCount;

      if (start != null && start.isNotEmpty) {
        if (monthsCount != null) {
          return '\n$start ($monthsCount months)';
        }
        return '\n$start';
      }
    } else {
      final filters = cubit.currentRoomsFilters;
      final start = filters.start;
      final monthsCount = filters.monthsCount;

      if (start != null && start.isNotEmpty) {
        if (monthsCount != null) {
          return '\n$start ($monthsCount months)';
        }
        return '\n$start';
      }
    }
    return '\nSearch Dates';
  }

  String _getWhoPrompt(BuildContext context) {
    final cubit = context.read<FilterCubit>();
    final List<String> preferences = [];

    if (filterType == FilterTypeProperty.apartment) {
      final filters = cubit.currentApartmentFilters;
      if (filters.allowsFamilies == true) preferences.add('Families');
      if (filters.allowsChildren == true) preferences.add('Children');
      if (filters.allowsStudents == true) preferences.add('Students');
      if (filters.workerGender != null && filters.workerGender!.isNotEmpty) {
        preferences.add('Worker: ${filters.workerGender}');
      }
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

    if (filterType == FilterTypeProperty.apartment) {
      final filters = cubit.currentApartmentFilters;
      return filters.government != null ||
          filters.start != null ||
          filters.monthsCount != null ||
          filters.allowsFamilies != null ||
          filters.allowsChildren != null ||
          filters.allowsStudents != null ||
          filters.workerGender != null ||
          filters.onlyAvailable == true ||
          filters.orderByOldest == true;
    } else {
      final filters = cubit.currentRoomsFilters;
      return filters.government != null ||
          filters.start != null ||
          filters.monthsCount != null ||
          filters.allowsFamilies != null ||
          filters.allowsChildren != null ||
          filters.allowsStudents != null ||
          filters.workerGender != null ||
          filters.onlyAvailable == true ||
          filters.orderByOldest == true;
    }
  }

  void _resetFilters(BuildContext context) {
    final cubit = context.read<FilterCubit>();

    if (filterType == FilterTypeProperty.apartment) {
      cubit.resetApartmentFilters();
    } else {
      cubit.resetRoomsFilters();
    }
  }

  void _showWhoFilterSheet(BuildContext context) {
    final cubit = context.read<FilterCubit>();

    if (filterType == FilterTypeProperty.apartment) {
      final currentFilters = cubit.currentApartmentFilters;

      Scaffold.of(context).showBottomSheet(
        backgroundColor: AppColors.containerColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        (context) {
          return FilterSheetWho(
            allowsFamilies: currentFilters.allowsFamilies,
            allowsChildren: currentFilters.allowsChildren,
            allowsStudents: currentFilters.allowsStudents,
            workerGender: currentFilters.workerGender,
            onlyAvailable: currentFilters.onlyAvailable,
            studentGender: currentFilters.studentGender,
            filterType: FilterTypeProperty.apartment,
            allowsWorkers: currentFilters.allowsWorkers,
            // onApply: ({
            //   bool? allowsFamilies,
            //   bool? allowsChildren,
            //   bool? allowsStudents,
            //   String? studentGender,
            //   bool? allowsWorkers,
            //   String? workerGender,
            //   bool? onlyAvailable,
            //
            // }) {
            //   cubit.updateApartmentFilter(
            //     allowsFamilies: allowsFamilies,
            //     allowsChildren: allowsChildren,
            //     allowsStudents: allowsStudents,
            //     workerGender: allowsWorkers == true ? workerGender : null,
            //     onlyAvailable: onlyAvailable,
            //     forceRefresh: true,
            //   );
            // },
          );
        },
      );
    } else {
      final currentFilters = cubit.currentRoomsFilters;
      //  final tempFilters = RoomsFilterParams(
      //   allowsFamilies: currentFilters.allowsFamilies,
      //   allowsChildren: currentFilters.allowsChildren,
      //   allowsStudents: currentFilters.allowsStudents,
      //   studentGender: currentFilters.studentGender,
      //   allowsWorkers: currentFilters.allowsWorkers,
      //   workerGender: currentFilters.workerGender,
      //   onlyAvailable: currentFilters.onlyAvailable,
      // );
      Scaffold.of(context).showBottomSheet(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
            (context) {
          return FilterSheetWho(
            allowsFamilies: currentFilters.allowsFamilies,
            allowsChildren: currentFilters.allowsChildren,
            allowsStudents: currentFilters.allowsStudents,
            workerGender: currentFilters.workerGender,
            onlyAvailable: currentFilters.onlyAvailable,
            studentGender: currentFilters.studentGender,
            filterType: FilterTypeProperty.room,
            allowsWorkers: currentFilters.allowsWorkers,
            // onApply: ({
            //   bool? allowsFamilies,
            //   bool? allowsChildren,
            //   bool? allowsStudents,
            //   String? studentGender,
            //   bool? allowsWorkers,
            //   String? workerGender,
            //   bool? onlyAvailable,
            // }) {
            //   cubit.updateRoomsFilter(
            //     allowsFamilies: allowsFamilies,
            //     allowsChildren: allowsChildren,
            //     allowsStudents: allowsStudents,
            //     workerGender: allowsWorkers == true ? workerGender : null,
            //     onlyAvailable: onlyAvailable,
            //     forceRefresh: true,
            //   );
            // },
          );
        },
      );
    }
  }

  Widget _buildFilterPrompt({
    required String titleText,
    required String prompt,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: RichText(
        textAlign: TextAlign.start,
        text: TextSpan(
          children: [
            TextSpan(
              text: titleText,
              style: AppStyles.semiBold16poppins.copyWith(
                color: AppColors.primary,
              ),
            ),
            TextSpan(
              text: prompt,
              style: AppStyles.regular18poppins.copyWith(
                color: AppColors.textColorSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}