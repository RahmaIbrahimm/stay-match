import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_styles.dart';
import '../../../../core/widgets/custom_toggle_switch.dart';
import 'filter_helper.dart';

class AvailabilitySliver extends StatelessWidget {
  const AvailabilitySliver({
    super.key,
    required this.current,
    required this.propertyType,
    required this.onChangedBool,
  });
  final PropertyType propertyType;
  final bool current;
  final OnChangedBool onChangedBool;

  @override
  Widget build(BuildContext context) {
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
            CustomToggleSwitch(
              current: current,
              // onTap: ()async {
              //   final cubit = context.read<FilterCubit>();
              //   final newValue = !current;
              //
              //   if (propertyType == PropertyType.apartment) {
              //     await cubit.updateApartmentFilter(onlyAvailable: newValue,forceRefresh: true);
              //   } else {
              //    await cubit.updateRoomsFilter(onlyAvailable: newValue,forceRefresh: true);
              //   }
              // },
              onChangedBool: onChangedBool
            ),
          ],
        ),
      ),
    );
  }
}