import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stay_match/Features/other_user_profile/data/models/other_user_profile_response.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_styles.dart';
import 'package:stay_match/core/routing/app_routing.dart';
import 'package:stay_match/core/widgets/custom_elevated_button.dart';

import 'amenitiy_chip.dart';
import 'image_placeholder.dart';

class ListingCard extends StatelessWidget {
  final ActiveListings listing;

  const ListingCard({super.key, required this.listing});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.containerColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: AppColors.elevationShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image with "View Reviews" overlay
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
                child: listing.image != null && listing.image!.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: listing.image!,
                        height: 180.h,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: (_, __) => ImagePlaceholder(),
                        errorWidget: (_, __, ___) => ImagePlaceholder(),
                      )
                    : ImagePlaceholder(),
              ),
              Positioned(
                top: 12.r,
                right: 12.r,
                child: GestureDetector(
                  // TODO: navigate to property reviews screen with listing.propertyId
                  onTap: () {
                    // TODO: context.pushNamed(AppRouting.reviewsView, extra: listing.propertyId);
                    if (listing.type?.toLowerCase() == 'apartment') {
                      context.pushNamed(
                        AppRouting.apartmentReviewsName,
                        pathParameters: {'id': listing.propertyId.toString()},
                      );
                    } else {
                      // todo: reviews for room implementation
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.containerColor.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      'View Reviews',
                      style: AppStyles.semiBold12poppins.copyWith(
                        color: AppColors.textColorPrimary,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Details
          Padding(
            padding: EdgeInsets.all(14.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Type chip + rating
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (listing.type != null && listing.type!.isNotEmpty)
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.blueGrey,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Text(
                          listing.type!.toUpperCase(),
                          style: AppStyles.bold10inter.copyWith(
                            color: AppColors.primary,
                            letterSpacing: 0.6,
                          ),
                        ),
                      ),
                    if (listing.rating != null && listing.rating! > 0)
                      Row(
                        children: [
                          Icon(Icons.star, size: 14.r, color: Colors.amber),
                          SizedBox(width: 4.w),
                          Text(
                            listing.rating!.toStringAsFixed(1),
                            style: AppStyles.semiBold14poppins.copyWith(
                              color: AppColors.textColorPrimary,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
                SizedBox(height: 8.h),

                // Title
                Text(
                  listing.title ?? 'Untitled Property',
                  style: AppStyles.semiBold16poppins.copyWith(
                    color: AppColors.textColorPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),

                // Location
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 13.r,
                      color: AppColors.textColorSecondary,
                    ),
                    SizedBox(width: 2.w),
                    Expanded(
                      child: Text(
                        [
                          listing.city,
                          listing.government,
                        ].where((e) => e != null && e.isNotEmpty).join(', '),
                        style: AppStyles.regular12poppins.copyWith(
                          color: AppColors.textColorSecondary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Divider(height: 1, color: AppColors.stroke),
                SizedBox(height: 10.h),

                // Amenities row
                SizedBox(
                  height: 25.h,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      if (listing.beds != null)
                        AmenityChip(
                          icon: Icons.bed_outlined,
                          label: '${listing.beds} Bed',
                        ),
                      if (listing.beds != null) SizedBox(width: 12.w),
                      if (listing.baths != null)
                        AmenityChip(
                          icon: Icons.bathtub_outlined,
                          label: '${listing.baths} Bath',
                        ),
                      if (listing.sharedBathroom == true) ...[
                        SizedBox(width: 12.w),
                        AmenityChip(icon: Icons.group_outlined, label: 'Shared'),
                      ],
                      if (listing.size != null) ...[
                        SizedBox(width: 12.w),
                        AmenityChip(
                          icon: Icons.straighten,
                          label: '${listing.size} sqft',
                        ),
                      ],
                      if (listing.wifi == true) ...[
                        SizedBox(width: 12.w),
                        AmenityChip(icon: Icons.wifi, label: 'High Speed'),
                      ],
                    ],
                  ),
                ),
                SizedBox(height: 14.h),

                // View Details button
                SizedBox(
                  width: double.infinity,
                  height: 46.h,
                  child: CustomElevatedButton(
                    text: 'View Details',
                    // TODO: navigate to property details with listing.propertyId / listing.roomId
                    onPressed: () {
                      // TODO: context.pushNamed(AppRouting.propertyDetails, extra: listing.propertyId);
                      if (listing?.type?.toLowerCase() == 'apartment') {
                        context.pushNamed(
                          AppRouting.apartmentDetailsViewName,
                          pathParameters: {'id': listing.propertyId.toString()},
                        );
                      } else {
                        context.pushNamed(
                          AppRouting.roomDetailsViewName,
                          pathParameters: {
                            'propertyId': listing.propertyId.toString(),
                            'roomId': listing.roomId.toString(),
                          },
                        );
                      }
                    },
                    backgroundColor: AppColors.primary,
                    textColor: AppColors.textColorWhite,
                    textStyle: AppStyles.semiBold14poppins,
                    borderRadius: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}