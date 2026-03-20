import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stay_match/core/routing/app_routing.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_styles.dart';
import '../../../../core/widgets/custom_text_button.dart';

class ApartmentsSectionContainer extends StatelessWidget {
  const ApartmentsSectionContainer({super.key, required this.widget});

  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 8.r, right: 8.r, top: 8.r, bottom: 16.r),
      decoration: BoxDecoration(
        color: AppColors.bgGrey,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8.h),
          _buildHeader(context),
          Text(
            AppStrings.handPickedApartments,
            style: AppStyles.medium12poppins.copyWith(
              color: AppColors.textColorSecondary,
            ),
          ),
          SizedBox(height: 8.h),
          widget,
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            AppStrings.discoverApartments,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppStyles.semiBold16poppins.copyWith(
              color: AppColors.textColorPrimary,
            ),
          ),
        ),
        Flexible(
          child: CustomTextButton(
            onPressed: () {
              context.pushNamed(AppRouting.findApartmentViewName);
            },
            text: AppStrings.viewAllApartments,
            textColor: AppColors.primary,
            textStyle: AppStyles.semiBold12poppins,
            isPadded: false,
          ),
        ),
      ],
    );
  }
}