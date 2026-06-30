import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stay_match/Features/rooms/data/models/shared_apartment_details.dart';
import 'package:stay_match/Features/saved/presentation/manager/saved_properties_cubit.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_styles.dart';
import 'package:stay_match/core/widgets/heart_favourite_button.dart';

import '../../../../../core/routing/app_routing.dart';

class SharedPropertyImageCarousel extends StatelessWidget {
  final List<PropertyImages> images;
  final int numImages;
  final ValueNotifier<int> picNotifier;
  final int propertyId;
  final bool isSaved;

  const SharedPropertyImageCarousel({
    required this.images,
    required this.numImages,
    required this.picNotifier,
    required this.propertyId,
    required this.isSaved,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240.h,
      child: Stack(
        children: [
          // Pages
          PageView.builder(
            onPageChanged: (v) => picNotifier.value = v + 1,
            itemCount: numImages,
            itemBuilder: (_, i) {
              final url = images.isNotEmpty ? (images[i].imageUrl ?? '') : '';
              return CachedNetworkImage(
                imageUrl: url,
                fit: BoxFit.cover,
                placeholder: (_, __) => Container(
                  color: AppColors.bgGrey,
                  child: const Center(child: CircularProgressIndicator()),
                ),
                errorWidget: (_, __, ___) => Container(
                  color: AppColors.bgGrey,
                  child: Icon(
                    Icons.broken_image_outlined,
                    size: 40.r,
                    color: AppColors.textColorSecondary,
                  ),
                ),
              );
            },
          ),

          // View Reviews — top left
          // Positioned(
          //   top: 12.h,
          //   left: 12.w,
          //   child: GestureDetector(
          //     onTap: () {
          //       if (context.mounted) {
          //         context.pushNamed(
          //             AppRouting.showReviewsName,
          //             pathParameters: {
          //               "propertyId": propertyId.toString()
          //             });
          //       }
          //     },
          //     child: Container(
          //       padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          //       decoration: BoxDecoration(
          //         color: AppColors.primary,
          //         borderRadius: BorderRadius.circular(20.r),
          //       ),
          //       child: Text(
          //         'View Reviews',
          //         style: AppStyles.semiBold12poppins.copyWith(
          //           color: Colors.white,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),

          // todo: share — top right
          Positioned(
            top: 10.h,
            right: 10.w,
            child: Row(
              children: [
                Container(
                  width: 34.r,
                  height: 34.r,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: AppColors.elevationShadow,
                  ),
                  child: HeartFavoriteButton(
                    id: propertyId,
                    initialSavedStatus: isSaved,
                    scaleUp: true, type: SavedItemType.wholeApartment,
                  ),
                ),
                SizedBox(width: 6.w),
                // _ImgBtn(icon: Icons.share_outlined, onTap: () {}),
              ],
            ),
          ),

          // Page counter — top right (below icons)
          Positioned(
            bottom: 20.h,
            right: 10.w,
            child: ValueListenableBuilder<int>(
              valueListenable: picNotifier,
              builder: (_, val, __) => Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.92),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  '$val / $numImages',
                  style: AppStyles.semiBold12poppins.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
          ),

          // Dot indicator — bottom
          Positioned(
            bottom: 10.h,
            left: 0,
            right: 0,
            child: ValueListenableBuilder<int>(
              valueListenable: picNotifier,
              builder: (_, val, __) => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  numImages,
                  (i) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: (val - 1) == i ? 16.w : 8.w,
                    height: 8.h,
                    margin: EdgeInsets.symmetric(horizontal: 3.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.r),
                      border: Border.all(color: Colors.white, width: 0.3.r),
                      color: (val - 1) == i ? Colors.white : Colors.white54,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}