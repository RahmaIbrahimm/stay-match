import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/app_styles.dart';
class PropertyNameSliver extends StatelessWidget {
  const PropertyNameSliver({
    super.key,
   required this.name,
  });

  final String? name;
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
                name ?? 'Property name',
                style: AppStyles.bold24poppins,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              flex: 1,
              child: Icon(
                Icons.favorite_outline_rounded,
                size: 24.sp,
                weight: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}