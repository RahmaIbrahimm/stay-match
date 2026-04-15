import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_colors.dart';
import '../constants/app_styles.dart';

class LocationRow extends StatelessWidget {
  const LocationRow({super.key, required this.city, required this.street});

  // final ApartmentDetailsData? details;
  final String? city;
  final String? street;

  @override
  Widget build(BuildContext context) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          WidgetSpan(
            child: Icon(
              Icons.location_pin,
              size: 20.sp,
              weight: 2,
              color: AppColors.primary,
            ),
          ),
          TextSpan(
            text: '${city ?? 'City location'}, ${street ?? 'street location'}',
            style: AppStyles.medium14poppins.copyWith(
              color: AppColors.primary,
              decoration: TextDecoration.underline,
            ),
          ),
        ],
      ),
    );
  }
}