import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:stay_match/Features/rooms/data/models/shared_apartment_details.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_styles.dart';

import 'chip_data.dart';

class AmenitiesWrap extends StatelessWidget {
  final Amenities amenities;

  const AmenitiesWrap({super.key, required this.amenities});

  @override
  Widget build(BuildContext context) {
    final chips = <ChipData>[
      if (amenities.wifi == true) ChipData(Icons.wifi, 'High-speed Wi-Fi'),
      if (amenities.washer == true)
        ChipData(Icons.local_laundry_service, 'Washer & Dryer'),
      if (amenities.airConditioning == true)
        ChipData(Icons.ac_unit, 'Central Air'),
      if (amenities.freeParking == true)
        ChipData(Icons.local_parking, 'Free Parking'),
      if (amenities.tv == true) ChipData(Icons.tv, 'TV'),
      if (amenities.refrigerator == true)
        ChipData(Icons.kitchen, 'Refrigerator'),
      if (amenities.microwave == true) ChipData(Icons.microwave, 'Microwave'),
      if (amenities.oven == true)
        ChipData(Icons.outdoor_grill_outlined, 'Oven'),
      if (amenities.cooktop == true)
        ChipData(Icons.soup_kitchen_outlined, 'Cooktop'),
      if (amenities.dishwasher == true)
        ChipData(Icons.countertops_outlined, 'Dishwasher'),
      if (amenities.kettle == true)
        ChipData(Icons.emoji_food_beverage_outlined, 'Kettle'),
      if (amenities.smokeAlarm == true)
        ChipData(MdiIcons.smokeDetectorAlertOutline, 'Smoke Alarm'),
      if (amenities.fireExtinguisher == true)
        ChipData(Icons.fire_extinguisher_outlined, 'Fire Extinguisher'),
    ];

    if (chips.isEmpty) {
      return Text(
        'No amenities listed',
        style: AppStyles.regular14poppins.copyWith(
          color: AppColors.textColorSecondary,
        ),
      );
    }

    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: chips
          .map(
            (c) => Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.r),
                border: Border.all(color: AppColors.stroke),
                boxShadow: AppColors.elevationShadow,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(c.icon, size: 14.r, color: AppColors.primary),
                  SizedBox(width: 6.w),
                  Text(
                    c.label,
                    style: AppStyles.regular12poppins.copyWith(
                      color: AppColors.textColorPrimary,
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}