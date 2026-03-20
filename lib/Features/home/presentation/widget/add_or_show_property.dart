import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_strings.dart';
import 'package:stay_match/core/constants/app_styles.dart';
import 'package:stay_match/core/widgets/custom_elevated_button.dart';
class AddOrShowMyProperties extends StatelessWidget {
  const AddOrShowMyProperties({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.r, vertical: 8.r),
      height: 190.h,
      decoration: BoxDecoration(
        color: AppColors.bgGrey,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
           SizedBox(height: 4.h),
          Text(
            AppStrings.myProperties,
            style: AppStyles.semiBold18poppins.copyWith(
              color: AppColors.textColorPrimary,
            ),
          ),
           SizedBox(height: 12.h),
          Text(
            AppStrings.addYourProperty,
            style: AppStyles.medium18poppins.copyWith(
              color: AppColors.textColorPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 6.h),
          Text(
            AppStrings.shareApartmentDetails,
            style: AppStyles.medium12poppins.copyWith(
              color: AppColors.textColorSecondary,
            ),
            textAlign: TextAlign.center,
          ),
           SizedBox(height: 16.h),
          // todo: implement add property
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 80.0.r),
            child: CustomElevatedButton(
              verticalPadding: 6.r,
              textStyle: AppStyles.semiBold14poppins,
              text: AppStrings.addProperty,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}