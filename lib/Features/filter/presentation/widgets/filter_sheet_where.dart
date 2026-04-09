import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:stay_match/Features/filter/data/models/location_model.dart';
import 'package:stay_match/Features/filter/presentation/manager/location_cubit.dart';
import 'package:stay_match/Features/filter/presentation/widgets/filter_bottom_sheet_app_bar.dart';
import 'package:stay_match/Features/filter/presentation/widgets/filter_helper.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_strings.dart';
import 'package:stay_match/core/constants/app_styles.dart';
import 'package:stay_match/core/routing/app_routing.dart';
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
  bool isLoading = false;
  LatLng? selectedMapLocation;
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
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    //todo: use current location
                    GestureDetector(
                      onTap: () async {
                        // Get current location first
                        Position position = await Geolocator
                            .getCurrentPosition();
                        final result = LatLng(
                            position.latitude, position.longitude);

                        setState(() {
                          selectedMapLocation = result;
                          selectedGovernorate = null;
                          selectedCity = null;
                        });
                      },
                      child: RPadding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(

                          children: [
                            CircleAvatar(
                              backgroundColor: AppColors.primary.withValues(
                                  alpha: 0.1),
                              child: Icon(
                                FontAwesome.location_arrow_solid, size: 15
                                  .sp, color: AppColors.primary,),
                            ),
                            SizedBox(width: 12.w,),
                            RichText(text: TextSpan(children: [
                              TextSpan(text: 'Use Current Location',
                                  style: AppStyles.semiBold14poppins.copyWith(
                                      color: AppColors.textColorPrimary)),
                              TextSpan(text: '\nFind Properties near you',
                                  style: AppStyles.regular12poppins.copyWith(
                                      color: AppColors.textColorSecondary))
                            ]))
                          ],
                        ),
                      ),
                    ),
                    // choose location on the map
                    GestureDetector(
                      onTap: () async {
                        final result = await context.pushNamed(
                          AppRouting.googleMapsViewName,
                        );
                        if (result is LatLng) {
                          setState(() {
                            selectedMapLocation = result;
                            selectedGovernorate = null;
                            selectedCity = null;
                          });
                        }
                      },
                      child: RPadding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: AppColors.primary.withValues(
                                  alpha: 0.1),
                              child: Icon(
                                Icons.map_outlined, size: 18
                                  .sp, color: AppColors.primary,),
                            ),
                            SizedBox(width: 12.w,),
                            RichText(text: TextSpan(children: [
                              TextSpan(text: 'Pick on Map',
                                  style: AppStyles.semiBold14poppins.copyWith(
                                      color: AppColors.textColorPrimary)),
                              TextSpan(text: '\nBrowse visually on the map',
                                  style: AppStyles.regular12poppins.copyWith(
                                      color: AppColors.textColorSecondary))
                            ]))
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h,),
                    ApplyButton(
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });

                        // Handle map location selection
                        if (selectedMapLocation != null) {
                          log('📍 Applying map location: ${selectedMapLocation!
                              .latitude}, ${selectedMapLocation!.longitude}');

                          if (widget.propertyType == PropertyType.apartment) {
                            await context
                                .read<FilterCubit>()
                                .updateApartmentFilter(
                              userLat: selectedMapLocation!.latitude,
                              userLng: selectedMapLocation!.longitude,
                              government: null,
                              forceRefresh: true,
                            );
                          } else {
                            await context.read<FilterCubit>().updateRoomsFilter(
                              userLat: selectedMapLocation!.latitude,
                              userLng: selectedMapLocation!.longitude,
                              government: null,
                              forceRefresh: true,
                            );
                          }

                          setState(() {
                            isLoading = false;
                          });

                          if (context.canPop()) context.pop();
                          return;
                        }

                        // Handle governorate/city selection
                        if (selectedCity != null &&
                            selectedGovernorate != null) {
                          log('📍 Applying city/governorate: ${selectedCity!
                              .nameInEnglish}, ${selectedGovernorate!
                              .nameInEnglish}');

                          if (widget.propertyType == PropertyType.apartment) {
                            await context
                                .read<FilterCubit>()
                                .updateApartmentLocation(
                              city: selectedCity!,
                              government: selectedGovernorate!,
                            );
                          } else {
                            await context
                                .read<FilterCubit>()
                                .updateRoomsLocation(
                              government: selectedGovernorate!,
                              city: selectedCity!,
                            );
                          }

                          setState(() {
                            isLoading = false;
                          });

                          if (context.canPop()) context.pop();
                          return;
                        }

                        setState(() {
                          isLoading = false;
                        });
                      },
                      isLoading: isLoading,
                    )
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