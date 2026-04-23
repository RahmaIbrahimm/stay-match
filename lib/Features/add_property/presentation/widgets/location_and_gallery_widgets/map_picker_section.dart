import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/constants/app_styles.dart';
import '../../../../../core/routing/app_routing.dart';
import '../../../../google_maps/presentation/views/google_maps_view.dart';
import '../../../../google_maps/presentation/widgets/maps_helper.dart';
import '../shared/section_header.dart';

class MapPickerSection extends StatelessWidget {
  final double? latitude;
  final double? longitude;
  final ValueChanged<LatLng> onLocationSelected;

  const MapPickerSection({
    super.key,
    this.latitude,
    this.longitude,
    required this.onLocationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SliverMainAxisGroup(
      slivers: [
        SliverToBoxAdapter(child: SectionHeader(title: AppStrings.mapPicker)),
        SliverToBoxAdapter(child: SizedBox(height: 16.h)),
        SliverToBoxAdapter(
          child: GestureDetector(
            onDoubleTap: () {
              context.pushNamed(
                AppRouting.googleMapsViewName,
                queryParameters: {
                  'latitude': (latitude != null && latitude != 0)
                      ? 30.0444.toString()
                      : latitude.toString(),
                  'longitude': (longitude != null && longitude != 0)
                      ? 31.2357.toString()
                      : longitude.toString(),
                  'isStatic': 'false',
                },
                extra: onLocationSelected,
              );
            },
            child: Container(
              clipBehavior: Clip.antiAlias,
              height: 180.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.2),
                ),
              ),
              child: GoogleMapsView(
                key: ValueKey('$latitude-$longitude'),
                mapView: MapViewType.partialView,
                initialLatitude: (latitude != null && latitude != 0)
                    ? 30.0444
                    : latitude,
                initialLongitude: (longitude != null && longitude != 0)
                    ? 31.2357
                    : longitude,
                mapContext: MapContext.picker,
                onLocationSelected: onLocationSelected,
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: _buildCoordinatesDisplay(lat: latitude, lng: longitude),
        ),
      ],
    );
  }

  Widget _buildCoordinatesDisplay({double? lat, double? lng}) {
    return Padding(
      padding: EdgeInsets.only(top: 16.h),
      child: Row(
        children: [
          Expanded(
            child: _buildCoordinateItem(
              label: AppStrings.latitude.toUpperCase(),
              value: (lat != null && lat != 0)
                  ? "${lat.toStringAsFixed(4)}° N"
                  : "30.0444° N",
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: _buildCoordinateItem(
              label: AppStrings.longitude.toUpperCase(),
              value: (lng != null && lng != 0)
                  ? "${lng.toStringAsFixed(4)}° E"
                  : "31.2357° E",
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCoordinateItem({required String label, required String value}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.1),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: AppStyles.bold12poppins.copyWith(
              color: AppColors.textColorSecondary,
              letterSpacing: 1.1,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            value,
            style: AppStyles.medium18poppins.copyWith(
              color: AppColors.textColorPrimary,
            ),
          ),
        ],
      ),
    );
  }
}