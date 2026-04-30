import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/Features/my_properties/data/models/my_properties_response.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_styles.dart';
import '../../../shared/widgets/card_cover_photo.dart';

class MyPropertyCard extends StatelessWidget {
  const MyPropertyCard({
    super.key,
    required this.property,
    this.onTap,
  });

  final Properties property;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 185.w,
        decoration: BoxDecoration(
          color: AppColors.containerColor,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.stroke, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            AspectRatio(
              aspectRatio: 1.5, // Keeps image height consistent
              child: CardCoverPhoto(imageUrl: property.coverImageUrl,showRating: false,showCompatibility: false,),
            ),

            // 2. Body Section (Title & Location)
            Padding(
              padding: EdgeInsets.all(8.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    property.name ?? 'Property Name',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppStyles.semiBold14poppins.copyWith(
                      color: AppColors.textColorPrimary,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 12.sp, color: Colors.grey),
                      SizedBox(width: 2.w),
                      Expanded(
                        child: Text(
                          '${property.city}, ${property.street}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppStyles.regular12poppins.copyWith(
                            color: AppColors.textColorSecondary,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // 3. Divider
            Divider(height: 1.h, color: AppColors.stroke, indent: 8.w, endIndent: 8.w),

            // 4. Bottom Section (Price)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'EGP ${property.monthlyRent}',
                            style: AppStyles.bold16poppins.copyWith(
                              color: AppColors.textColorPrimary,
                              fontSize: 15.sp,
                            ),
                          ),
                          TextSpan(
                            text: ' / month',
                            style: AppStyles.medium10poppins.copyWith(
                              color: AppColors.textColorSuccess,
                              fontSize: 11.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Icon(
                  //   Icons.favorite_border_rounded,
                  //   size: 16.sp,
                  //   color: AppColors.textColorSecondary,
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}