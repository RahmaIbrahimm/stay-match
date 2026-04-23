import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_strings.dart';
import 'package:stay_match/core/constants/app_styles.dart';

import 'apartment_details_helper.dart';

class PriceCardSliver extends SliverToBoxAdapter {
  PriceCardSliver({
    super.key,
    required dynamic details,
    required DateTime availableDate,
  }) : super(
         child: Container(
           padding: EdgeInsets.all(16.r),
           margin: EdgeInsets.all(16.r),
           decoration: BoxDecoration(
             color: AppColors.containerColor,
             borderRadius: BorderRadius.circular(12.r),
           ),
           child: Column(
             children: [
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 spacing: 8.r,
                 children: [
                   RichText(
                     text: TextSpan(
                       children: [
                         TextSpan(
                           text: '${details.monthlyRent?.toDouble()}',
                           style: AppStyles.bold20poppins.copyWith(
                             color: AppColors.primary,
                           ),
                         ),
                         TextSpan(
                           text: ' EGP',
                           style: AppStyles.bold20poppins.copyWith(
                             color: AppColors.primary,
                           ),
                         ),
                         TextSpan(
                           text: ' /month',
                           style: AppStyles.regular14poppins.copyWith(
                             color: AppColors.textColorSecondary,
                           ),
                         ),
                       ],
                     ),
                   ),
                   Flexible(
                     child: Container(
                       padding: EdgeInsets.symmetric(
                         horizontal: 32.r,
                         vertical: 4.r,
                       ),
                       decoration: BoxDecoration(
                         color: AppColors.primary.withValues(alpha: 0.1),
                         borderRadius: BorderRadius.circular(20.r),
                       ),
                       child: RichText(
                         overflow: TextOverflow.ellipsis,
                         textAlign: TextAlign.center,
                         text: TextSpan(
                           children: [
                             TextSpan(
                               text: AppStrings.available,
                               style: AppStyles.bold14poppins.copyWith(
                                 color: AppColors.primary,
                               ),
                             ),
                             TextSpan(
                               text:
                                   '\n${Apartmentdetailshelper.getMonth(availableDate.month)} ${availableDate.day}',
                               style: AppStyles.bold14poppins.copyWith(
                                 color: AppColors.primary,
                               ),
                             ),
                           ],
                         ),
                       ),
                     ),
                   ),
                 ],
               ),
               Divider(
                 color: AppColors.textColorSecondary.withValues(alpha: 0.3),
                 thickness: 0.5,
               ),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   _deposit(details), // These will work now
                   _minimumStay(details),
                 ],
               ),
             ],
           ),
         ),
       );

  static RichText _deposit(details) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: AppStrings.securityDeposit,
            style: AppStyles.bold12poppins.copyWith(
              color: AppColors.textColorSecondary,
            ),
          ),
          TextSpan(
            text: '\n${details.deposite ?? ''}',
            style: AppStyles.bold16poppins.copyWith(
              color: AppColors.textColorPrimary,
            ),
          ),
        ],
      ),
    );
  }

  static RichText _minimumStay(details) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: AppStrings.minimumStay,
            style: AppStyles.bold12poppins.copyWith(
              color: AppColors.textColorSecondary,
            ),
          ),
          TextSpan(
            text: '\n${details.minimumStay ?? ''}',
            style: AppStyles.bold16poppins.copyWith(
              color: AppColors.textColorPrimary,
            ),
          ),
          TextSpan(
            text: ' Months',
            style: AppStyles.bold16poppins.copyWith(
              color: AppColors.textColorPrimary,
            ),
          ),
        ],
      ),
    );
  }
}