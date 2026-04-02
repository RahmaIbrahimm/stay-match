import 'package:flutter/material.dart';
import 'package:stay_match/Features/apartments/data/models/apartment_details_response.dart';

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

  static List<Map<String, dynamic>> getAmenitiesWithIcons(
    ApartmentAmenities? amenities,
  ) {
    if (amenities == null) return [];
    //fixme: add proper icons
    List<Map<String, dynamic>> allAmenities = [
      {'name': 'WiFi', 'icon': Icons.wifi, 'available': amenities.wifi},
      {'name': 'TV', 'icon': Icons.tv, 'available': amenities.tv},
      {'name': 'Cooktop', 'icon': Icons.tv, 'available': amenities.cooktop},
      {'name': 'Oven', 'icon': Icons.tv, 'available': amenities.oven},
      {'name': 'Kettle', 'icon': Icons.tv, 'available': amenities.kettle},
      {
        'name': 'Dishwasher',
        'icon': Icons.tv,
        'available': amenities.dishwasher,
      },
      {
        'name': 'Fridge',
        'icon': Icons.kitchen,
        'available': amenities.refrigerator,
      },
      {
        'name': 'Microwave',
        'icon': Icons.microwave,
        'available': amenities.microwave,
      },
      {'name': 'Washer', 'icon': Icons.wash, 'available': amenities.washer},
      {
        'name': 'Free Parking',
        'icon': Icons.local_parking,
        'available': amenities.freeParking,
      },
      {
        'name': 'Air Conditioning',
        'icon': Icons.ac_unit,
        'available': amenities.airConditioning,
      },
      {
        'name': 'Smoke Alarm',
        'icon': Icons.smoke_free,
        'available': amenities.smokeAlarm,
      },
      {
        'name': 'Fire Extinguisher',
        'icon': Icons.fire_extinguisher,
        'available': amenities.fireExtinguisher,
      },
    ];

    return allAmenities.where((a) => a['available'] == true).toList();
  }
}