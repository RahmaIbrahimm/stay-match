import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../shared/widgets/card_cover_photo.dart';
import '../../../data/models/all_apartments.dart';
import 'apartment_brief_Info_container.dart';

class ApartmentCard extends StatelessWidget {
  const ApartmentCard({
    super.key,
    this.property,
    this.height,
    this.scaleUp = false,
  });

  final AllApartmentsItems? property;
  final double? height;
  final bool scaleUp;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200.h,
      child: Column(
        children: [
          SizedBox(
            height: scaleUp?160.h: 135.h,
            child: CardCoverPhoto(imageUrl: property?.coverImageUrl),
          ),
          SizedBox(
            height: scaleUp?220.h:180.h,
            child: ApartmentBriefInfoContainer(
              name: property?.name,
              city: property?.city,
              streetName: property?.street,
              monthlyRent: property?.monthlyRent,
              isFurnished: property?.furnished ?? false,
              id: property?.id,
              scaleUp: scaleUp,
            ),
          ),
        ],
      ),
    );
  }
}