import 'package:flutter/material.dart';

import '../../data/models/get_all_apartments.dart';
import 'apartment_card.dart';

class PropertyList extends StatelessWidget {
  const PropertyList({super.key, required this.properties, required this.size});

  final List<Items>? properties;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return properties!.isEmpty
        ? Center(
            child: Text('No rooms available', style: TextStyle(fontSize: 30)),
          )
        : ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: properties!.length,
            itemBuilder: (context, index) {
              return PropertyCard(size: size, property: properties?[index]);
            },
          );
  }
}