import 'package:flutter/material.dart';
import 'package:stay_match/Features/apartments/data/models/property_details_response.dart';

class Apartmentdetailshelper {
  static String getMonth(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }
  static List<Map<String, dynamic>> getAllAvailableAmenities(PropertyAmenities amenities) {
    return [
      if(amenities.wifi ?? false){'name': 'WiFi', 'icon': Icons.wifi, 'available': amenities.wifi, 'key': 'wifi'},
      if(amenities.tv ?? false){'name': 'TV', 'icon': Icons.tv, 'available': amenities.tv, 'key': 'tv'},
      if(amenities.cooktop ?? false){'name': 'Cooktop', 'icon': Icons.outdoor_grill, 'available': amenities.cooktop, 'key': 'cooktop'},
      if(amenities.oven?? false){'name': 'Oven', 'icon': Icons.countertops, 'available': amenities.oven, 'key': 'oven'},
      if(amenities.kettle ?? false){'name': 'Kettle', 'icon': Icons.coffee_maker, 'available': amenities.kettle, 'key': 'kettle'},
      if(amenities.dishwasher ?? false){'name': 'Dishwasher', 'icon': Icons.cleaning_services, 'available': amenities.dishwasher, 'key': 'dishwasher'},
      if(amenities.refrigerator ?? false){'name': 'Fridge', 'icon': Icons.kitchen, 'available': amenities.refrigerator, 'key': 'refrigerator'},
      if(amenities.microwave ?? false){'name': 'Microwave', 'icon': Icons.microwave, 'available': amenities.microwave, 'key': 'microwave'},
      if(amenities.washer ?? false){'name': 'Washer', 'icon': Icons.local_laundry_service, 'available': amenities.washer, 'key': 'washer'},
      if(amenities.freeParking ?? false){'name': 'Free Parking', 'icon': Icons.local_parking, 'available': amenities.freeParking, 'key': 'freeParking'},
      if(amenities.airConditioning ?? false){'name': 'Air Conditioning', 'icon': Icons.ac_unit, 'available': amenities.airConditioning, 'key': 'airConditioning'},
      if(amenities.smokeAlarm ?? false){'name': 'Smoke Alarm', 'icon': Icons.notification_important, 'available': amenities.smokeAlarm, 'key': 'smokeAlarm'},
      if(amenities.fireExtinguisher ?? false){'name': 'Fire Extinguisher', 'icon': Icons.fire_extinguisher, 'available': amenities.fireExtinguisher, 'key': 'fireExtinguisher'},
    ];
  }

  // 2. This is what you use for the "Apartment Details" view (only shows what exists).
  static List<Map<String, dynamic>> getAmenitiesWithIcons(PropertyAmenities? amenities) {
    if (amenities == null) return [];
    return getAllAvailableAmenities(amenities)
        .where((a) => a['available'] == true)
        .toList();
  }
}