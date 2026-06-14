import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/Features/reviews/presentation/widgets/add_review_widgets/star_rating_row.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_styles.dart';

class RateHostCard extends StatelessWidget {
  final String hostName;
  final String? hostImageUrl;
  final int communication;
  final ValueChanged<int> onCommunicationChanged;

  const RateHostCard({
    super.key,
    required this.hostName,
    this.hostImageUrl,
    required this.communication,
    required this.onCommunicationChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.containerColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: AppColors.elevationShadow,
      ),
      padding: EdgeInsets.all(20.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20.r,
                backgroundImage:
                    hostImageUrl != null && hostImageUrl!.isNotEmpty
                    ? NetworkImage(hostImageUrl!)
                    : null,
                backgroundColor: AppColors.blueGrey,
                child: hostImageUrl == null || hostImageUrl!.isEmpty
                    ? Icon(Icons.person, color: AppColors.primary, size: 22.r)
                    : null,
              ),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Rate the Host',
                    style: AppStyles.semiBold16poppins.copyWith(
                      color: AppColors.textColorPrimary,
                    ),
                  ),
                  Text(
                    'Interaction with $hostName',
                    style: AppStyles.regular12poppins.copyWith(
                      color: AppColors.textColorSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Divider(height: 24.h, color: AppColors.stroke),
          StarRatingRow(
            label: 'Communication',
            rating: communication,
            onRatingChanged: onCommunicationChanged,
          ),
          SizedBox(height: 12.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(14.r),
            decoration: BoxDecoration(
              color: AppColors.darkerGrey,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Text(
              '"Your host $hostName was very responsive during your stay. How would you rate the interaction?"',
              style: AppStyles.regular12poppins.copyWith(
                color: AppColors.textColorSecondary,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}