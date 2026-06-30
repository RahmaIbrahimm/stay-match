import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stay_match/Features/home/presentation/widget/small_custom_button.dart';
import 'package:stay_match/core/constants/app_strings.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_styles.dart';
import '../../../../core/routing/app_routing.dart';
import '../../../rooms/data/models/get_all_rooms.dart';
import '../../../shared/widgets/card_cover_photo.dart';
class RoomsList extends StatelessWidget {
  const RoomsList({super.key, required this.roomPropertiesData});

  final List<Items>? roomPropertiesData;

  @override
  Widget build(BuildContext context) {
    if (roomPropertiesData == null || roomPropertiesData!.isEmpty) {
      return Center(
        child: Text(
          AppStrings.noRoomsAvailable,
          style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w500),
        ),
      );
    }

    final itemCount = roomPropertiesData!.length > 3 ? 3 : roomPropertiesData!
        .length;

    return SizedBox(
      height: 295.h,
      // Added a tiny bit of height clearance for the spec grid layout
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: itemCount,
        physics: const ClampingScrollPhysics(),
        itemBuilder: (context, index) {
          return SimpleRoomCard(
            item: roomPropertiesData![index],
          );
        },
      ),
    );
  }
}

class SimpleRoomCard extends StatelessWidget {
  const SimpleRoomCard({
    super.key,
    required this.item,
  });

  final Items item;

  @override
  Widget build(BuildContext context) {
    final double? startingPrice = item.rooms != null && item.rooms!.isNotEmpty
        ? item.rooms!.map((r) => (r.monthRent ?? 0).toDouble()).reduce(min)
        : null;

    final int optionsCount = item.rooms?.length ?? 0;

    return Container(
      width: 240.w,
      margin: EdgeInsets.only(right: 14.w, top: 4.h, bottom: 4.h),
      decoration: BoxDecoration(
        color: AppColors.containerColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.primary, width: 1.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Image ──────────────────────────────────────────────────────
          Stack(
            children: [
              SizedBox(
                height: 130.h,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius:
                  BorderRadius.vertical(top: Radius.circular(16.r)),
                  child: CardCoverPhoto(imageUrl: item.coverImageUrl ?? '',item: item,),
                ),
              ),
              // Price badge
              if (startingPrice != null)
                Positioned(
                  top: 10.h,
                  right: 10.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 10.w, vertical: 5.h),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      'EGP ${startingPrice.toStringAsFixed(0)}/mo',
                      style: AppStyles.bold12poppins
                          .copyWith(color: Colors.white, fontSize: 11.sp),
                    ),
                  ),
                ),
            ],
          ),

          // ── Content ────────────────────────────────────────────────────
          Padding(
            padding: EdgeInsets.fromLTRB(12.w, 10.h, 12.w, 12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Title
                Text(
                  item.name ?? 'No name',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyles.bold14poppins.copyWith(
                    color: AppColors.textColorPrimary,
                    letterSpacing: 0.2,
                  ),
                ),
                SizedBox(height: 4.h),

                // Location
                Row(
                  children: [
                    Icon(Icons.location_on_rounded,
                        color: AppColors.textColorSecondary, size: 12.r),
                    SizedBox(width: 4.w),
                    Expanded(
                      child: Text(
                        '${item.street ?? ''}, ${item.city ?? ''} (${item
                            .government ?? ''})',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyles.medium10poppins.copyWith(
                          color: AppColors.textColorSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),

                // ── Pill badges ───────────────────────────────────────────
                Row(
                  children: [
                    if (item.size != null && item.size != 0)
                      _PillBadge(
                        icon: Icons.square_foot_rounded,
                        label: '${item.size} m²',
                      ),
                    if (item.size != null && item.size != 0)
                      SizedBox(width: 6.w),
                    _PillBadge(
                      icon: Icons.king_bed_rounded,
                      label: optionsCount == 1
                          ? '1 Room'
                          : '$optionsCount Rooms',
                    ),
                  ],
                ),
                SizedBox(height: 12.h),

                // Button
                SizedBox(
                  width: double.infinity,
                  height: 36.h,
                  child: SmallCustomButton(
                    text: AppStrings.viewDetails,
                    textStyle: AppStyles.semiBold12poppins
                        .copyWith(fontSize: 13.sp),
                    onPressed: () {
                      context.pushNamed(
                        AppRouting.sharedPropertyViewName,
                        pathParameters: {
                          'propertyId': item.id!.toString()
                        },
                      );
                    },
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

class _PillBadge extends StatelessWidget {
  final IconData icon;
  final String label;

  const _PillBadge({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: AppColors.blueGrey,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, size: 12.r, color: AppColors.primary),
        SizedBox(width: 4.w),
        Text(label,
            style: AppStyles.medium10poppins
                .copyWith(color: AppColors.primary)),
      ]),
    );
  }
}