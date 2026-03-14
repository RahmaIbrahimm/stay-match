import 'package:flutter/material.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_styles.dart';

import '../../data/models/get_all_rooms.dart';


class RoomInPropertyData extends StatelessWidget {
  const RoomInPropertyData({super.key, required this.rooms});

  final List<Rooms> rooms;

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
          itemCount: rooms.length,
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
                      '${rooms[roomIdx].monthRent} EGP',
                      style: AppStyles.semiBold8poppins.copyWith(
                        color: AppColors.secondaryLight,
                      ),
                    ),
                  ],
                ),
                if (roomIdx < (rooms.length) - 1)
                  const Divider(thickness: 0.5),
              ],
            );
          },
        ),
      ),
    );
  }
}