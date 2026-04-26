import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/Features/my_properties/presentation/widgets/floating_drop_down.dart';
import 'package:stay_match/core/constants/app_colors.dart';

import '../manager/my_properties_cubit.dart';
import '../widgets/property_card.dart';
import 'add_new_property_button.dart';

class MyPropertiesBody extends StatelessWidget {
  const MyPropertiesBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyPropertiesCubit, MyPropertiesState>(
      builder: (context, state) {
        if (state is MyPropertiesLoading) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        } else if (state is MyPropertiesFailure) {
          return Center(child: Text(state.errMessage));
        } else if (state is MyPropertiesSuccess) {
          final properties = state.response.data?.properties ?? [];

          if (properties.isEmpty) {
            return const Center(child: Text('No properties found.'));
          }

          return RefreshIndicator(
            onRefresh: () async {
              await BlocProvider.of<MyPropertiesCubit>(
                context,
              ).getMyProperties();
            },
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  Text(
                    'My Properties',
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF19212C),
                    ),
                  ),
                  Text(
                    'Manage and monitor your ${state.response.data?.totalCount ?? 0} property listings',
                    style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                  ),
                  SizedBox(height: 20.h),

                  Row(
                    children: [
                      Expanded(child: FloatingDropDown()),
                      SizedBox(width: 12.w),
                      Expanded(child: AddNewPropertyButton()),
                    ],
                  ),

                  SizedBox(height: 20.h),

                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: properties.length,
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 16.h),
                    itemBuilder: (context, index) =>
                        PropertyCard(property: properties[index]),
                  ),
                  SizedBox(height: 30.h),
                ],
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}