import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_strings.dart';
import 'package:stay_match/core/constants/app_styles.dart';
import 'package:stay_match/core/widgets/custom_elevated_button.dart';
import 'package:stay_match/core/widgets/custom_text_button.dart';
import 'package:stay_match/features/home/presentation/widget/rooms_list.dart';
import 'package:stay_match/features/home/presentation/widget/rooms_section.dart';
import 'package:stay_match/features/properties/rooms/manager/rooms_cubit.dart';

import '../../../properties/apartments/data/models/get_all_apartments.dart';
import '../../../properties/apartments/manager/apartment_cubit.dart';
import '../../../properties/apartments/presentation/widgets/apartment_list.dart';
import '../../../properties/rooms/data/models/get_all_rooms.dart';
import 'apartments_section.dart';
import 'home_header.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 16, vertical: 16),
      child: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              HomeHeader(size: size, tabController: _tabController),
              SizedBox(height: 16),
              // discover apartments
              BlocBuilder<PropertiesCubit, ApartmentsState>(
                builder: (context, state) {
                  if (state is GetPropertiesSuccess) {
                    var properties = state.response.data;
                    if (properties != null && properties.isNotEmpty) {
                      return ApartmentsSection(
                        size: size,
                        properties: properties,
                      );
                    }
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
              SizedBox(height: 24),
              // discover rooms
              BlocBuilder<RoomsCubit, RoomsState>(
                builder: (context, state) {
                  if (state is GetRoomsSuccess) {
                    var roomPropertiesData = state.response.data;
                    return RoomsSection(
                      size: size,
                      roomPropertiesData: roomPropertiesData,
                    );
                  }
                  // Failure state
                  else if (state is GetRoomsFailure) {
                    return Text('Error: ${state.errMessage}');
                  }
                  // Initial state (before any loading)
                  else if (state is RoomsInitial) {
                    return Container(); // or loading, or nothing
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    );
                  }
                },
              ),
              SizedBox(height: 24),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                height: size.height * 0.17,
                decoration: BoxDecoration(
                  color: AppColors.bgGrey,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(AppStrings.myProperties,style: AppStyles.semiBold15poppins.copyWith(color: AppColors.textColorPrimary),),
                    const SizedBox(height: 10,),
                    Text(
                      AppStrings.addYourProperty,
                      style: AppStyles.medium15poppins.copyWith(
                        color: AppColors.textColorPrimary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 6,),
                    Text(
                      AppStrings.shareApartmentDetails,
                      style: AppStyles.medium10poppins.copyWith(
                        color: AppColors.textColorSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16,),
                    // todo: implement add property
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 82.0),
                      child: CustomElevatedButton(
                        verticalPadding: 6,
                        textStyle: AppStyles.semiBold15poppins,
                        text: AppStrings.addProperty,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}