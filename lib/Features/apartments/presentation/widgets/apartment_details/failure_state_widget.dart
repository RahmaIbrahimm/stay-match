import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/core/constants/app_strings.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_styles.dart';
import '../../manager/apartment_details_cubit.dart';

class FailureState extends StatelessWidget {
  const FailureState({super.key, required this.errMessage, required this.id});

  final String errMessage;
  final int id;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Error icon
            Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                color: AppColors.textColorError.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline_rounded,
                size: 40.sp,
                color: AppColors.textColorError,
              ),
            ),

            SizedBox(height: 16.h),

            // Error message
            Text(
              'Oops! Something went wrong',
              style: AppStyles.bold20poppins,
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 8.h),

            Text(
              errMessage,
              style: AppStyles.medium14poppins.copyWith(
                color: AppColors.textColorSecondary,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 24.h),

            // Retry button
            SizedBox(
              width: 200.w,
              height: 48.h,
              child: ElevatedButton(
                onPressed: () {
                  context.read<ApartmentDetailsCubit>().getApartmentDetails(
                    id: id,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  AppStrings.tryAgain,
                  style: AppStyles.semiBold16poppins.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}