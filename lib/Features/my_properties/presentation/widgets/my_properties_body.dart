import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:stay_match/Features/my_properties/data/models/my_properties_response.dart';
import 'package:stay_match/Features/my_properties/presentation/widgets/floating_drop_down.dart';
import 'package:stay_match/core/constants/app_colors.dart';

import '../manager/my_properties_cubit.dart';
import '../widgets/property_card.dart';
import 'add_new_property_button.dart';

class MyPropertiesBody extends StatefulWidget {
  const MyPropertiesBody({super.key});

  @override
  State<MyPropertiesBody> createState() => _MyPropertiesBodyState();
}

class _MyPropertiesBodyState extends State<MyPropertiesBody> {
  final PagingController<int, Properties> _pagingController = PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      context.read<MyPropertiesCubit>().fetchPage(pageKey, _pagingController);
    });
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        _pagingController.refresh();
      },
      color: AppColors.primary,
      backgroundColor: Colors.white.withValues(alpha: 0.9),
      // PagedListView now handles the scrolling natively across the full screen
      child: PagedListView<int, Properties>.separated(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        pagingController: _pagingController,
        separatorBuilder: (context, index) => SizedBox(height: 16.h),
        builderDelegate: PagedChildBuilderDelegate<Properties>(
          itemBuilder: (context, item, index) {
            // If it's the very first item, render your headers and buttons directly above it
            if (index == 0) {
              return Column(
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
                  BlocBuilder<MyPropertiesCubit, MyPropertiesState>(
                    builder: (context, state) {
                      int totalCount = 0;
                      if (state is MyPropertiesSuccess) {
                        totalCount = state.response.data?.totalCount ?? 0;
                      }
                      return Text(
                        'Manage and monitor your $totalCount property listings',
                        style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                      );
                    },
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
                  PropertyCard(property: item),
                ],
              );
            }

            // Standard listing items
            return PropertyCard(property: item);
          },

          firstPageProgressIndicatorBuilder: (_) => const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          ),
          newPageProgressIndicatorBuilder: (_) => const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
          ),
          noItemsFoundIndicatorBuilder: (_) =>  Center(
            child: Padding(
              padding: EdgeInsets.only(top: 80.0.r),
              child: Text('No properties found.'),
            ),
          ),
          firstPageErrorIndicatorBuilder: (context) => Center(
            child: Text(_pagingController.error?.toString() ?? 'Something went wrong'),
          ),
        ),
      ),
    );
  }
}