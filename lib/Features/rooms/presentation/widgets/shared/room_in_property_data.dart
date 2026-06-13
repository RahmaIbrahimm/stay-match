import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_styles.dart';

import '../../../data/models/get_all_rooms.dart';

class RoomInPropertyData extends StatelessWidget {
  const RoomInPropertyData({super.key, required this.rooms,  this.scaleUp = false});

  final List<AllRooms> rooms;
  final bool scaleUp;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.r, vertical: 5.r),
      margin: EdgeInsets.symmetric(horizontal: 6.r),
      decoration: BoxDecoration(
        color: AppColors.bgGrey,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: rooms.length,
        itemBuilder: (context, roomIdx) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.secondaryLight,
                    radius: 3.r,
                  ),
                  SizedBox(width: 6.w),
                  Flexible(
                    flex: 2,
                    child: Text(
                      rooms[roomIdx].roomName ?? 'room name',
                      style: (scaleUp?AppStyles.semiBold12poppins:AppStyles.semiBold8poppins),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Spacer(),
                  rooms[roomIdx].isAvailable ?? false
                      ? Flexible(
                    flex: 1,
                          child: Text(
                            '${rooms[roomIdx].monthRent} EGP',
                            style: (scaleUp?AppStyles.semiBold12poppins:AppStyles.semiBold8poppins).copyWith(
                              color: AppColors.secondaryLight,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          ),
                        )
                      : Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.r),
                          decoration: BoxDecoration(
                            color: AppColors.bgGrey,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Text(
                            'Occupied',
                            style: (scaleUp?AppStyles.semiBold12poppins:AppStyles.regular8poppins).copyWith(
                              color: AppColors.textColorSecondary,
                            ),
                          ),
                        ),
                ],
              ),
              if (roomIdx < (rooms.length) - 1) Divider(thickness: 0.5.r),
            ],
          );
        },
      ),
    );
  }
}