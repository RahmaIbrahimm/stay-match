import 'package:flutter/material.dart';
import '../../data/models/get_all_apartments.dart';
import 'apartment_card.dart';
class PropertyList extends StatelessWidget {
  const PropertyList({super.key, required this.properties, required this.size});

  final List<ApartmentData>? properties;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: properties!.length,
      itemBuilder: (context, index) {
        return PropertyCard(size: size, property: properties?[index]);
      },
    );
  }
}