// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:stay_match/Features/my_properties/data/models/my_properties_response.dart';
//
// import '../../../../core/constants/app_colors.dart';
// import '../../../../core/constants/app_styles.dart';
// import '../../../shared/widgets/card_cover_photo.dart';
//
// class HomeMyPropertyCard extends StatelessWidget {
//   const HomeMyPropertyCard({
//     super.key,
//     required this.property,
//     this.onTap,
//   });
//
//   final Properties property;
//   final VoidCallback? onTap;
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: 185.w,
//         decoration: BoxDecoration(
//           color: AppColors.containerColor,
//           borderRadius: BorderRadius.circular(12.r),
//           border: Border.all(color: AppColors.stroke, width: 1),
//             boxShadow: AppColors.elevationShadow
//         ),
//         child: Container(
//           decoration: BoxDecoration(
//
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               SizedBox(height: 120.h,
//                   child: CardCoverPhoto(imageUrl: property.coverImageUrl,
//                     showRating: false,
//                     showCompatibility: false,)),
//
//               // 2. Body Section (Title & Location)
//               Padding(
//                 padding: EdgeInsets.all(8.r),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       property.name ?? 'Property Name',
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                       style: AppStyles.semiBold14poppins.copyWith(
//                         color: AppColors.textColorPrimary,
//                       ),
//                     ),
//                     SizedBox(height: 4.h),
//                     Row(
//                       children: [
//                         Icon(
//                             Icons.location_on, size: 12.sp, color: Colors.grey),
//                         SizedBox(width: 2.w),
//                         Expanded(
//                           child: Text(
//                             '${property.city}, ${property.street}',
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                             style: AppStyles.regular12poppins.copyWith(
//                               color: AppColors.textColorSecondary,
//                               fontSize: 12.sp,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//
//               // 3. Divider
//               Divider(height: 1.h,
//                   color: AppColors.stroke,
//                   indent: 8.w,
//                   endIndent: 8.w),
//
//               // 4. Bottom Section (Price)
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       child: Text.rich(
//                         TextSpan(
//                           children: [
//                             TextSpan(
//                               text: 'EGP ${property.monthlyRent?.toInt() ?? 0}',
//                               style: AppStyles.bold16poppins.copyWith(
//                                 color: AppColors.textColorPrimary,
//                                 fontSize: 15.sp,
//                               ),
//                             ),
//                             TextSpan(
//                               text: ' / month',
//                               style: AppStyles.medium10poppins.copyWith(
//                                 color: AppColors.textColorSuccess,
//                                 fontSize: 11.sp,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stay_match/Features/my_properties/data/models/my_properties_response.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_styles.dart';
import '../../../../core/routing/app_routing.dart';
import '../../../shared/widgets/card_cover_photo.dart';

class HomeMyPropertyCard extends StatelessWidget {
  const HomeMyPropertyCard({
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
          boxShadow: AppColors.elevationShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // 1. Cover image with status badge
                SizedBox(
                  height: 100.h,
                  width: double.infinity,
                  child: CardCoverPhoto(
                    imageUrl: property.coverImageUrl,
                    showRating: false,
                    showCompatibility: false,
                  ),),
            // 2. Title & Location
            Padding(
              padding: EdgeInsets.fromLTRB(8.w, 6.h, 8.w, 2.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    property.name ?? 'Property Name',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppStyles.semiBold12poppins.copyWith(
                      color: AppColors.textColorPrimary,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 11.sp, color: Colors.grey),
                      SizedBox(width: 2.w),
                      Expanded(
                        child: Text(
                          '${property.city}, ${property.street}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppStyles.regular12poppins.copyWith(
                            color: AppColors.textColorSecondary,
                            fontSize: 11.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // 3. Divider
            Divider(
              height: 8.h,
              color: AppColors.stroke,
              indent: 8.w,
              endIndent: 8.w,
            ),

            // 4. Price
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'EGP ${property.monthlyRent?.toInt() ?? 0}',
                      style: AppStyles.bold14poppins.copyWith(
                        color: AppColors.textColorPrimary,
                      ),
                    ),
                    TextSpan(
                      text: ' / month',
                      style: AppStyles.medium10poppins.copyWith(
                        color: AppColors.textColorSuccess,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 5. Preview button
            Padding(
              padding: EdgeInsets.all(8.r),
              child: SizedBox(
                width: double.infinity,
                height: 30.h,
                child: OutlinedButton(
                  onPressed: () {
                    // TODO: navigate based on property.type
                    if (property.type?.toLowerCase() == 'apartment') {
                      context.pushNamed(AppRouting.apartmentDetailsViewName,
                          pathParameters: {'id': property.id.toString()});
                    } else {
                      context.pushNamed(AppRouting.sharedPropertyViewName,
                          pathParameters: {'propertyId': property.id.toString()});
                    }
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    side: BorderSide(color: AppColors.primary, width: 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    padding: EdgeInsets.zero,
                  ),
                  child: Text(
                    'Preview',
                    style: AppStyles.semiBold12poppins.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}