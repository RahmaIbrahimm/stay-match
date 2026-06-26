import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stay_match/Features/rooms/data/models/shared_apartment_details.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_styles.dart';
import 'package:stay_match/core/widgets/custom_elevated_button.dart';

import '../../../../../core/routing/app_routing.dart';

class DetailsRoomCard extends StatelessWidget {
  final Rooms room;
  final int propertyId;
  final bool isMyProperty;
  const DetailsRoomCard({required this.room, required this.propertyId, required this.isMyProperty});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: AppColors.elevationShadow,
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              CachedNetworkImage(
                imageUrl: room.coverImageUrl ?? '',
                height: 120.h,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (_, __) =>
                    Container(height: 120.h, color: AppColors.bgGrey),
                errorWidget: (_, __, ___) => Container(
                  height: 120.h,
                  color: AppColors.bgGrey,
                  child: Icon(
                    Icons.bed_outlined,
                    size: 30.r,
                    color: AppColors.textColorSecondary,
                  ),
                ),
              ),
              if (room.monthRent != null)
                Positioned(
                  top: 8.h,
                  right: 8.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      '${room.monthRent} EGP/mo',
                      style: AppStyles.semiBold10poppins.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(10.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  room.roomName ?? 'Room',
                  style: AppStyles.semiBold14poppins.copyWith(
                    color: AppColors.textColorPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8.h),
                SizedBox(
                  width: double.infinity,
                  child: CustomElevatedButton(
                    text: 'View Room Details',
                    textStyle: AppStyles.semiBold14poppins,
                    borderRadius: 8,
                    verticalPadding: 8,
                    onPressed: () {
                      context.pushNamed(
                        AppRouting.roomDetailsViewName,
                        pathParameters: {
                          'roomId': room.id?.toString() ?? '-1',
                          'propertyId': propertyId.toString(),
                          'isMyProperty': isMyProperty.toString(),
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