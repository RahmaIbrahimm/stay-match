import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stay_match/core/routing/app_routing.dart';
import 'package:stay_match/features/home/presentation/widget/rooms_list.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_styles.dart';
import '../../../../core/widgets/custom_text_button.dart';
import '../../../properties/rooms/data/models/get_all_rooms.dart';

class RoomsSection extends StatelessWidget {
  const RoomsSection({
    super.key,
    required this.size,
    required this.roomPropertiesData,
  });

  final Size size;
  final List<RoomData>? roomPropertiesData;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.385,
      padding: EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.primary),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.discoverRooms,
                style: AppStyles.semiBold15poppins.copyWith(
                  color: AppColors.textColorPrimary,
                ),
              ),
              // todo: view all rooms text button implementation
              CustomTextButton(
                onPressed: () {
                  context.push(AppRouting.findRoomView);
                },
                text: AppStrings.viewAllRooms,
                isUnderlined: false,
                textColor: AppColors.primary,
                textStyle: AppStyles.semiBold10poppins,
                isPadded: false,
              ),
            ],
          ),

          Text(
            AppStrings.handPickedRooms,
            style: AppStyles.regular8poppins.copyWith(
              color: AppColors.textColorSecondary,
            ),
          ),
          SizedBox(height: 8),
          SizedBox(
            height: size.height * 0.3,
            child: RoomsList(
              roomPropertiesData: roomPropertiesData,
              size: size,
            ),
          ),
        ],
      ),
    );
  }
}