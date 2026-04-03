import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/Features/filter/presentation/manager/filter_cubit.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_styles.dart';
import '../../../../core/widgets/custom_elevated_button.dart';

class SortedByOldest extends StatelessWidget {
  const SortedByOldest({super.key, required this.isApartmentFilter});

  final bool isApartmentFilter;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterCubit, FilterState>(
      builder: (context, state) {
        // late var isLoading;
        late var isSortingOldest;
        final cubit = context.read<FilterCubit>();
        if (isApartmentFilter) {
          isSortingOldest = cubit.currentApartmentFilters.orderByOldest;
          // isLoading = state is ApartmentFilterLoading;
        } else {
          isSortingOldest = cubit.currentRoomsFilters.orderByOldest;
          // isLoading = state is RoomsFilterLoading;
        }

        return Row(
          spacing: 12.w,
          children: [
            Text(
              AppStrings.sortedBy,
              style: AppStyles.medium18poppins.copyWith(
                color: AppColors.textColorSecondary,
              ),
            ),
            CustomElevatedButton(
              text: isSortingOldest ? AppStrings.oldest : AppStrings.newest,
              onPressed: () {
                log(
                  'Toggling ${isApartmentFilter ? 'apartment' : 'rooms'} sort order',
                );
                if (isApartmentFilter) {
                  cubit.toggleApartmentSortOrder();
                } else {
                  cubit.toggleRoomsSortOrder();
                }
              },
              textStyle: AppStyles.medium16poppins,
              borderRadius: 12.r,
              horizontalPadding: 16.r,
              verticalPadding: 5.r,
            ),
          ],
        );
      },
    );
  }
}