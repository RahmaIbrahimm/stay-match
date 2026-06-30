import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_styles.dart';

import '../../../../../core/routing/app_routing.dart';
import '../../../../google_maps/presentation/views/google_maps_view.dart';
import '../../../../google_maps/presentation/widgets/maps_helper.dart';

class MapSection extends StatelessWidget {
  final double latitude;
  final double longitude;
  final String? city;
  final String? government;

  const MapSection({
    super.key,
    required this.latitude,
    required this.longitude,
    this.city,
    this.government,
  });

  @override
  Widget build(BuildContext context) {
    final locationLabel = [
      city,
      government,
    ].where((e) => e != null && e.isNotEmpty).join(', ');

    return GestureDetector(
      onTap: () {
        context.pushNamed(
          AppRouting.googleMapsViewName,
          queryParameters: {
            'latitude': latitude.toString(),
            'longitude': longitude.toString(),
            'isStatic': 'true',
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColors.stroke),
          boxShadow: AppColors.elevationShadow,
        ),
        clipBehavior: Clip.hardEdge,
        child: Column(
          children: [
            SizedBox(
              height: 150.h,
              child: IgnorePointer(
                child: GoogleMapsView(
                  initialLatitude: latitude,
                  initialLongitude: longitude,
                  mapContext: MapContext.staticView,
                  mapView: MapViewType.partialView,
                ),
              ),
            ),
            if (locationLabel.isNotEmpty)
              Padding(
                padding: EdgeInsets.all(14.r),
                child: Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 16.r,
                      color: AppColors.primary,
                    ),
                    SizedBox(width: 6.w),
                    Expanded(
                      child: Text(
                        locationLabel,
                        style: AppStyles.semiBold14poppins.copyWith(
                          color: AppColors.textColorPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}