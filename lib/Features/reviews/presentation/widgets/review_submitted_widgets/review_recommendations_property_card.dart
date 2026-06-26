import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_styles.dart';
import '../../../../../core/widgets/heart_favourite_button.dart';
import '../../../../saved/presentation/manager/saved_properties_cubit.dart';
import '../../../data/models/review_recommendations.dart';

class ReviewRecommendationPropertyCard extends StatelessWidget {
  final RecommendedProperties property;

  const ReviewRecommendationPropertyCard({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // context.pushNamed(AppRouting.propertyDetail, extra: property.id)
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.containerColor,
          borderRadius: BorderRadius.circular(
            24.r,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 12.r,
              offset: const Offset(0, 6),
            ),
          ],

        ),
        clipBehavior: Clip.antiAlias,
        width: 280.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // --- Top Layer: Image + Favorite Button ---
            Stack(
              children: [
                ClipRRect(
                  child:
                      property.mainImage != null &&
                          property.mainImage!.isNotEmpty
                      ? Image.network(
                          property.mainImage!,
                          height: 180.h,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) =>
                              const _ImagePlaceholder(),
                        )
                      : const _ImagePlaceholder(),
                ),
                // Favorite Icon Button
                Positioned(
                  top: 16.h,
                  right: 16.w,
                  child: Container(
                    height: 38.r,
                    width: 38.r,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: HeartFavoriteButton(
                      id: property.id,
                      initialSavedStatus: property.isSaved ?? false,
                      scaleUp: true, type: SavedItemType.wholeApartment,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),

            // --- Bottom Layer: Details Section ---
            Padding(
              padding: EdgeInsets.all(16.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title & Rating Badge Line
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          property.name ?? 'Unnamed Property',
                          style: AppStyles.bold18poppins.copyWith(
                            color: AppColors.textColorPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (property.rating != null && property.rating! > 0) ...[
                        SizedBox(width: 8.w),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFFE2F5ED)),
                            borderRadius: BorderRadius.circular(100.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.star_rounded,
                                size: 16.r,
                                color: Colors.amber,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                property.rating.toString(),
                                style: AppStyles.semiBold12poppins.copyWith(
                                  color: AppColors.textColorPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      if (property.rating == null || property.rating! <= 0)...[
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFFE2F5ED)),
                            borderRadius: BorderRadius.circular(100.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.star_rounded,
                                size: 16.r,
                                color: Colors.amber,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                "No Rating",
                                style: AppStyles.semiBold12poppins.copyWith(
                                  color: AppColors.textColorPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]
                    ],
                  ),
                  SizedBox(height: 4.h),

                  // Location Row
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 16.r,
                        color: AppColors.textColorSecondary,
                      ),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Text(
                          property.city ?? 'Unknown City',
                          style: AppStyles.regular14manrope.copyWith(
                            color: AppColors.textColorSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),

                  // Amenities & Price Matrix Line
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Beds & Baths (Mocked elements layout setup based on the UI blueprint)
                      Row(
                        children: [
                          Icon(
                            Icons.king_bed_outlined,
                            size: 18.r,
                            color: AppColors.textColorSecondary,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            '3 Bed',
                            style: AppStyles.regular12poppins.copyWith(
                              color: AppColors.textColorSecondary,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Icon(
                            Icons.bathtub_outlined,
                            size: 16.r,
                            color: AppColors.textColorSecondary,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            '2 Bath',
                            style: AppStyles.regular12poppins.copyWith(
                              color: AppColors.textColorSecondary,
                            ),
                          ),
                        ],
                      ),

                      // Price display
                      property.monthlyRent != null && property.monthlyRent! > 0
                          ? RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: '\$${property.monthlyRent}',
                                    style: AppStyles.bold18poppins.copyWith(
                                      color: AppColors
                                          .primary, // Using your signature deep primary color
                                    ),
                                  ),
                                  TextSpan(
                                    text: '/month',
                                    style: AppStyles.regular12poppins.copyWith(
                                      color: AppColors.textColorSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '0',
                              style: AppStyles.bold18poppins.copyWith(
                                color: AppColors
                                    .primary,
                              ),
                            ),
                            TextSpan(
                              text: '/month',
                              style: AppStyles.regular12poppins.copyWith(
                                color: AppColors.textColorSecondary,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ImagePlaceholder extends StatelessWidget {
  const _ImagePlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180.h,
      width: double.infinity,
      color: AppColors.bgGrey,
      child: Icon(
        Icons.apartment_rounded,
        size: 48.r,
        color: AppColors.textColorSecondary,
      ),
    );
  }
}