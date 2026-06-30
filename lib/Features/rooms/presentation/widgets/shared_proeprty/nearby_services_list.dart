import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/Features/rooms/data/models/shared_apartment_details.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_styles.dart';

import 'chip_data.dart';

class NearbyServicesList extends StatelessWidget {
  final NearbyServices services;

  const NearbyServicesList({required this.services});

  @override
  Widget build(BuildContext context) {
    final list = <ChipData>[
      if (services.hasPublicTransport == true)
        ChipData(Icons.directions_transit, 'Public Transport'),
      if (services.hasGroceryStore == true)
        ChipData(Icons.local_grocery_store_outlined, 'Grocery Store'),
      if (services.hasPharmacy == true)
        ChipData(Icons.local_pharmacy_outlined, 'Pharmacy'),
      if (services.hasHospital == true)
        ChipData(Icons.local_hospital_outlined, 'Hospital'),
      if (services.hasSchool == true) ChipData(Icons.school_outlined, 'School'),
      if (services.hasUniversity == true)
        ChipData(Icons.account_balance_outlined, 'University'),
      if (services.hasParking == true) ChipData(Icons.local_parking, 'Parking'),
      if (services.hasMall == true)
        ChipData(Icons.shopping_bag_outlined, 'Mall'),
      if (services.hasRestaurants == true)
        ChipData(Icons.restaurant_outlined, 'Restaurants'),
      if (services.hasPark == true) ChipData(Icons.park_outlined, 'Park'),
      if (services.hasGym == true) ChipData(Icons.fitness_center, 'Gym'),
      if (services.isSafeArea == true)
        ChipData(Icons.shield_outlined, 'Safe Area'),
      if (services.hasPoliceStation == true)
        ChipData(Icons.local_police_outlined, 'Police Station'),
      if (services.isQuietArea == true)
        ChipData(Icons.volume_off_outlined, 'Quiet Area'),
      if (services.hasMosqueNearby == true)
        ChipData(Icons.mosque_outlined, 'Mosque Nearby'),
      if (services.hasChurchNearby == true)
        ChipData(Icons.church_outlined, 'Church Nearby'),
    ];

    if (list.isEmpty) {
      return Text(
        'No nearby services listed',
        style: AppStyles.regular14poppins.copyWith(
          color: AppColors.textColorSecondary,
        ),
      );
    }

    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: list
          .map(
            (e) => Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: AppColors.blueGrey,
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(e.icon, size: 16.r, color: AppColors.primary),
                  SizedBox(width: 8.w),
                  Text(
                    e.label,
                    style: AppStyles.regular14poppins.copyWith(
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