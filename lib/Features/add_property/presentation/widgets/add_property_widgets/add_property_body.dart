import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/Features/add_property/presentation/widgets/add_property_widgets/property_choice_card.dart';
import 'package:stay_match/core/routing/app_routing.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_images.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/constants/app_styles.dart';
import '../../../../filter/presentation/widgets/filter_helper.dart';
import '../../manager/add_property_cubit.dart';
import '../shared/add_property_app_bar.dart';
import '../shared/add_property_buttons.dart';
import '../shared/progress_bar.dart';

class AddPropertyBody extends StatelessWidget {
  const AddPropertyBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddPropertyCubit, AddPropertyState>(
      buildWhen: (previous, current) {
        // Only rebuild this counter section if the relevant data actually changed
        return current is AddPropertyFormUpdated;
      },
      builder: (context, state) {
        final cubit = context.read<AddPropertyCubit>();
        return RPadding(
          padding: const EdgeInsets.all(16),
          child: CustomScrollView(
            slivers: [
              AddPropertyAppBar(cubit: cubit, title: AppStrings.addProperty),
              // Step Progress Indicator
              SliverToBoxAdapter(
                child: ProgressBar(stepNumber: cubit.currentStep + 1),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 24.h)),

              // Header Text
              _buildHeaderText(),
              SliverToBoxAdapter(child: SizedBox(height: 24.h)),

              // Selection Card 1: Whole Apartment
              SliverToBoxAdapter(
                child: PropertyChoiceCard(
                  title: AppStrings.wholeApartment,
                  subtitle: AppStrings.wholeApartmentDesc,
                  imagePath: AppImages.addPropertyImg,
                  icon: Icons.apartment,
                  // Use the getter from the Cubit
                  isSelected: cubit.selectedType == PropertyType.apartment,
                  onTap: () => cubit.selectType(PropertyType.apartment),
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 16.h)),

              // Selection Card 2: Divided Into Rooms
              SliverToBoxAdapter(
                child: PropertyChoiceCard(
                  title: AppStrings.dividedIntoRooms,
                  subtitle: AppStrings.dividedIntoRoomsDesc,
                  imagePath: AppImages.addRoomImg,
                  icon: Icons.bed,
                  isSelected: cubit.selectedType == PropertyType.room,
                  onTap: () => cubit.selectType(PropertyType.room),
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 24.h)),
              // Footer Logic
              SliverToBoxAdapter(
                child: AddPropertyButtons(
                  cubit: cubit,
                  nextPageRoute: cubit.selectedType == PropertyType.apartment
                      ? AppRouting.addPropertyInfoName
                      : AppRouting.addRoomName,
                  hasBackButton: false,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeaderText() {
    return SliverToBoxAdapter(
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: AppStrings.whatTypeOfProperty,
              style: AppStyles.bold24poppins.copyWith(
                color: AppColors.textColorPrimary,
              ),
            ),
            const TextSpan(text: '\n'),
            TextSpan(
              text: AppStrings.selectOptionThatDescribes,
              style: AppStyles.regular15poppins.copyWith(
                color: AppColors.textColorPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}