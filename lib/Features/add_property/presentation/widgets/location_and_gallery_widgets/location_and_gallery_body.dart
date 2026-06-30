import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/constants/app_styles.dart';
import '../../../../../core/routing/app_routing.dart';
import '../../../../../core/widgets/custom_text_form_field.dart';
import '../../../../filter/data/models/location_model.dart';
import '../../../../filter/presentation/manager/location_cubit.dart';
import '../../manager/add_property_cubit.dart';
import '../shared/add_property_app_bar.dart';
import '../shared/add_property_buttons.dart';
import '../shared/progress_bar.dart';
import '../shared/section_header.dart';
import '../shared/validation_helper.dart';
import 'address_details_section.dart';
import 'map_picker_section.dart';
import 'property_gallery_widget.dart';

class LocationAndGalleryBody extends StatefulWidget {
  const LocationAndGalleryBody({super.key});

  @override
  State<LocationAndGalleryBody> createState() => _LocationAndGalleryBodyState();
}

class _LocationAndGalleryBodyState extends State<LocationAndGalleryBody> {
  Governorate? selectedGovernorate;
  City? selectedCity;
  late final TextEditingController _streetController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    final cubit = context.read<AddPropertyCubit>();
    _streetController = TextEditingController(text: cubit.apartmentRequest.street);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<LocationCubit>().loadLocations();
      }
    });
  }

  @override
  void dispose() {
    _streetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddPropertyCubit, AddPropertyState>(
      builder: (context, propertyState) {
        final cubit = context.read<AddPropertyCubit>();
        final request = cubit.apartmentRequest;

        return Form(
          key:_formKey,
          child: RPadding(
            padding: const EdgeInsets.all(16.0),
            child: CustomScrollView(
              slivers: [
                AddPropertyAppBar(cubit: cubit, title: AppStrings.addProperty),
                SliverToBoxAdapter(
                  child: ProgressBar(stepNumber: cubit.currentStep + 1),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 16.h,),),
                BlocBuilder<LocationCubit, LocationState>(
                  builder: (context, locationState) {
                    final locationCubit = context.read<LocationCubit>();

                    if (locationState is LocationLoading &&
                        locationCubit.allGovernorates.isEmpty) {
                      return const SliverToBoxAdapter(
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      );
                    }

                    return SliverMainAxisGroup(
                      slivers: [
                        AddressDetailsSection(
                          selectedGovernorate: selectedGovernorate,
                          selectedCity: selectedCity,
                          onGovernorateChanged: (gov) {
                            setState(() {
                              selectedGovernorate = gov;
                              selectedCity = null;
                              if (gov != null) {
                                request.latitude = gov.latitude;
                                request.longitude = gov.longitude;
                                request.government = gov.nameInEnglish;
                              }
                            });
                          },
                          onCityChanged: (city) {
                            setState(() {
                              selectedCity = city;
                              if (city != null) {
                                request.latitude = city.latitude;
                                request.longitude = city.longitude;
                                request.city = city.nameInEnglish;
                              }
                            });
                          },
                        ),
                        // street address
                        SliverToBoxAdapter(
                          child: _label(AppStrings.streetAddress),
                        ),
                        SliverToBoxAdapter(
                          child: CustomTextFormField(
                            hintText: AppStrings.streetAddressHint,
                            controller: _streetController,
                            fillColor: AppColors.fieldFillColor,
                            strokeColor: AppColors.primary.withValues(alpha: 0.05),
                            onChanged: (v) => request.street = v,
                            hasShadow: false,
                            hintStyle: AppStyles.medium14poppins, validator:(v)=> ValidationHelper.validateRequired(v, AppStrings.streetAddress),
                          ),
                        ),
                        SliverToBoxAdapter(child: SizedBox(height: 8.h,),),
                        const SliverToBoxAdapter(child: Divider()),
                        SliverToBoxAdapter(child: SizedBox(height: 8.h,),),
                        MapPickerSection(
                          latitude: request.latitude?.toDouble(),
                          longitude: request.longitude?.toDouble(),
                          onLocationSelected: (pos) {
                            setState(() {
                              request.latitude = pos.latitude;
                              request.longitude = pos.longitude;
                            });
                            _syncDropdownsWithMap(
                              pos,
                              locationCubit.allGovernorates,
                            );
                          },
                        ),
                        SliverToBoxAdapter(child: SizedBox(height: 16.h,),),
                        SliverToBoxAdapter(
                          child: SectionHeader(title: AppStrings.propertyGallery),
                        ),
                        SliverToBoxAdapter(child: SizedBox(height: 16.h,),),
                        const SliverToBoxAdapter(child: PropertyGalleryWidget()),
                      ],
                    );
                  },
                ),
                SliverToBoxAdapter(child: SizedBox(height: 32.h)),
                SliverToBoxAdapter(
                  child: AddPropertyButtons(
                    nextPageRoute: '',
                    cubit: cubit,
                    submit: true,
                    onNextPressed: _handleFinalValidation,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
// Inside _LocationAndGalleryBodyState

  void _handleFinalValidation() async{
    final cubit = context.read<AddPropertyCubit>();
    final req = cubit.apartmentRequest;

    // 1. Standard Form Validation
    if (!_formKey.currentState!.validate()) return;
    if (cubit.localImages.isEmpty) {
      _showError("Upload at least one image");
      return;
    }

    // 3. Check the helper
    if (ValidationHelper.isLocationAndGalleryValid(req)) {
      debugPrint('🚀 VALIDATION PASSED - Calling Submit');
      await cubit.submitApartment();
      context.pushNamed(AppRouting.addPropertySuccessName,pathParameters: {
        'id': cubit.id.toString(),
      });
    } else {
      debugPrint('❌ VALIDATION FAILED on Helper check');
      _showError("Please check location and gallery details");
    }
  }
  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.all(16.w),        content: Text(msg),
        backgroundColor: Colors.redAccent,
      ),
    );
  }
  void _syncDropdownsWithMap(LatLng pickedLocation, List<Governorate> allGovs) {
    Governorate? closestGov;
    City? closestCity;
    double minDistance = double.infinity;

    for (var gov in allGovs) {
      for (var city in gov.citiesAndVillages) {
        double dLat = pickedLocation.latitude - (city.latitude ?? 0);
        double dLng = pickedLocation.longitude - (city.longitude ?? 0);
        double distance = (dLat * dLat) + (dLng * dLng);

        if (distance < minDistance) {
          minDistance = distance;
          closestGov = gov;
          closestCity = city;
        }
      }
    }

    if (minDistance < 0.05) {
      setState(() {
        selectedGovernorate = closestGov;
        selectedCity = closestCity;
        final cubit = context.read<AddPropertyCubit>();
        cubit.apartmentRequest.government = closestGov?.nameInEnglish ?? "";
        cubit.apartmentRequest.city = closestCity?.nameInEnglish ?? "";
      });
    }
  }

  Widget _label(String t) => Padding(
    padding: EdgeInsets.only(bottom: 8.h, top: 16.h),
    child: Text(t, style: AppStyles.medium14poppins),
  );
}