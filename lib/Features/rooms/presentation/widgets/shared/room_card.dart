import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_strings.dart';
import 'package:stay_match/core/constants/app_styles.dart';
import 'package:stay_match/core/routing/app_routing.dart';
import 'package:stay_match/Features/home/presentation/widget/small_custom_button.dart';
import 'package:stay_match/Features/rooms/presentation/widgets/shared/room_in_property_data.dart';

import '../../../../shared/widgets/card_cover_photo.dart';
import '../../../data/models/get_all_rooms.dart';

class RoomCard extends StatelessWidget {
  const RoomCard({
    super.key,
    required this.coverImageUrl,
    required this.name,
    required this.street,
    required this.city,
    required this.id,
    required this.rooms,
    this.scaleUp = false, this.item,
  });

  final String? coverImageUrl;
  final String? name;
  final String? street;
  final String? city;
  final List<AllRooms> rooms;
  final int id;
  final Items? item;
  final bool scaleUp;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Tells the card to securely span the full horizontal track width
      decoration: BoxDecoration(
        color: AppColors.containerColor,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: AppColors.elevationShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, // Allows the full card to naturally size itself vertically
        children: [
          // 1. Fixed Aspect Ratio Image
          AspectRatio(
            aspectRatio: 1.8,
            child: CardCoverPhoto(imageUrl: coverImageUrl ?? '',item: item,),
          ),

          // 2. Details Border Container
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.containerColor,
              border: Border(
                left: BorderSide(color: AppColors.primary, strokeAlign: BorderSide.strokeAlignInside),
                right: BorderSide(color: AppColors.primary, strokeAlign: BorderSide.strokeAlignInside),
                bottom: BorderSide(color: AppColors.primary, strokeAlign: BorderSide.strokeAlignInside),
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8.r),
                bottomRight: Radius.circular(8.r),
              ),
            ),
            child: _buildRoomDetails(context),
          ),
        ],
      ),
    );
  }

  Widget _buildRoomDetails(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, // Changes column constraint to prevent layout size crashes
        children: [
          // Title
          Text(
            name ?? 'No name',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: (scaleUp ? AppStyles.semiBold16poppins : AppStyles.semiBold12poppins).copyWith(
              color: AppColors.textColorPrimary,
            ),
          ),

          SizedBox(height: 4.h),

          // Location
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.location_on,
                color: AppColors.textColorSecondary,
                size: 13.r,
              ),
              SizedBox(width: 4.w),
              Flexible(
                child: Text(
                  '${street ?? 'No street'}, ${city ?? 'No city'}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: (scaleUp ? AppStyles.semiBold12poppins : AppStyles.medium10poppins).copyWith(
                    color: AppColors.textColorSecondary,
                  ),
                ),
              ),
            ],
          ),

          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Divider(color: AppColors.textColorSecondary.withValues(alpha: 0.3), thickness: 0.8.r),
          ),

          // --- FIXED HERE ---
          // Replaced Flexible/Expanded with a bounded container structure.
          // This allows it to layout perfectly under vertical full-width scroll lists.
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: RoomInPropertyData(
                rooms: rooms,
                scaleUp: scaleUp,
              ),
            ),

          // Action Button
          Padding(
            padding: EdgeInsets.only(top: 12.h),
            child: SizedBox(
              width: double.infinity,
              height: scaleUp ? 46.h : 38.h,
              child: SmallCustomButton(
                text: AppStrings.viewDetails,
                textStyle: scaleUp ? AppStyles.semiBold16poppins : AppStyles.semiBold15poppins,
                onPressed: () {
                  context.pushNamed(
                    AppRouting.sharedPropertyViewName,
                    pathParameters: {'propertyId': id.toString()},
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}