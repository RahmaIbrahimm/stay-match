import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_styles.dart';
import '../../../data/models/apartment_details_response.dart';

class HostNameSliver extends StatelessWidget {
  const HostNameSliver({super.key, required this.details});

  final ApartmentDetailsData? details;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: RPadding(
        padding: const EdgeInsets.all(16),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 4.r),
            alignment: Alignment.center,
            width: 200.w,
            height: 30.h,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 8.w,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.person, size: 20.sp, color: Colors.white),
                Expanded(
                  child: Text(
                    details?.hostName ?? 'Host Name',
                    style: AppStyles.semiBold16poppins.copyWith(
                      color: Colors.white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}