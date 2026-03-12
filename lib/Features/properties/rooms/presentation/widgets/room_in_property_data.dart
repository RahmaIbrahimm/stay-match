import 'package:flutter/material.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_styles.dart';

class RoomInPropertyData extends StatelessWidget {
  const RoomInPropertyData({
    super.key,
    required this.numOfRooms,
    required this.monthRent,
  });

  final int? numOfRooms;
  final num? monthRent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
      margin: EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: AppColors.bgGrey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(numOfRooms ?? 0, (roomIdx) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.secondaryLight,
                    radius: 3,
                  ),
                  SizedBox(width: 6),
                  Text(
                    'Room ${roomIdx + 1}',
                    style: AppStyles.semiBold8poppins.copyWith(
                      color: AppColors.textColorPrimary,
                    ),
                  ),
                  Spacer(),
                  Text(
                    '${monthRent ?? 0} EGP',
                    style: AppStyles.semiBold8poppins.copyWith(
                      color: AppColors.secondaryLight,
                    ),
                  ),
                ],
              ),
              if (roomIdx < (numOfRooms ?? 0) - 1) Divider(thickness: 0.5),
            ],
          );
        }),
      ),
    );
  }
}