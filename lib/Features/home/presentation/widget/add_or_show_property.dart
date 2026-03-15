import 'package:flutter/material.dart';
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
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      height: size.height * 0.22,
      decoration: BoxDecoration(
        color: AppColors.bgGrey,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 4),
          Text(
            AppStrings.myProperties,
            style: AppStyles.semiBold18poppins.copyWith(
              color: AppColors.textColorPrimary,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            AppStrings.addYourProperty,
            style: AppStyles.medium18poppins.copyWith(
              color: AppColors.textColorPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          Text(
            AppStrings.shareApartmentDetails,
            style: AppStyles.medium12poppins.copyWith(
              color: AppColors.textColorSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          // todo: implement add property
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80.0),
            child: CustomElevatedButton(
              verticalPadding: 6,
              textStyle: AppStyles.semiBold15poppins,
              text: AppStrings.addProperty,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}