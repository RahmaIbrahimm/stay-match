import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/features/filter/presentation/manager/filter_cubit.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_styles.dart';
import '../../../../core/widgets/custom_elevated_button.dart';

// class SortedByOldest extends StatelessWidget {
//   SortedByOldest({
//     super.key,
//     this.sortByOldest = false,
//     required this.onPressed,
//   });
//
//   bool sortByOldest;
//   final VoidCallback onPressed;
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       spacing: 12.w,
//       children: [
//         Text(
//           AppStrings.sortedBy,
//           style: AppStyles.medium18poppins.copyWith(
//             color: AppColors.textColorSecondary,
//           ),
//         ),
//         // todo implement for sorted by newest and oldest
//         BlocConsumer<FilterCubit, FilterState>(
//           listener: (BuildContext context, FilterState state) {
//             if (state is ApartmentFilterFailure) {
//               ScaffoldMessenger.of(context).clearSnackBars();
//               ScaffoldMessenger.of(
//                 context,
//               ).showSnackBar(SnackBar(content: Text(state.errMessage)));
//             }
//             if (state is RoomsFilterFailure) {
//               ScaffoldMessenger.of(context).clearSnackBars();
//               ScaffoldMessenger.of(
//                 context,
//               ).showSnackBar(SnackBar(content: Text(state.errMessage)));
//             }
//           },
//           builder: (context, state) {
//             return CustomElevatedButton(
//               isLoading:
//                   (state is ApartmentFilterLoading ||
//                       state is RoomsFilterLoading)
//                   ? true
//                   : false,
//               text:
//                   (state is ApartmentFilterSuccess ||
//                       state is RoomsFilterSuccess)
//                   ? (state is ApartmentFilterSuccess)
//                         ? (sortByOldest ? AppStrings.oldest : AppStrings.newest)
//                         : (state is RoomsFilterSuccess)
//                         ? (sortByOldest ? AppStrings.oldest : AppStrings.newest)
//                         : AppStrings.newest
//                   : AppStrings.newest,
//               onPressed: () async {
//                 sortByOldest = !sortByOldest;
//                 await BlocProvider.of<FilterCubit>(
//                   context,
//                 ).getAllApartments(orderByOldest: sortByOldest);
//               },
//               textStyle: AppStyles.medium16poppins,
//               borderRadius: 12.r,
//               horizontalPadding: 16.r,
//               verticalPadding: 5.r,
//             );
//           },
//         ),
//       ],
//     );
//   }
// }

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
              // isLoading: isLoading,
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