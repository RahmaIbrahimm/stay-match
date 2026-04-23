import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/core/constants/app_strings.dart';

import '../../../apartments/data/models/all_apartments.dart';
import '../../../apartments/presentation/widgets/shared/apartment_card.dart';

class ApartmentList extends StatelessWidget {
  const ApartmentList({super.key, required this.properties});

  final List<AllApartmentsItems>? properties;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return properties!.isEmpty
        ? Center(
            child: Text(
              AppStrings.noRoomsAvailable,
              style: TextStyle(fontSize: 30.sp),
            ),
          )
        : SizedBox(
            height: 320.h,
            width: double.infinity,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: properties!.length,
              itemBuilder: (context, index) {
                return ApartmentCard(property: properties?[index]);
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(width: 16.w);
              },
            ),
          );
  }
}