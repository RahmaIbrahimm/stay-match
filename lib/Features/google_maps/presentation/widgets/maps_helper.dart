import 'package:google_maps_flutter/google_maps_flutter.dart';
enum MapViewType {
  partialView,
  fullView
}
class MapsHelper {
  static Future<void> updateCameraPosition(
    LatLng latLng,
    GoogleMapController? controller,
  ) async {
    await controller?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: latLng, zoom: 15),
      ),
    );
  }
}