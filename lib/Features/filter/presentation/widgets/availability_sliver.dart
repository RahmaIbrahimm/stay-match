import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/features/filter/data/models/apartment_filter_params.dart';
import 'package:stay_match/features/filter/data/models/rooms_filter_params.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_styles.dart';
import '../../../../core/widgets/custom_toggle_switch.dart';
import 'filter_helper.dart';

class AvailabilitySliver extends StatelessWidget {
  const AvailabilitySliver({super.key, required this.current, required this.filterType});
  final FilterTypeProperty filterType;
  final bool current;
  @override
  Widget build(BuildContext context) {
    // var _tempFilters = filterType == FilterType.apartment ? ApartmentFilterParams() : RoomsFilterParams();
    return SliverToBoxAdapter(
      child: RPadding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Availability',
                    style: AppStyles.semiBold18poppins.copyWith(
                      color: AppColors.textColorPrimary,
                    ),
                  ),
                  TextSpan(
                    text: '\nShow only available units',
                    style: AppStyles.regular14poppins.copyWith(
                      color: AppColors.textColorSecondary,
                    ),
                  ),
                ],
              ),
            ),
            // todo: implement filtering for availability
            CustomToggleSwitch(onTap: () {},current:current),
          ],
        ),
      ),
    );
  }
}