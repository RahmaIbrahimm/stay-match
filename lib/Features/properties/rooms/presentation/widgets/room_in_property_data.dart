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
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 5),
      margin: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: AppColors.bgGrey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 55),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: numOfRooms ?? 0,
          itemBuilder: (context, roomIdx) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColors.secondaryLight,
                      radius: 3,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Room ${roomIdx + 1}',
                      style: AppStyles.semiBold8poppins,
                    ),
                    const Spacer(),
                    Text(
                      '$monthRent EGP',
                      style: AppStyles.semiBold8poppins.copyWith(
                        color: AppColors.secondaryLight,
                      ),
                    ),
                  ],
                ),
                if (roomIdx < (numOfRooms ?? 0) - 1)
                  const Divider(thickness: 0.5),
              ],
            );
          },
        ),
      ),
    );
  }
}