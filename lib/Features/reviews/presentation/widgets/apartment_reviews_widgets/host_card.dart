import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/Features/reviews/presentation/widgets/shared/reviews_helpers.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_styles.dart';
import '../../../data/models/get_apartment_reviews.dart';
class HostCard extends StatelessWidget {
  final Host host;

  const HostCard({required this.host});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: AppColors.blue.withAlpha(50),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColors.primary.withAlpha(70)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar + name
            Row(
              children: [
                CircleAvatar(
                  radius: 26.r,
                  backgroundImage: host.hostImage != null
                      ? NetworkImage(host.hostImage!)
                      : null,
                  backgroundColor: RColors.divider,
                  child: host.hostImage == null
                      ? Icon(Icons.person, size: 26.r, color: RColors.textSecondary)
                      : null,
                ),
                SizedBox(width: 12.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${host.hostName ?? 'Host'} (Host)',
                      style: AppStyles.bold14poppins.copyWith(
                        color: RColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      host.isSuperHost == true
                          ? 'Superhost • ${host.yearsOfHosting ?? 0} years hosting'
                          : '${host.yearsOfHosting ?? 0} years hosting',
                      style: AppStyles.regular12poppins.copyWith(
                        color: RColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16.h),
            // Stats — two white rounded boxes
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(12.r),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'RESPONSE RATE',
                          style: AppStyles.regular10poppins.copyWith(
                            color: RColors.textSecondary,
                            letterSpacing: 0.4,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          '${host.responseRate ?? 0}%',
                          style: AppStyles.bold16poppins.copyWith(
                            color: RColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(12.r),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'RESPONSE TIME',
                          style: AppStyles.regular10poppins.copyWith(
                            color: RColors.textSecondary,
                            letterSpacing: 0.4,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          host.responseTime ?? 'N/A',
                          style: AppStyles.bold16poppins.copyWith(
                            color: RColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}