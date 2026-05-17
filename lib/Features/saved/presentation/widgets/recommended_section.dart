import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:stay_match/Features/saved/data/models/recommended_properties_response.dart';
import 'package:stay_match/Features/saved/presentation/manager/saved_properties_cubit.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_styles.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/routing/app_routing.dart';

class RecommendedSection extends StatelessWidget {
  final RecommendedPropertiesResponse response;
  final VoidCallback onShowMore;

  const RecommendedSection({
    super.key,
    required this.response,
    required this.onShowMore,
  });

  @override
  Widget build(BuildContext context) {
    final items = response.data?.items ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Section header ───────────────────────────────────────────────
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.anthologyCurated,
                style: AppStyles.bold10poppins.copyWith(
                  color: Colors.grey.shade400,
                  letterSpacing: 1.2,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                response.data?.title ?? AppStrings.recommendedForYou,
                style: AppStyles.bold20poppins.copyWith(color: Colors.black),
              ),
              if (response.data?.subtitle != null) ...[
                SizedBox(height: 2.h),
                Text(
                  response.data!.subtitle!,
                  style: AppStyles.regular12poppins.copyWith(
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ],
          ),
        ),

        SizedBox(height: 16.h),

        // ── Items list ────────────────────────────────────────────────────
        if (items.isEmpty)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
            child: Center(
              child: Text(
                AppStrings.noRecommendations,
                style: AppStyles.regular14poppins.copyWith(color: Colors.grey),
              ),
            ),
          )
        else
          // Replaced ListView.separated with a clean Column loop to stay secure inside CustomScrollView
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: List.generate(items.length, (index) {
                return Padding(
                  padding: EdgeInsets.only(
                    bottom: index == items.length - 1 ? 0 : 12.h,
                  ),
                  child: RecommendedItemCard(item: items[index]),
                );
              }),
            ),
          ),

        SizedBox(height: 16.h),

        // ── Show more button ──────────────────────────────────────────────
        // Padding(
        //   padding: EdgeInsets.symmetric(horizontal: 20.w),
        //   child: GestureDetector(
        //     onTap: onShowMore,
        //     child: Container(
        //       padding: EdgeInsets.symmetric(vertical: 16.h),
        //       decoration: BoxDecoration(
        //         color: Colors.grey.shade100,
        //         borderRadius: BorderRadius.circular(12.r),
        //       ),
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           Text(
        //             AppStrings.showMoreSuggestions,
        //             style: AppStyles.medium14poppins,
        //           ),
        //           SizedBox(width: 6.w),
        //           Icon(Icons.keyboard_arrow_down, size: 18.r),
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}

// ── Recommended item card ─────────────────────────────────────────────────────

class RecommendedItemCard extends StatelessWidget {
  final Items item;

  const RecommendedItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        var route = item.propertyType == "Apartment"
            ? AppRouting.apartmentDetailsViewName
            : AppRouting.roomDetailsViewName;
        if (context.mounted && route != null)
          if(item.propertyType == "Apartment") context.pushNamed(route, queryParameters: {"id": item.id});
          // else context.pushNamed(route, queryParameters: {});
        },
      child: Container(
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          color: AppColors.containerColor,
          borderRadius: BorderRadius.circular(14.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Thumbnail
            ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: SizedBox(
                width: 72.r,
                height: 72.r,
                child: item.imageUrl != null
                    ? Image.network(
                        item.imageUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => _ThumbPlaceholder(),
                      )
                    : _ThumbPlaceholder(),
              ),
            ),

            SizedBox(width: 12.w),

            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name ?? 'Property',
                    style: AppStyles.semiBold14poppins.copyWith(
                      color: Colors.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 12.r,
                        color: Colors.grey.shade500,
                      ),
                      SizedBox(width: 2.w),
                      Expanded(
                        child: Text(
                          '${item.city ?? ''}, ${item.government ?? ''}',
                          style: AppStyles.regular12poppins.copyWith(
                            color: Colors.grey.shade500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    '\$${item.priceDisplay ?? item.price.toString()}',
                    style: AppStyles.semiBold14poppins.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),

            IconButton(
              onPressed: () {
                var itemType = item.propertyType == "Apartment"
                    ? SavedItemType.wholeApartment
                    : item.propertyType == "Room"
                    ? SavedItemType.room
                    : SavedItemType.sharedApartment;
                int id = item.id ?? 0;
                context.read<SavedPropertiesCubit>().toggleSaved(
                  itemType: itemType,
                  propertyId: id,
                );
              },
              color: Colors.grey.shade400,
              icon: Icon(FontAwesome.heart, size: 20.r),
            ),
          ],
        ),
      ),
    );
  }
}

class _ThumbPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade200,
      child: Icon(Icons.image_not_supported, color: Colors.grey, size: 32.r),
    );
  }
}