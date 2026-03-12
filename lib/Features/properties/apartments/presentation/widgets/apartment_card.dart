import 'package:flutter/material.dart';
import 'package:stay_match/features/properties/presentation/widgets/card_cover_photo.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../data/models/get_all_apartments.dart';
import 'apartment_Brief_Info_container.dart';

class PropertyCard extends StatelessWidget {
  const PropertyCard({
    super.key,
    required this.size,
    required this. property,
  });

  final Size size;
  final Items? property;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.42,
      margin: const EdgeInsets.only(right: 12, top: 12),
      decoration: BoxDecoration(
        color: AppColors.containerColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: AppColors.elevationShadow,
      ),
      child: Column(
        children: [
          // todo: add rating and match percent
          CardCoverPhoto(
            size: size,
            imageUrl:  property?.coverImageUrl,
          ),
          PropertyBriefInfoContainer(
            size: size,
            name: property?.name,
            city:  property?.city,
            streetName:  property?.street,
            monthlyRent:  property?.monthlyRent, isFurnished: property!.furnished!,
          ),
        ],
      ),
    );
  }
}