import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/Features/reviews/presentation/widgets/add_review_widgets/star_rating_row.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_styles.dart';


class RatePlaceCard extends StatelessWidget {
  final int accuracy;
  final int cleanliness;
  final int checkIn;
  final int location;
  final int value;
  final ValueChanged<int> onAccuracyChanged;
  final ValueChanged<int> onCleanlinessChanged;
  final ValueChanged<int> onCheckInChanged;
  final ValueChanged<int> onLocationChanged;
  final ValueChanged<int> onValueChanged;

  const RatePlaceCard({
    super.key,
    required this.accuracy,
    required this.cleanliness,
    required this.checkIn,
    required this.location,
    required this.value,
    required this.onAccuracyChanged,
    required this.onCleanlinessChanged,
    required this.onCheckInChanged,
    required this.onLocationChanged,
    required this.onValueChanged,
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
              Container(
                width: 40.r,
                height: 40.r,
                decoration: BoxDecoration(
                  color: AppColors.blueGrey,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  Icons.apartment_rounded,
                  color: AppColors.primary,
                  size: 22.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                'Rate the Place',
                style: AppStyles.semiBold16poppins.copyWith(
                  color: AppColors.textColorPrimary,
                ),
              ),
            ],
          ),
          Divider(height: 24.h, color: AppColors.stroke),
          StarRatingRow(
            label: 'Accuracy',
            rating: accuracy,
            onRatingChanged: onAccuracyChanged,
          ),
          StarRatingRow(
            label: 'Cleanliness',
            rating: cleanliness,
            onRatingChanged: onCleanlinessChanged,
          ),
          StarRatingRow(
            label: 'Check-in',
            rating: checkIn,
            onRatingChanged: onCheckInChanged,
          ),
          StarRatingRow(
            label: 'Location',
            rating: location,
            onRatingChanged: onLocationChanged,
          ),
          StarRatingRow(
            label: 'Value',
            rating: value,
            onRatingChanged: onValueChanged,
          ),
        ],
      ),
    );
  }
}