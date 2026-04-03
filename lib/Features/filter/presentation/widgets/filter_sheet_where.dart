import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stay_match/Features/filter/data/models/location_model.dart';
import 'package:stay_match/Features/filter/presentation/manager/location_cubit.dart';
import 'package:stay_match/Features/filter/presentation/widgets/filter_bottom_sheet_app_bar.dart';
import 'package:stay_match/Features/filter/presentation/widgets/filter_helper.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_strings.dart';
import 'package:stay_match/core/constants/app_styles.dart';
import 'package:stay_match/core/widgets/custom_drop_down_menu.dart';

import '../manager/filter_cubit.dart';
import 'apply_button_sliver.dart';

class FilterSheetWhere extends StatefulWidget {
  const FilterSheetWhere({super.key, required this.propertyType});

  final PropertyType propertyType;
  @override
  State<FilterSheetWhere> createState() => _FilterSheetWhereState();
}

class _FilterSheetWhereState extends State<FilterSheetWhere> {

  Governorate? selectedGovernorate;
  City? selectedCity;

  @override
  void initState() {
    super.initState();
    // Load data when widget is created
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LocationCubit>().loadGovernorates();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationCubit, LocationState>(
      builder: (context, state) {
        // Loading
        if (state is LocationLoading || state is LocationInitial) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16.h),
                Text('Loading locations...'),
              ],
            ),
          );
        }

        // Error
        if (state is LocationErrorState) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 48.sp, color: Colors.red),
                SizedBox(height: 16.h),
                Text(state.message),
                SizedBox(height: 16.h),
                ElevatedButton(
                  onPressed: () {
                    context.read<LocationCubit>().loadGovernorates();
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        // Success - Governorates Loaded
        if (state is GovernoratesLoadedState) {
          final governorates = state.governorates;

          return CustomScrollView(
            slivers: [
              FilterBottomSheetAppBar(
                propertyType: PropertyType.apartment,
                filterType: FilterType.where,
              ),

              // Governorate Dropdown
              SliverToBoxAdapter(
                  child: RPadding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                        spacing: 8,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(AppStrings.selectGovernorate,
                            style: AppStyles.bold12poppins.copyWith(
                                color: AppColors.textColorSecondary),
                            textAlign: TextAlign.start,),
                          CustomDropDownMenu<Governorate>(
                            hintText: 'Select Governorate',
                            menuItems: governorates,
                            selectedItem: selectedGovernorate,
                            displayString: (gov) => gov.nameInEnglish,
                            onChanged: (governorate) {
                              setState(() {
                                selectedGovernorate = governorate;
                                selectedCity = null;
                                context.read<LocationCubit>().selectGovernorate(
                                    null);
                              });
                              if (governorate != null) {
                                context.read<LocationCubit>().selectGovernorate(
                                    governorate);
                              }
                            },
                            hasSearch: true,
                          ),
                        ]
                    ),)
              ),

              // City Dropdown
              if (selectedGovernorate != null)
                SliverToBoxAdapter(
                  child: RPadding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      spacing: 8,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppStrings.selectCity,
                          style: AppStyles.bold12poppins.copyWith(
                              color: AppColors.textColorSecondary),
                          textAlign: TextAlign.start,),
                        CustomDropDownMenu<City>(
                          hintText: 'Select City',
                          menuItems: selectedGovernorate!.citiesAndVillages,
                          selectedItem: selectedCity,
                          displayString: (city) => city.nameInEnglish,
                          onChanged: (city) {
                            setState(() {
                              selectedCity = city;
                            });
                            if (city != null) {
                              context.read<LocationCubit>().selectCity(city);
                            }
                          },
                          hasSearch: true,
                        ),
                      ],
                    ),
                  ),
                ),
              // Apply Button
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  children: [
                    const Spacer(),
                    ApplyButton(
                      onPressed: () async {
                        if (selectedCity != null &&
                            selectedGovernorate != null) {
                          widget.propertyType == PropertyType.apartment
                              ? await context
                              .read<FilterCubit>()
                              .updateApartmentLocation(city: selectedCity!,
                              government: selectedGovernorate!)
                              : await context
                              .read<FilterCubit>()
                              .updateRoomsLocation(
                              government: selectedGovernorate!,
                              city: selectedCity!);
                        }
                        if (context.canPop()) context.pop();
                        // Your logic
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}