import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/amenity_constants.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/routing/app_routing.dart';
import '../../../../filter/presentation/widgets/filter_helper.dart';
import '../../manager/add_property_cubit.dart';
import '../shared/add_property_app_bar.dart';
import '../shared/add_property_buttons.dart';
import '../shared/progress_bar.dart';
import 'amenity_grid_section.dart';

class AmenitiesAndServicesBody extends StatelessWidget {
  const AmenitiesAndServicesBody({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddPropertyCubit, AddPropertyState>(
      builder: (context, state) {
        final cubit = context.read<AddPropertyCubit>();
        Map<String, dynamic> currentAmenities;
        Map<String, dynamic> currentServices;

        if (cubit.selectedType == PropertyType.apartment) {
          currentAmenities = cubit.apartmentRequest.amenities?.toJson() ?? {};
          currentServices = cubit.apartmentRequest.nearbyServices?.toJson() ?? {};
        } else {
          currentAmenities = cubit.roomRequest.amenities?.toJson() ?? {};
          currentServices = cubit.roomRequest.nearbyServices?.toJson() ?? {};
        }

        return Scaffold(
          body: SafeArea(
            child: RPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CustomScrollView(
                slivers: [
                  // 1. Header & Progress
                  AddPropertyAppBar(
                    cubit: cubit,
                    title: AppStrings.listingDetails,
                  ),
                  SliverToBoxAdapter(
                    child: ProgressBar(stepNumber: cubit.currentStep + 1),
                  ),

                  // 2. Amenities Section
                  AmenityGridSection(
                    title: AppStrings.amenities,
                    icon: Icons.home_repair_service,
                    items: AmenityConstants.amenities,
                    currentValues: currentAmenities,
                    onTap: (key) => cubit.toggleAmenity(key),
                  ),

                  // 3. Nearby Services Section
                  AmenityGridSection(
                    title: AppStrings.nearbyServices,
                    icon: Icons.map,
                    items: AmenityConstants.nearbyServices,
                    currentValues: currentServices,
                    // currentValues: request.nearbyServices?.toJson() ?? {},
                    onTap: (key) => cubit.toggleNearbyServices(key),
                  ),

                  // 4. Footer
                  SliverToBoxAdapter(child: SizedBox(height: 24.h)),
                  SliverToBoxAdapter(
                    child: AddPropertyButtons(
                      cubit: cubit,
                      nextPageRoute: cubit.selectedType == PropertyType.apartment ?AppRouting.addLocationAndGalleryName:AppRouting.addIndividualRoomsName,
                    ),
                  ),
                  SliverToBoxAdapter(child: SizedBox(height: 16.h)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}