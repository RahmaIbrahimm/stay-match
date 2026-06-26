import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/core/widgets/heart_favourite_button.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_styles.dart';
import '../../saved/presentation/manager/saved_properties_cubit.dart';

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
              scaleUp: scaleUp, type: SavedItemType.wholeApartment,))
          ],
        ),
      ),
    );
  }
}