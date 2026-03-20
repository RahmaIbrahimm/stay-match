import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/widgets/build_feature.dart';
import '../../../data/models/apartment_details_response.dart';
class BasicFeaturesSliver extends StatelessWidget {
  const BasicFeaturesSliver({
    super.key,
    required this.details,
    required this.numBeds,
    required this.numBathrooms,
  });

  final ApartmentDetailsData? details;
  final num numBeds;
  final int numBathrooms;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: RPadding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Container(
                width: 85.sp,
                padding: EdgeInsets.all(16.r),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.containerColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: BuildFeature(
                  icon: FontAwesome.couch_solid,
                  text: details?.furnished ?? false
                      ? 'Furnished'
                      : 'Unfurnished',
                ),
              ),
            ),
            // Beds
            Flexible(
              child: Container(
                width: 85.sp,
                padding: EdgeInsets.all(16.r),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.containerColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: BuildFeature(
                  icon: FontAwesome.bed_solid,
                  text: '$numBeds ${numBeds > 1 ? 'Beds' : 'Bed'}',
                  size: 24,
                ),
              ),
            ),
            // bathrooms
            Flexible(
              child: Container(
                width: 85.sp,
                padding: EdgeInsets.all(12.r),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.containerColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: BuildFeature(
                  icon: FontAwesome.bath_solid,
                  text: '$numBathrooms ${numBathrooms > 1 ? 'Baths' : 'Baths'}',
                ),
              ),
            ),
            //  Area
            Flexible(
              child: Container(
                width: 85.sp,
                padding: EdgeInsets.all(16.r),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.containerColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: BuildFeature(
                  icon: FontAwesome.ruler_solid,
                  text: '${details?.size} m²',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}