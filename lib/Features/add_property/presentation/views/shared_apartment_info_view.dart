// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:go_router/go_router.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:stay_match/Features/add_property/presentation/widgets/shared/field_label.dart';
// import 'package:stay_match/Features/filter/data/repos/location_repo_impl.dart';
// import 'package:stay_match/core/routing/app_routing.dart';
// import 'package:stay_match/core/utils/service_locator.dart';
//
// import '../../../../../core/constants/app_colors.dart';
// import '../../../../../core/constants/app_strings.dart';
// import '../../../../../core/constants/app_styles.dart';
// import '../../../../../core/widgets/custom_text_form_field.dart';
// import '../../../filter/data/models/location_model.dart';
// import '../../../filter/presentation/manager/location_cubit.dart';
// import '../manager/add_property_cubit.dart';
// import '../widgets/location_and_gallery_widgets/address_details_section.dart';
// import '../widgets/location_and_gallery_widgets/map_picker_section.dart';
// import '../widgets/location_and_gallery_widgets/property_gallery_widget.dart';
// import '../widgets/shared/add_property_app_bar.dart';
// import '../widgets/shared/add_property_buttons.dart';
// import '../widgets/shared/progress_bar.dart';
// import '../widgets/shared/section_header.dart';
// import '../widgets/shared/validation_helper.dart';
//
// class SharedApartmentInfoView extends StatefulWidget {
//   const SharedApartmentInfoView({super.key});
//
//   @override
//   State<SharedApartmentInfoView> createState() =>
//       _SharedApartmentInfoViewState();
// }
//
// class _SharedApartmentInfoViewState extends State<SharedApartmentInfoView> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   late final TextEditingController _nameController;
//   late final TextEditingController _streetController;
//   late final TextEditingController _descriptionController;
//   Color strokeColor = Color.fromRGBO(226, 232, 240, 1);
//
//   // Track dropdown states locally for UI sync
//   Governorate? selectedGovernorate;
//   City? selectedCity;
//
//   @override
//   void initState() {
//     super.initState();
//     final cubit = context.read<AddPropertyCubit>();
//     final request =
//         cubit.roomRequest; // Using roomRequest for Shared Apartment logic
//
//     _nameController = TextEditingController(text: request.name);
//     _streetController = TextEditingController(text: request.street);
//     _descriptionController = TextEditingController(text: request.description);
//
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       context.read<LocationCubit>().loadGovernorates();
//     });
//   }
//
//   @override
//   void dispose() {
//     _nameController.dispose();
//     _streetController.dispose();
//     _descriptionController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) =>
//           LocationCubit(locationRepository: getIt.get<LocationRepoImpl>())
//             ..loadGovernorates(),
//       child: Scaffold(
//         body: BlocBuilder<AddPropertyCubit, AddPropertyState>(
//           builder: (context, propertyState) {
//             final cubit = context.read<AddPropertyCubit>();
//             final request = cubit.roomRequest;
//
//             return Form(
//               key: _formKey,
//               child: RPadding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: CustomScrollView(
//                   slivers: [
//                     AddPropertyAppBar(
//                       cubit: cubit,
//                       title: AppStrings.addProperty,
//                     ),
//                     SliverToBoxAdapter(
//                       child: ProgressBar(stepNumber: cubit.currentStep + 1),
//                     ),
//
//                     // --- BASIC INFORMATION SECTION ---
//                     SliverToBoxAdapter(child: FieldLabel(t: "Apartment Name")),
//                     SliverToBoxAdapter(
//                       child: CustomTextFormField(
//                         hintText: "e.g. Blue Sky Apartments",
//                         borderRadius: 12,
//                         strokeColor: strokeColor,
//                         hasShadow: false,
//                         fillColor: AppColors.containerColor,
//                         controller: _nameController,
//                         onChanged: (v) =>
//                             cubit.updateSharedPropertyBasicInfo(name: v),
//                         validator: (v) => ValidationHelper.validateName(
//                           v,),
//                       ),
//                     ),
//
//                     SliverToBoxAdapter(
//                       child: Padding(
//                         padding: EdgeInsets.symmetric(vertical: 16.h),
//                         child: Row(
//                           children: [
//                             Expanded(
//                               child: _buildRoomCountField(cubit, isTotal: true),
//                             ),
//                             SizedBox(width: 12.w),
//                             Expanded(
//                               child: _buildRoomCountField(
//                                 cubit,
//                                 isTotal: false,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     SliverToBoxAdapter(
//                       child: FieldLabel(t: AppStrings.description),
//                     ),
//
//                     SliverToBoxAdapter(
//                       child:  SizedBox(
//                         height: 150.h,
//                         child: CustomTextFormField(
//                           hintText: AppStrings.descriptionHint,
//                           controller: _descriptionController,
//                           maxLines: 4,
//                           fillColor: AppColors.containerColor,
//                           hasShadow: false,
//                           stroke: true,
//                           strokeColor: strokeColor,
//                           borderRadius: 12,
//                           hintStyle: AppStyles.regular14poppins.copyWith(
//                             color: AppColors.textColorSecondary,
//                           ),
//                           onChanged: (v)=>cubit.updateSharedPropertyBasicInfo(description: v),
//                           validator: ValidationHelper.validateDescription,
//                         ),
//                       ),
//                     ),
//                     // --- LOCATION SECTION ---
//                     BlocBuilder<LocationCubit, LocationState>(
//                       builder: (context, locationState) {
//                         final locationCubit = context.read<LocationCubit>();
//
//                         return SliverMainAxisGroup(
//                           slivers: [
//                             AddressDetailsSection(
//                               selectedGovernorate: selectedGovernorate,
//                               selectedCity: selectedCity,
//                               strokeColor: strokeColor,
//                               fillColor: AppColors.containerColor,
//                               onGovernorateChanged: (gov) {
//                                 setState(() {
//                                   selectedGovernorate = gov;
//                                   selectedCity = null;
//                                   if (gov != null) {
//                                     request.latitude = gov.latitude;
//                                     request.longitude = gov.longitude;
//                                     cubit.updateSharedPropertyLocation(
//                                       state: gov.nameInEnglish,
//                                     );
//                                   }
//                                 });
//                               },
//                               onCityChanged: (city) {
//                                 setState(() {
//                                   selectedCity = city;
//                                   if (city != null) {
//                                     request.latitude = city.latitude;
//                                     request.longitude = city.longitude;
//                                     cubit.updateSharedPropertyLocation(
//                                       city: city.nameInEnglish,
//                                     );
//                                   }
//                                 });
//                               },
//                             ),
//
//                             SliverToBoxAdapter(
//                               child: FieldLabel(t: AppStrings.streetAddress),
//                             ),
//                             SliverToBoxAdapter(
//                               child: CustomTextFormField(
//                                 hintText: AppStrings.streetAddressHint,
//                                 borderRadius: 12,
//                                 strokeColor: strokeColor,
//                                 hasShadow: false,
//                                 fillColor: AppColors.containerColor,
//                                 controller: _streetController,
//                                 onChanged: (v) => cubit
//                                     .updateSharedPropertyLocation(street: v),
//                                 validator: (v) =>
//                                     ValidationHelper.validateRequired(
//                                       v,
//                                       AppStrings.streetAddress,
//                                     ),
//                               ),
//                             ),
//
//                             SliverToBoxAdapter(child: SizedBox(height: 24.h)),
//
//                             // Integrated Map Picker Section
//                             MapPickerSection(
//                               latitude: request.latitude?.toDouble(),
//                               longitude: request.longitude?.toDouble(),
//                               onLocationSelected: (pos) {
//                                 setState(() {
//                                   request.latitude = pos.latitude;
//                                   request.longitude = pos.longitude;
//                                 });
//                                 _syncDropdownsWithMap(
//                                   pos,
//                                   locationCubit.allGovernorates,
//                                 );
//                               },
//                             ),
//                           ],
//                         );
//                       },
//                     ),
//
//                     // --- GALLERY SECTION ---
//                     SliverToBoxAdapter(child: SizedBox(height: 24.h)),
//                     SliverToBoxAdapter(
//                       child: SectionHeader(title: AppStrings.propertyGallery),
//                     ),
//                     SliverToBoxAdapter(child: SizedBox(height: 16.h)),
//                     const SliverToBoxAdapter(child: PropertyGalleryWidget()),
//
//                     // --- NAVIGATION BUTTONS ---
//                     SliverToBoxAdapter(child: SizedBox(height: 32.h)),
//                     SliverToBoxAdapter(
//                       child:AddPropertyButtons(
//                         nextPageRoute: AppRouting.addAmenitiesName, // This is a fallback
//                         cubit: cubit,
//                         submit: false,
//                         // This callback overrides the default navigation inside the widget
//                         onNextPressed: () => _handleStepValidation(cubit),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   Widget _buildRoomCountField(AddPropertyCubit cubit, {required bool isTotal}) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           isTotal ? "Total Rooms" : "Available Rooms",
//           style: AppStyles.medium14poppins,
//         ),
//         SizedBox(height: 8.h),
//         CustomTextFormField(
//           borderRadius: 12,
//           strokeColor: strokeColor,
//           hasShadow: false,
//           fillColor: AppColors.containerColor,
//           hintText: "0",
//           keyboardType: TextInputType.number,
//           onChanged: (v) {
//             final val = int.tryParse(v);
//             if (isTotal) {
//               cubit.updateSharedPropertyBasicInfo(totalRooms: val);
//             } else {
//               cubit.updateSharedPropertyBasicInfo(availableRooms: val);
//             }
//           },
//           validator: (String? p1) {
//             if (p1 == null || p1.isEmpty) {
//               return "Required";
//             } else if (int.tryParse(p1) == null) {
//               return "Invalid Value";
//             } else if (int.parse(p1) < 1) {
//               return "Can't be less than 1";
//             }
//             return null;
//           },
//         ),
//       ],
//     );
//   }
//
//   void _handleStepValidation(AddPropertyCubit cubit) {
//     final req = cubit.roomRequest;
//
//     // 1. Trigger UI Validation (Red text under fields)
//     if (!_formKey.currentState!.validate()) {
//       _showError("Please fix the errors in the form");
//       return; // STOP HERE
//     }
//
//     // 2. Check for Images (Mandatory for Step 1)
//     if (cubit.localImages.isEmpty) {
//       _showError("Please upload at least one property image");
//       return; // STOP HERE
//     }
//
//     // 3. Logic Check via Helper (Checks name/desc length)
//     if (ValidationHelper.isBasicInfoSharedApartmentValid(req)) {
//       // ONLY Navigate if valid
//       cubit.nextStep();
//       context.pushNamed(AppRouting.addAmenitiesName);
//     } else {
//       _showError("Name and Description must be at least 10 characters");
//     }
//   }
//   void _syncDropdownsWithMap(LatLng pickedLocation, List<Governorate> allGovs) {
//     Governorate? closestGov;
//     City? closestCity;
//     double minDistance = double.infinity;
//
//     for (var gov in allGovs) {
//       for (var city in gov.citiesAndVillages) {
//         double dLat = pickedLocation.latitude - (city.latitude ?? 0);
//         double dLng = pickedLocation.longitude - (city.longitude ?? 0);
//         double distance = (dLat * dLat) + (dLng * dLng);
//
//         if (distance < minDistance) {
//           minDistance = distance;
//           closestGov = gov;
//           closestCity = city;
//         }
//       }
//     }
//
//     if (minDistance < 0.05) {
//       setState(() {
//         selectedGovernorate = closestGov;
//         selectedCity = closestCity;
//         final cubit = context.read<AddPropertyCubit>();
//         cubit.updateSharedPropertyLocation(
//           state: closestGov?.nameInEnglish,
//           city: closestCity?.nameInEnglish,
//         );
//       });
//     }
//   }
//
//   void _showError(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(
//           message,
//           style: AppStyles.medium14poppins.copyWith(color: Colors.white),
//         ),
//         backgroundColor: Colors.redAccent,
//         behavior: SnackBarBehavior.floating,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//         margin: EdgeInsets.all(16.w),
//         duration: const Duration(seconds: 3),
//       ),
//     );
//   }}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stay_match/Features/add_property/presentation/widgets/shared/field_label.dart';
import 'package:stay_match/Features/filter/data/repos/location_repo_impl.dart';
import 'package:stay_match/core/routing/app_routing.dart';
import 'package:stay_match/core/utils/service_locator.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/constants/app_styles.dart';
import '../../../../../core/widgets/custom_text_form_field.dart';
import '../../../filter/data/models/location_model.dart';
import '../../../filter/presentation/manager/location_cubit.dart';
import '../manager/add_property_cubit.dart';
import '../widgets/location_and_gallery_widgets/address_details_section.dart';
import '../widgets/location_and_gallery_widgets/map_picker_section.dart';
import '../widgets/location_and_gallery_widgets/property_gallery_widget.dart';
import '../widgets/shared/add_property_app_bar.dart';
import '../widgets/shared/add_property_buttons.dart';
import '../widgets/shared/progress_bar.dart';
import '../widgets/shared/section_header.dart';
import '../widgets/shared/validation_helper.dart';

