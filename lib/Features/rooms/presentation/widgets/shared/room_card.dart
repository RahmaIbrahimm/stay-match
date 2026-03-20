import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_strings.dart';
import 'package:stay_match/core/constants/app_styles.dart';
import 'package:stay_match/core/routing/app_routing.dart';
import 'package:stay_match/features/home/presentation/widget/small_custom_button.dart';
import 'package:stay_match/features/rooms/presentation/widgets/shared/room_in_property_data.dart';

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
  });

  final String? coverImageUrl;
  final String? name;
  final String? street;
  final String? city;
  final List<Rooms> rooms;
  final int id;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.5.h,
      // width: size.width * 0.5.w,
      // height: 400.h,
      margin: EdgeInsets.only(right: 16.r),
      decoration: BoxDecoration(
        color: AppColors.containerColor,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: AppColors.elevationShadow,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: CardCoverPhoto(imageUrl: coverImageUrl ?? ''),
          ),
          Expanded(
            flex: 3,
            child: Container(
              // width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.containerColor,
                border: Border(
                  left: BorderSide(
                    color: AppColors.primary,
                    strokeAlign: BorderSide.strokeAlignInside,
                  ),
                  right: BorderSide(
                    color: AppColors.primary,
                    strokeAlign: BorderSide.strokeAlignInside,
                  ),
                  bottom: BorderSide(
                    color: AppColors.primary,
                    strokeAlign: BorderSide.strokeAlignInside,
                  ),
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8.r),
                  bottomRight: Radius.circular(8.r),
                ),
              ),
              child: _buildRoomDetails(context),
            ),
          ),
        ],
      ),
    );
  }

  Column _buildRoomDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 4.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.r),
          child: Text(
            name ?? 'No name',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppStyles.semiBold12poppins.copyWith(
              color: AppColors.textColorPrimary,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.r),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.location_on,
                color: AppColors.textColorSecondary,
                size: 10.r,
              ),
              Flexible(
                // Use Flexible instead of Expanded
                child: Text(
                  '${street ?? 'No street'}, ${city ?? 'No city'}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyles.medium10poppins.copyWith(
                    color: AppColors.textColorSecondary,
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(color: AppColors.textColorSecondary, thickness: 1.r),
        SizedBox(
          height: 50.h,
          child: RoomInPropertyData(rooms: rooms),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: 8.0.r,
            bottom: 8.r,
            right: 16.r,
            left: 16.r,
          ),
          child: SizedBox(
            width: double.infinity,
            child: SmallCustomButton(
              text: AppStrings.viewDetails,
              onPressed: () {
                context.pushNamed(
                  AppRouting.roomDetailsViewName,
                  pathParameters: {'id': id.toString()},
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}