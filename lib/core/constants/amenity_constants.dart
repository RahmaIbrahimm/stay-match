import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../Features/add_property/presentation/widgets/amenenities_and_services_widgets/Amenity_item.dart';

class AmenityConstants {
  static  List<AmenityItem> amenities = [
    AmenityItem(label: 'Wi-Fi', icon: MdiIcons.wifi, apiKey: 'wifi'),
    AmenityItem(label: 'TV', icon: MdiIcons.television, apiKey: 'tv'),
    AmenityItem(label: 'Cooktop', icon: MdiIcons.stove, apiKey: 'cooktop'),
    AmenityItem(label: 'Oven', icon: MdiIcons.stove, apiKey: 'oven'),
    AmenityItem(label: 'Kettle', icon: MdiIcons.kettle, apiKey: 'kettle'),
    AmenityItem(label: 'Dishwasher', icon: MdiIcons.dishwasher, apiKey: 'dishwasher'),
    AmenityItem(label: 'Fridge', icon: MdiIcons.fridge, apiKey: 'refrigerator'),
    AmenityItem(label: 'Microwave', icon: MdiIcons.microwave, apiKey: 'microwave'),
    AmenityItem(label: 'Washer', icon: MdiIcons.washingMachine, apiKey: 'washer'),
    AmenityItem(label: 'Free Parking', icon: MdiIcons.parking, apiKey: 'freeParking'),
    AmenityItem(label: 'Air Conditioning', icon: MdiIcons.snowflake, apiKey: 'airConditioning'),
    AmenityItem(label: 'Smoke Alarm', icon: MdiIcons.fireAlert, apiKey: 'smokeAlarm'),
    AmenityItem(label: 'Fire Extinguisher', icon: MdiIcons.fireExtinguisher, apiKey: 'fireExtinguisher'),
  ];

  static  List<AmenityItem> nearbyServices = [
    AmenityItem(label: 'Grocery', icon: MdiIcons.cart, apiKey: 'hasGroceryStore'),
    AmenityItem(label: 'Pharmacy', icon: MdiIcons.pill, apiKey: 'hasPharmacy'),
    AmenityItem(label: 'Hospital', icon: MdiIcons.hospitalBuilding, apiKey: 'hasHospital'),
    AmenityItem(label: 'School', icon: MdiIcons.school, apiKey: 'hasSchool'),
    AmenityItem(label: 'University', icon: MdiIcons.townHall, apiKey: 'hasUniversity'),
    AmenityItem(label: 'Transport', icon: MdiIcons.bus, apiKey: 'hasPublicTransport'),
    AmenityItem(label: 'Parking', icon: MdiIcons.parking, apiKey: 'hasParking'),
    AmenityItem(label: 'Mall', icon: MdiIcons.shopping, apiKey: 'hasMall'),
    AmenityItem(label: 'Restaurants', icon: MdiIcons.silverwareForkKnife, apiKey: 'hasRestaurants'),
    AmenityItem(label: 'Park', icon: MdiIcons.tree, apiKey: 'hasPark'),
    AmenityItem(label: 'Gym', icon: MdiIcons.dumbbell, apiKey: 'hasGym'),
    AmenityItem(label: 'Safe Area', icon: MdiIcons.shieldCheck, apiKey: 'isSafeArea'),
    AmenityItem(label: 'Police', icon: MdiIcons.policeBadge, apiKey: 'hasPoliceStation'),
    AmenityItem(label: 'Quiet Area', icon: MdiIcons.volumeMute, apiKey: 'isQuietArea'),
    AmenityItem(label: 'Church', icon: MdiIcons.church, apiKey: 'hasChurchNearby'),
    AmenityItem(label: 'Mosque', icon: MdiIcons.mosque, apiKey: 'hasMosqueNearby'),
  ];
}