import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/constants/app_styles.dart';
import '../../../../../core/widgets/custom_drop_down_menu.dart';
import '../../../../filter/data/models/location_model.dart';
import '../../../../filter/presentation/manager/location_cubit.dart';
import '../shared/section_header.dart';

class AddressDetailsSection extends StatelessWidget {
  final Governorate? selectedGovernorate;
  final City? selectedCity;
  final ValueChanged<Governorate?> onGovernorateChanged;
  final ValueChanged<City?> onCityChanged;
  final Color? strokeColor;
  final Color? fillColor;
  const AddressDetailsSection({
    super.key,
    this.selectedGovernorate,
    this.selectedCity,
    required this.onGovernorateChanged,
    required this.onCityChanged,
    this.strokeColor,
    this.fillColor,
  });

  @override
  Widget build(BuildContext context) {
    final locationCubit = context.read<LocationCubit>();

    return SliverMainAxisGroup(
      slivers: [
        SliverToBoxAdapter(
          child: SectionHeader(title: AppStrings.addressDetails),
        ),
        SliverToBoxAdapter(child: _label(AppStrings.governorate)),
        SliverToBoxAdapter(
          child: CustomDropDownMenu<Governorate>(
            fillColor: fillColor ?? AppColors.fieldFillColor,
            hasShadow: false,
            strokeColor:
                strokeColor ?? AppColors.primary.withValues(alpha: 0.05),
            hintStyle: AppStyles.medium14poppins,

            menuItems: locationCubit.allGovernorates,
            hintText: AppStrings.selectGovernorate,
            selectedItem: selectedGovernorate,
            displayString: (gov) => gov.nameInEnglish,
            onChanged: onGovernorateChanged,
          ),
        ),
        if (selectedGovernorate != null) ...[
          SliverToBoxAdapter(child: _label(AppStrings.city)),
          SliverToBoxAdapter(
            child: CustomDropDownMenu<City>(
              fillColor: fillColor ?? AppColors.fieldFillColor,
              hasShadow: false,
              strokeColor:
                  strokeColor ?? AppColors.primary.withValues(alpha: 0.05),
              menuItems: selectedGovernorate!.citiesAndVillages,
              hintText: AppStrings.selectCity,
              hintStyle: AppStyles.medium14poppins,
              selectedItem: selectedCity,
              displayString: (city) => city.nameInEnglish,
              onChanged: onCityChanged,
            ),
          ),
        ],
      ],
    );
  }

  Widget _label(String t) => Padding(
    padding: EdgeInsets.only(bottom: 8.h, top: 16.h),
    child: Text(t, style: AppStyles.medium14poppins),
  );
}