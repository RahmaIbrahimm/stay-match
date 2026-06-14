// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../../../../../core/constants/app_colors.dart';
// import '../../../../../core/constants/app_strings.dart';
// import '../../../../../core/constants/app_styles.dart';
// import '../manager/home_cubit.dart';
//
// class HomeSearchField extends StatelessWidget {
//   HomeSearchField({super.key, required this.controller});
//
//   TextEditingController controller;
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       style: AppStyles.medium10poppins,
//       validator: (value) {
//         if (value == null || value.trim().isEmpty) {
//           return 'This field is required';
//         }
//         return null;
//       },
//       onChanged: (val){
//         debugPrint(val);
//       },
//       controller: controller,
//       decoration: InputDecoration(
//         suffixIconConstraints: BoxConstraints(minHeight: 20.r, minWidth: 20.r),
//         prefixIconConstraints: BoxConstraints(minHeight: 20.r, minWidth: 20.r),
//         isDense: true,
//         border: OutlineInputBorder(
//           gapPadding: 4,
//           borderRadius: BorderRadius.circular(10.r),
//           borderSide: BorderSide(color: AppColors.primary, width: 0.5),
//         ),
//         contentPadding: EdgeInsetsGeometry.symmetric(
//           vertical: 8.r,
//           horizontal: 8.r,
//         ),
//         prefixIcon: Padding(
//           padding: EdgeInsets.only(left: 8.w),
//           child: Icon(
//             Icons.search,
//             color: AppColors.textColorSecondary,
//             size: 16.sp,
//           ),
//         ),
//         suffixIcon: controller.text.isNotEmpty
//             ? GestureDetector(
//           onTap: () {
//             controller.clear();
//             context.read<HomeCubit>().clearSearch();
//           },
//           child: Icon(Icons.close),
//         )
//             : null,        hintText: AppStrings.searchHome,
//         hintStyle: AppStyles.medium10poppins.copyWith(
//           color: AppColors.textColorSecondary,
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/constants/app_styles.dart';
import '../manager/home_cubit.dart';

class HomeSearchField extends StatelessWidget {
  const HomeSearchField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (context, value, child) {
        return TextFormField(
          controller: controller,
          style: AppStyles.medium10poppins,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'This field is required';
            }
            return null;
          },
          decoration: InputDecoration(
            isDense: true,
            border: OutlineInputBorder(
              gapPadding: 4,
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(
                color: AppColors.primary,
                width: 0.5,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(
              vertical: 8.r,
              horizontal: 8.r,
            ),

            // Search icon
            prefixIconConstraints: BoxConstraints(
              minHeight: 20.r,
              minWidth: 20.r,
            ),
            prefixIcon: Padding(
              padding: EdgeInsets.only(left: 8.w),
              child: Icon(
                Icons.search,
                color: AppColors.textColorSecondary,
                size: 16.sp,
              ),
            ),

            // Clear icon
            suffixIconConstraints: BoxConstraints(
              minHeight: 20.r,
              minWidth: 20.r,
            ),
            suffixIcon: value.text.isNotEmpty
                ? Padding(
              padding: EdgeInsets.only(right: 8.w),
              child: GestureDetector(
                onTap: () {
                  controller.clear();
                  context.read<HomeCubit>().clearSearch();
                },
                child: Icon(
                  Icons.close,
                  color: AppColors.textColorSecondary,
                  size: 16.sp,
                ),
              ),
            )
                : null,

            hintText: AppStrings.searchHome,
            hintStyle: AppStyles.medium10poppins.copyWith(
              color: AppColors.textColorSecondary,
            ),
          ),
        );
      },
    );
  }
}