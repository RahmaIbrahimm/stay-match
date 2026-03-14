import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/features/properties/presentation/views/apartments/manager/apartment_cubit.dart';
import 'package:stay_match/features/properties/presentation/views/apartments/presentation/widgets/apartment_card.dart';
import 'package:stay_match/features/properties/presentation/widgets/search_app_bar.dart';

import '../../../../../../../../../core/constants/app_strings.dart';
import '../../../../../../../../../core/constants/app_styles.dart';

class FindApartmentBody extends StatelessWidget {
  const FindApartmentBody({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocBuilder<ApartmentCubit, ApartmentsState>(
      builder: (context, state) {
        if (state is GetPropertiesSuccess) {
          var propertiesData = state.response.data?.items ?? [];
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          context.pop();
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          size: 20,
                          color: AppColors.primary,
                        ),
                      ),
                      Text(
                        AppStrings.stayMatch,
                        style: AppStyles.regular15protestRiot.copyWith(
                          color: AppColors.primary,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                SearchAppBar(),
                propertiesData.isEmpty
                    ? SliverToBoxAdapter(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.house_outlined,
                                  size: 100,
                                  color: AppColors.primary.withValues(
                                    alpha: 0.5,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'No Apartments Available',
                                  style: AppStyles.bold28poppins.copyWith(
                                    color: AppColors.textColorPrimary,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'At the Moment',
                                  style: AppStyles.bold28poppins.copyWith(
                                    color: AppColors.textColorSecondary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    'Please check again later.\nNew apartments are added regularly!',
                                    style: AppStyles.regular16poppins.copyWith(
                                      color: AppColors.primary,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : SliverList.builder(
                        itemCount: propertiesData.length,
                        itemBuilder: (context, index) {
                          return  ApartmentCard(
                                  size: size,
                                  property: propertiesData[index],
                                );
                        },
                      ),
              ],
            ),
          );
        } else if (state is GetPropertiesFailure) {
          log(state.errMessage);
          return Text(state.errMessage);
        } else if (state is GetPropertiesLoading) {
          return Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        } else {
          return Text(state.toString());
        }
      },
    );
  }
}