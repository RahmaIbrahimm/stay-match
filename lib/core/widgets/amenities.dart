import 'package:flutter/material.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_styles.dart';

class Amenities extends StatelessWidget {
  const Amenities({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      margin: EdgeInsets.only(left: 3, top: 8, bottom: 2),
      decoration: BoxDecoration(
        color: AppColors.bgGrey,
        borderRadius: BorderRadius.circular(5),
      ),
      //todo: add list/ whatever the hint for what's available for this property
      child: Text(
        'Furnished',
        style: AppStyles.regular8poppins.copyWith(
          color: AppColors.textColorSecondary,
        ),
      ),
    );
  }
}