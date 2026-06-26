import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:stay_match/Features/rooms/data/models/shared_apartment_details.dart';
import 'package:stay_match/Features/rooms/data/repos/rooms_repo_impl.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_styles.dart';
import 'package:stay_match/core/utils/service_locator.dart';
import 'package:stay_match/core/widgets/custom_elevated_button.dart';
import 'package:stay_match/core/widgets/draggable_chatbot_fab.dart';
import 'package:stay_match/core/widgets/heart_favourite_button.dart';

class StatsGrid extends StatelessWidget {
  final SharedApartmentDetailsData data;
  final String rentLabel;
  final int roomCount;

  const StatsGrid({
    required this.data,
    required this.rentLabel,
    required this.roomCount,
  });

  @override
  Widget build(BuildContext context) {
    final cells = [
      StatData(Icons.straighten, '${data.size ?? 0} m²', 'Total Area'),
      StatData(Icons.monetization_on_outlined, rentLabel, 'Rent (EGP)'),
      StatData(Icons.bed_outlined, '$roomCount Rooms', 'Available'),
      StatData(Icons.meeting_room_outlined, '$roomCount Rooms', 'Total Rooms'),
      if (data.minimumStay != null)
        StatData(
          Icons.calendar_today_outlined,
          '${data.minimumStay} mo',
          'Min. Stay',
        ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: cells.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10.h,
        crossAxisSpacing: 10.w,
        childAspectRatio: 1.5,
      ),
      itemBuilder: (_, i) => StatCell(s: cells[i]),
    );
  }
}

class StatData {
  final IconData icon;
  final String value;
  final String label;

  const StatData(this.icon, this.value, this.label);
}

class StatCell extends StatelessWidget {
  final StatData s;

  const StatCell({required this.s});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        color: AppColors.secondaryScaffBg,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.stroke),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(s.icon, size: 20.r, color: AppColors.primary),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  s.label,
                  style: AppStyles.semiBold14poppins.copyWith(
                    color: AppColors.textColorPrimary,
                  ),
                ),
                Text(
                  s.value,
                  style: AppStyles.medium12poppins.copyWith(
                    color: AppColors.textColorSecondary,
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