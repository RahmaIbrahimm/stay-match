import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stay_match/Features/google_maps/presentation/widgets/maps_helper.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_strings.dart';
import 'package:stay_match/core/widgets/custom_text_button.dart';

import '../../../../core/constants/app_styles.dart';

class GoogleMapsView extends StatefulWidget {
  GoogleMapsView({
    super.key,
    this.initialLatitude,
    this.initialLongitude,
    this.onLocationSelected,
    this.mapView = MapViewType.fullView,
  });

  final double? initialLatitude;
  final double? initialLongitude;
  final void Function(LatLng)? onLocationSelected;
  MapViewType mapView;

  @override
  State<GoogleMapsView> createState() => _GoogleMapsViewState();
}

class _GoogleMapsViewState extends State<GoogleMapsView> {
  late GoogleMapController _controller;
  late LatLng _selectedLocation;

  static const LatLng _defaultLocation = LatLng(
    30.050078294863415,
    31.239694447194505,
  );

  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _selectedLocation = LatLng(
      widget.initialLatitude ?? _defaultLocation.latitude,
      widget.initialLongitude ?? _defaultLocation.longitude,
    );
    _updateMarker();
  }

  @override
  void dispose() {
    _controller.dispose();
    log(_controller.mapId.toString());
    super.dispose();
  }

  void _updateMarker() {
    _markers.clear();
    _markers.add(
      Marker(
        markerId: const MarkerId('selected-location'),
        position: _selectedLocation,
        draggable: true,
        onDragEnd: (newPosition) {
          setState(() {
            _selectedLocation = newPosition;
            _updateMarker();
          });
          widget.onLocationSelected?.call(newPosition);
        },
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
  }

  void _onMapTap(LatLng position) {
    setState(() {
      _selectedLocation = position;
      _updateMarker();
    });

    _controller.animateCamera(CameraUpdate.newLatLng(position));

    widget.onLocationSelected?.call(position);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.mapView == MapViewType.partialView
          ? null
          : AppBar(
              title: Text(
                'Select Location',
                style: AppStyles.semiBold18poppins,
              ),
              actions: [
                CustomTextButton(
                  onPressed: () {
                    context.pop(_selectedLocation);
                  },
                  isUnderlined: false,
                  textColor: AppColors.textColorPrimary,
                  textStyle: AppStyles.medium15poppins,
                  text: AppStrings.confirm,
                ),
              ],
        actionsPadding: EdgeInsets.symmetric(horizontal: 12.r),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _selectedLocation,
          zoom: 15,
        ),
        markers: _markers,
        onTap: _onMapTap,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        zoomControlsEnabled: true,
        mapToolbarEnabled: true,
      ),
    );
  }
}