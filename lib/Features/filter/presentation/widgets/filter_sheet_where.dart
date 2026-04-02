import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stay_match/core/widgets/custom_drop_down_menu.dart';
import 'package:stay_match/Features/filter/presentation/manager/filter_cubit.dart';
import 'package:stay_match/Features/filter/presentation/widgets/filter_bottom_sheet_app_bar.dart';
import 'package:stay_match/Features/filter/presentation/widgets/filter_helper.dart';

import '../../../../core/constants/app_strings.dart';

typedef OnWorkerGenderChanged = void Function(String? value);

class FilterSheetWhere extends StatefulWidget {
  FilterSheetWhere({super.key});

  @override
  State<FilterSheetWhere> createState() => _FilterSheetWhereState();
}

class _FilterSheetWhereState extends State<FilterSheetWhere> {
  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<FilterCubit>(context);
    return CustomScrollView(
      slivers: [
        FilterBottomSheetAppBar(propertyType: PropertyType.apartment,filterType: FilterType.where,),
        SliverToBoxAdapter(
          child: CustomDropDownMenu(
            menuItems: AppStrings.egyptCities,
            hintText: 'Select governorate',
          ),
        ),
      ],
    );
  }
}