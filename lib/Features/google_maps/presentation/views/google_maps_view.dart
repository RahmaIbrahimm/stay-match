import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/constants/app_styles.dart';
import '../../../../../core/widgets/custom_text_button.dart';
import '../widgets/maps_helper.dart';

// Simple Enum for Map Context (defined locally for simplicity)
class GoogleMapsView extends StatefulWidget {
  const GoogleMapsView({
    super.key,
    this.initialLatitude,
    this.initialLongitude,
    this.onLocationSelected,
    this.mapContext = MapContext.picker,
    this.mapView = MapViewType.fullView, // Default to showing AppBar
  });

  // Coordinates to show initially (can be null for default)
  final double? initialLatitude;
  final double? initialLongitude;
  final MapViewType mapView; // New parameter to control AppBar
  // Callback when a location is picked (only for MapContext.picker)
  final void Function(LatLng)? onLocationSelected;

  // Is this map for picking a location or just viewing?
  final MapContext mapContext;

  @override
  State<GoogleMapsView> createState() => _GoogleMapsViewState();
}

class _GoogleMapsViewState extends State<GoogleMapsView> {
  // Use non-nullable controller for simpler code once initialized
  late GoogleMapController _controller;
  late LatLng _currentLocation;
  final Set<Marker> _markers = {};
  bool _isControllerReady = false;

  // Default Fallback (Cairo Center)
  static const LatLng _cairoDefault = LatLng(30.0501, 31.2397);
  static const double _zoomLevel = 15.0;

  @override
  void initState() {
    super.initState();
    // Initialize the starting location
    _currentLocation = LatLng(
      widget.initialLatitude ?? _cairoDefault.latitude,
      widget.initialLongitude ?? _cairoDefault.longitude,
    );
    _initializeMarker();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // --- Crucial Fix: Handle Data Updates (e.g., API Success state) ---
  @override
  void didUpdateWidget(covariant GoogleMapsView oldWidget) {
    super.didUpdateWidget(oldWidget);

    // If the coordinates passed in from parent changed...
    if (widget.initialLatitude != oldWidget.initialLatitude ||
        widget.initialLongitude != oldWidget.initialLongitude) {

      final newPos = LatLng(
        widget.initialLatitude ?? _cairoDefault.latitude,
        widget.initialLongitude ?? _cairoDefault.longitude,
      );

      // 1. Update internal state
      _currentLocation = newPos;
      _initializeMarker();

      // 2. Snap camera to new position (instantly, use moveCamera)
      if (_isControllerReady) {
        _controller.moveCamera(CameraUpdate.newLatLng(newPos));
        log('Map snapped to new coordinates: ${newPos.latitude}, ${newPos.longitude}');
      }
    }
  }

  // Set up the marker object based on the context
  void _initializeMarker() {
    final bool isStatic = widget.mapContext == MapContext.staticView;
    // Safety check for setState if needed
    void safeUpdate() {
      if (mounted) setState(() {});
    }

    _markers.clear();
    _markers.add(
      Marker(
        markerId: const MarkerId('selected-location'),
        position: _currentLocation,

        // --- THIS LOCKS THE MARKER DOWN ---
        draggable: !isStatic,

        // If static, no callback. If picker, handle drag end.
        onDragEnd: isStatic ? null : (LatLng newPosition) {
          _currentLocation = newPosition;
          _initializeMarker(); // Redraw marker with new color/shape if needed
          widget.onLocationSelected?.call(newPosition);
          log('Marker dragged to: ${newPosition.latitude}, ${newPosition.longitude}');
        },
      ),
    );
    safeUpdate();
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
    _isControllerReady = true;

    // Optional: Snap to location immediately on creation if initial coordinates were provided
    if (widget.initialLatitude != null && widget.initialLongitude != null) {
      _controller.moveCamera(CameraUpdate.newLatLng(_currentLocation));
      log('Map created and moved to initial position.');
    }
  }

  // Handle Tap events only in Picker Mode
  void _onMapTap(LatLng position) {
    if (widget.mapContext == MapContext.staticView) return;

    _currentLocation = position;
    _initializeMarker();
    _controller.animateCamera(CameraUpdate.newLatLng(position));
    widget.onLocationSelected?.call(position);
    log('Map tapped, new location: ${position.latitude}, ${position.longitude}');
  }

  @override
  Widget build(BuildContext context) {
    final bool isStatic = widget.mapContext == MapContext.staticView;
    final bool isPartial = widget.mapView == MapViewType.partialView;
    return Scaffold(
      backgroundColor: isStatic ? Colors.transparent : Colors.white,

      // 1. App Bar (Only in Picker Mode)
      appBar: isPartial ? null : _buildPickerAppBar(),
      // 2. Google Map Body
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _currentLocation,
          zoom: _zoomLevel,
        ),
        markers: _markers,

        // --- THIS LOCKS THE MAP DOWN (Static Controls) ---
        onTap: isStatic ? null : _onMapTap,
        // scrollGesturesEnabled: !isStatic,
        // zoomGesturesEnabled: !isStatic,
        // rotateGesturesEnabled: !isStatic,
        // tiltGesturesEnabled: !isStatic,

        // Hide UI elements in static mode for a clean preview
        myLocationEnabled: !isStatic,
        myLocationButtonEnabled: !isStatic,
        // zoomControlsEnabled: !isStatic,
        mapToolbarEnabled: !isStatic,
      ),
    );
  }

  PreferredSizeWidget _buildPickerAppBar() {
    return AppBar(
      backgroundColor: AppColors.containerColor,
      elevation: 1,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => context.pop(), // GoRouter context.pop
      ),
      title: Text(
        'Select Location',
        style: AppStyles.semiBold18poppins.copyWith(color: Colors.black),
      ),
      actions: [
        CustomTextButton(
          onPressed: () {
            // Returns selected LatLng to the previous screen
            context.pop(_currentLocation);
          },
          textColor: AppColors.primary,
          textStyle: AppStyles.medium15poppins,
          text: AppStrings.confirm, // Ensure this exists in AppStrings
        ),
      ],
      actionsPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 16, 0),
    );
  }
}