class SharedApartmentInfoView extends StatefulWidget {
  const SharedApartmentInfoView({super.key});

  @override
  State<SharedApartmentInfoView> createState() =>
      _SharedApartmentInfoViewState();
}

class _SharedApartmentInfoViewState extends State<SharedApartmentInfoView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _streetController;
  late final TextEditingController _descriptionController;
  final Color strokeColor = const Color.fromRGBO(226, 232, 240, 1);

  Governorate? selectedGovernorate;
  City? selectedCity;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<AddPropertyCubit>();
    final request = cubit.roomRequest;

    _nameController = TextEditingController(text: request.name);
    _streetController = TextEditingController(text: request.street);
    _descriptionController = TextEditingController(text: request.description);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _streetController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Moved Provider here so it doesn't reset on every AddPropertyCubit emission
    return BlocProvider(
      create: (context) =>
      LocationCubit(locationRepository: getIt.get<LocationRepoImpl>())
        ..loadLocations(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocBuilder<AddPropertyCubit, AddPropertyState>(
          builder: (context, propertyState) {
            final cubit = context.read<AddPropertyCubit>();
            final request = cubit.roomRequest;

            return Form(
              key: _formKey,
              child: RPadding(
                padding: const EdgeInsets.all(16.0),
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    AddPropertyAppBar(
                      cubit: cubit,
                      title: AppStrings.addProperty,
                    ),
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          ProgressBar(stepNumber: cubit.currentStep + 1),
                          SizedBox(height: 24.h),
                        ],
                      ),
                    ),

                    // --- BASIC INFORMATION ---
                    SliverToBoxAdapter(child: FieldLabel(t: "Apartment Name")),
                    SliverToBoxAdapter(
                      child: CustomTextFormField(
                        hintText: "e.g. Blue Sky Apartments",
                        borderRadius: 12,
                        strokeColor: strokeColor,
                        hasShadow: false,
                        fillColor: AppColors.containerColor,
                        controller: _nameController,
                        onChanged: (v) =>
                            cubit.updateSharedPropertyBasicInfo(name: v),
                        validator: ValidationHelper.validateName,
                      ),
                    ),

                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: _buildRoomCountField(cubit, isTotal: true),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: _buildRoomCountField(cubit, isTotal: false),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SliverToBoxAdapter(child: FieldLabel(t: AppStrings.description)),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 150.h,
                        child: CustomTextFormField(
                          hintText: AppStrings.descriptionHint,
                          controller: _descriptionController,
                          maxLines: 4,
                          fillColor: AppColors.containerColor,
                          hasShadow: false,
                          stroke: true,
                          strokeColor: strokeColor,
                          borderRadius: 12,
                          hintStyle: AppStyles.regular14poppins.copyWith(
                            color: AppColors.textColorSecondary,
                          ),
                          onChanged: (v) =>
                              cubit.updateSharedPropertyBasicInfo(description: v),
                          validator: ValidationHelper.validateDescription,
                        ),
                      ),
                    ),

                    // --- LOCATION SECTION ---
                    BlocBuilder<LocationCubit, LocationState>(
                      builder: (context, locationState) {
                        final locationCubit = context.read<LocationCubit>();

                        return SliverMainAxisGroup(
                          slivers: [
                            AddressDetailsSection(
                              selectedGovernorate: selectedGovernorate,
                              selectedCity: selectedCity,
                              strokeColor: strokeColor,
                              fillColor: AppColors.containerColor,
                              onGovernorateChanged: (gov) {
                                setState(() {
                                  selectedGovernorate = gov;
                                  selectedCity = null;
                                  if (gov != null) {
                                    request.latitude = gov.latitude;
                                    request.longitude = gov.longitude;
                                    cubit.updateSharedPropertyLocation(
                                      state: gov.nameInEnglish,
                                    );
                                  }
                                });
                              },
                              onCityChanged: (city) {
                                setState(() {
                                  selectedCity = city;
                                  if (city != null) {
                                    request.latitude = city.latitude;
                                    request.longitude = city.longitude;
                                    cubit.updateSharedPropertyLocation(
                                      city: city.nameInEnglish,
                                    );
                                  }
                                });
                              },
                            ),
                            SliverToBoxAdapter(child: FieldLabel(t: AppStrings.streetAddress)),
                            SliverToBoxAdapter(
                              child: CustomTextFormField(
                                hintText: AppStrings.streetAddressHint,
                                borderRadius: 12,
                                strokeColor: strokeColor,
                                hasShadow: false,
                                fillColor: AppColors.containerColor,
                                controller: _streetController,
                                onChanged: (v) =>
                                    cubit.updateSharedPropertyLocation(street: v),
                                validator: (v) => ValidationHelper.validateRequired(
                                  v,
                                  AppStrings.streetAddress,
                                ),
                              ),
                            ),
                            SliverToBoxAdapter(child: SizedBox(height: 24.h)),
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
                          ],
                        );
                      },
                    ),

                    // --- GALLERY SECTION ---
                    SliverToBoxAdapter(child: SizedBox(height: 24.h)),
                    SliverToBoxAdapter(child: SectionHeader(title: AppStrings.propertyGallery)),
                    SliverToBoxAdapter(child: SizedBox(height: 16.h)),
                    const SliverToBoxAdapter(child: PropertyGalleryWidget()),

                    // --- NAVIGATION ---
                    SliverToBoxAdapter(child: SizedBox(height: 32.h)),
                    SliverToBoxAdapter(
                      child: AddPropertyButtons(
                        nextPageRoute: AppRouting.addAmenitiesName,
                        cubit: cubit,
                        submit: false,
                        onNextPressed: () => _handleStepValidation(cubit),
                      ),
                    ),
                    SliverToBoxAdapter(child: SizedBox(height: 40.h)),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildRoomCountField(AddPropertyCubit cubit, {required bool isTotal}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isTotal ? "Total Rooms" : "Available Rooms",
          style: AppStyles.medium14poppins,
        ),
        SizedBox(height: 8.h),
        CustomTextFormField(
          borderRadius: 12,
          strokeColor: strokeColor,
          hasShadow: false,
          fillColor: AppColors.containerColor,
          hintText: "0",
          keyboardType: TextInputType.number,
          onChanged: (v) {
            // FIX: Ensure null is never passed to cubit via fallback
            final val = int.tryParse(v) ?? 1;
            if (isTotal) {
              cubit.updateSharedPropertyBasicInfo(totalRooms: val);
            } else {
              cubit.updateSharedPropertyBasicInfo(availableRooms: val);
            }
          },
          validator: (v) {
            if (v == null || v.isEmpty) return "Required";
            final n = int.tryParse(v);
            if (n == null) return "Invalid";
            if (n < 1) return "Min 1";
            return null;
          },
        ),
      ],
    );
  }

  void _handleStepValidation(AddPropertyCubit cubit) {
    final req = cubit.roomRequest;

    if (!_formKey.currentState!.validate()) {
      _showError("Please fix the errors in the form");
      return;
    }

    if (cubit.localImages.isEmpty) {
      _showError("Please upload at least one property image");
      return;
    }

    // Logic Check: Available Rooms cannot exceed Total Rooms
    if ((req.availableRooms ?? 0) > (req.totalRooms ?? 0)) {
      _showError("Available rooms cannot exceed total rooms");
      return;
    }

    if (ValidationHelper.isBasicInfoSharedApartmentValid(req)) {
      cubit.nextStep();
      // Navigate to your specific Room Details route
      context.pushNamed(AppRouting.addAmenitiesName);
    } else {
      _showError("Name and Description must be at least 10 characters");
    }
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

    // A threshold to ensure we only snap if it's reasonably close
    if (minDistance < 0.05) {
      setState(() {
        selectedGovernorate = closestGov;
        selectedCity = closestCity;
        final cubit = context.read<AddPropertyCubit>();
        cubit.updateSharedPropertyLocation(
          state: closestGov?.nameInEnglish,
          city: closestCity?.nameInEnglish,
        );
      });
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: AppStyles.medium14poppins.copyWith(color: Colors.white)),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(16.w),
      ),
    );
  }
}