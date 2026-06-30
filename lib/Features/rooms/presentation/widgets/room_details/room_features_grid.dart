import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/Features/rooms/data/models/room_details_response.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_styles.dart';

import 'feature_item.dart';

class RoomFeaturesGrid extends StatelessWidget {
  final RoomDetailsResponseData data;

  const RoomFeaturesGrid({required this.data});

  @override
  Widget build(BuildContext context) {
    final features = <FeatureItem>[];

    // Bathroom
    if (data.enSuiteBathroom == true)
      features.add(FeatureItem(Icons.bathtub_outlined, 'En-suite Bathroom'));
    if (data.sharedBathroom == true)
      features.add(FeatureItem(Icons.bathroom_outlined, 'Shared Bathroom'));

    // Physical features
    if (data.balcony == true)
      features.add(FeatureItem(Icons.deck_outlined, 'Private Balcony'));
    if (data.window == true)
      features.add(FeatureItem(Icons.window_outlined, 'Large Window'));

    // Amenities from model
    if (data.amenities?.airConditioning == true)
      features.add(FeatureItem(Icons.ac_unit, 'Central AC'));
    if (data.amenities?.closet == true)
      features.add(FeatureItem(Icons.checkroom_outlined, 'Walk-in Closet'));
    if (data.amenities?.fan == true)
      features.add(FeatureItem(Icons.mode_fan_off_outlined, 'Fan'));
    if (data.amenities?.mirror == true)
      features.add(FeatureItem(Icons.light_outlined, 'Mirror'));

    // Pets
    if (data.petsAllowed == true)
      features.add(FeatureItem(Icons.pets, 'Pets Allowed'));

    // Furnished
    if (data.furnished == true)
      features.add(FeatureItem(Icons.chair_outlined, 'Furnished'));

    if (features.isEmpty) {
      return Text(
        'No features listed',
        style: AppStyles.regular14poppins.copyWith(
          color: AppColors.textColorSecondary,
        ),
      );
    }

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 10.h,
      crossAxisSpacing: 10.w,
      childAspectRatio: 2.4,
      children: features
          .map(
            (f) => Container(
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: AppColors.stroke),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(f.icon, size: 18.r, color: AppColors.primary),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      f.label,
                      style: AppStyles.regular14poppins.copyWith(
                        color: AppColors.textColorPrimary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
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