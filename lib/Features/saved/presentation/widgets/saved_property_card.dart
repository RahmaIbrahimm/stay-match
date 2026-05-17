import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:stay_match/Features/saved/data/models/my_saved_response.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_styles.dart';

import '../../../../core/constants/app_strings.dart';

class SavedPropertyCard extends StatelessWidget {
  final SavedItems item;
  final VoidCallback onUnsave;
  final bool isToggling;

  const SavedPropertyCard({
    super.key,
    required this.item,
    required this.onUnsave,
    this.isToggling = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.07),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Image with overlays ──────────────────────────────────────────
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: item.imageUrl != null
                    ? Image.network(
                        item.imageUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => _ImagePlaceholder(),
                      )
                    : _ImagePlaceholder(),
              ),

              // Verified badge
              if (item.isAvailable == true)
                Positioned(
                  top: 12.h,
                  left: 12.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Text(
                      AppStrings.verified,
                      style: AppStyles.bold10poppins.copyWith(
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),

              // fav button
              Positioned(
                top: 10.h,
                right: 10.w,
                child: GestureDetector(
                  onTap: isToggling ? null : onUnsave,
                  child: ClipOval(
                    // Ensures the backdrop blur stays perfectly inside the circular boundary
                    child: Container(
                      width: 36.r,
                      height: 36.r,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 12.0, sigmaY: 12.0),
                        // Your requested uniform blur
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            // A semi-transparent white tint layer over the blur makes it pop elegantly
                            color: Colors.white.withValues(alpha: 0.4),
                          ),
                          alignment: Alignment.center,
                          child: isToggling
                              ? Padding(
                                  padding: EdgeInsets.all(8.r),
                                  child: const CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : Icon(
                                  FontAwesome.heart_solid,
                                  color: AppColors.primary,
                                  size: 20.r,
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // ── Card body ────────────────────────────────────────────────────
          Padding(
            padding: EdgeInsets.all(14.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name + Price
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        item.itemName ?? 'Property',
                        style: AppStyles.semiBold16poppins.copyWith(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '\$${item.priceDisplay ?? item.price.toString()}',
                          style: AppStyles.bold16poppins.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                        Text(
                          AppStrings.month,
                          style: AppStyles.regular10poppins.copyWith(
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: 6.h),

                // Address
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 14.r,
                      color: Colors.grey.shade500,
                    ),
                    SizedBox(width: 4.w),
                    Expanded(
                      child: Text(
                        item.address ?? '',
                        style: AppStyles.regular12poppins.copyWith(
                          color: Colors.grey.shade600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10.h),

                // Tags (Fixed: Implemented Horizontal ListView with bounded height)
                SizedBox(
                  height: 32.h,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    children: [
                      if (item.bedrooms != null)
                        _Tag(
                          icon: Icons.bed_outlined,
                          label: item.bedrooms == 0
                              ? AppStrings.studio
                              : '${item.bedrooms} ${AppStrings.bed}',
                        ),
                      if (item.furnished == true) ...[
                        SizedBox(width: 8.w),
                        _Tag(
                          icon: Icons.chair_outlined,
                          label: AppStrings.furnished,
                        ),
                      ],
                      if (item.displayType != null) ...[
                        SizedBox(width: 8.w),
                        _Tag(
                          icon: Icons.apartment_outlined,
                          label: item.displayType!,
                        ),
                      ],
                    ],
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

// ── Tag chip ──────────────────────────────────────────────────────────────────

class _Tag extends StatelessWidget {
  final IconData icon;
  final String label;

  const _Tag({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13.r, color: Colors.grey.shade600),
          SizedBox(width: 4.w),
          Text(
            label,
            style: AppStyles.medium12poppins.copyWith(
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Image placeholder ─────────────────────────────────────────────────────────

class _ImagePlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade200,
      child: Icon(Icons.image_not_supported, size: 48.r, color: Colors.grey),
    );
  }
}