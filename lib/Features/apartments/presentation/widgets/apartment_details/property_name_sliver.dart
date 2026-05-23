import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/core/widgets/heart_favourite_button.dart';

import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/constants/app_styles.dart';

class PropertyNameAndFavButtonSliver extends StatelessWidget {
  const PropertyNameAndFavButtonSliver(
      {super.key, required this.name, required this.id, required this.initialSavedStatus, required this.scaleUp});

  final String? name;
  final int id;
  final bool initialSavedStatus;
  final bool scaleUp;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: RPadding(
        padding: EdgeInsets.only(right: 16.r, left: 16.r, top: 24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Expanded(
              flex: 4,
              child: Text(
                name ?? AppStrings.propertyName,
                style: AppStyles.bold24poppins,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(child: HeartFavoriteButton(id: id,
                initialSavedStatus: initialSavedStatus,
                scaleUp: scaleUp))
            // Expanded(
            //   flex: 1,
            //   child: Icon(
            //     Icons.favorite_outline_rounded,
            //     size: 24.sp,
            //     weight: 2,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}