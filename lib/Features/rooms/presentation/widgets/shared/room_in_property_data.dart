import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_styles.dart';

import '../../../data/models/get_all_rooms.dart';

class RoomInPropertyData extends StatelessWidget {
  const RoomInPropertyData({super.key, required this.rooms});

  final List<AllRooms> rooms;

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
                    child: Text(
                      rooms[roomIdx].roomName ?? 'room name',
                      style: AppStyles.semiBold8poppins,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Spacer(),
                  rooms[roomIdx].isAvailable ?? false
                      ? Flexible(
                          child: Text(
                            '${rooms[roomIdx].monthRent} EGP',
                            style: AppStyles.semiBold8poppins.copyWith(
                              color: AppColors.secondaryLight,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
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
                            style: AppStyles.regular8poppins.copyWith(
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