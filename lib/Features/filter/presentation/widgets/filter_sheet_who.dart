import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:stay_match/core/constants/app_icons.dart';
import 'package:stay_match/Features/filter/presentation/manager/filter_cubit.dart';
import 'package:stay_match/Features/filter/presentation/widgets/apply_button_sliver.dart';
import 'package:stay_match/Features/filter/presentation/widgets/filter_bottom_sheet_app_bar.dart';

import '../../../../core/constants/app_colors.dart';
import 'availability_sliver.dart';
import 'filter_helper.dart';
import 'filter_option_card.dart';
import 'gender_switch.dart';

typedef OnWorkerGenderChanged = void Function(String? value);

class FilterSheetWho extends StatefulWidget {
  FilterSheetWho({
    super.key,
    // required this.onApply,
    required this.allowsFamilies,
    required this.allowsChildren,
    required this.allowsStudents,
    required this.workerGender,
    required this.studentGender,
    this.onlyAvailable,
    required this.filterType,
    required this.allowsWorkers,
  });

  // final OnWhoFilterApply onApply;
  bool? allowsFamilies;
  bool? allowsChildren;
  bool? allowsStudents;
  String? workerGender;
  String? studentGender;
  bool? onlyAvailable;
  final PropertyType filterType;
  bool? allowsWorkers;

  @override
  State<FilterSheetWho> createState() => _FilterSheetWhoState();
}

class _FilterSheetWhoState extends State<FilterSheetWho> {
  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<FilterCubit>(context);
    return CustomScrollView(
      slivers: [
        FilterBottomSheetAppBar(propertyType: PropertyType.apartment,filterType: FilterType.who,),
        SliverToBoxAdapter(child: SizedBox(height: 16.h)),
        // families filter
        FilterOptionCard(
          title: 'Families',
          icon: Icon(
            Icons.family_restroom,
            size: 20.sp,
            color: AppColors.textColorPrimary,
          ),
          desc: '\nStandard household groups',
          onChangedBool: (bool? value) {
            widget.allowsFamilies = value ?? false;
          },
          isSelected: widget.allowsFamilies ?? false,
          onChangeVoid: () {
            widget.allowsFamilies = !(widget.allowsFamilies ?? false);
            setState(() {});
          },
        ),
        SliverToBoxAdapter(child: SizedBox(height: 6.h)),
        // children filter
        FilterOptionCard(
          title: 'Children',
          icon: ImageIcon(
            AssetImage(AppIcons.childIcon),
            size: 20.sp,
            color: AppColors.primary,
          ),
          desc: '\nAges 2-12',
          onChangedBool: (bool? value) {
            widget.allowsChildren = value ?? false;
          },
          isSelected: widget.allowsChildren ?? false,
          onChangeVoid: () {
            widget.allowsChildren = !(widget.allowsChildren ?? false);
            setState(() {});
          },
        ),
        SliverToBoxAdapter(child: SizedBox(height: 6.h)),
        // students filter
        FilterOptionCard(
          title: 'Students',
          icon: Icon(
            FontAwesome.graduation_cap_solid,
            size: 20.sp,
            color: AppColors.primary,
          ),
          bottomWidget: GenderSwitch(
            current: widget.studentGender ?? 'Male',
            genderChanged: (String? value) {
              widget.studentGender = value;
              log('student gender is:${widget.studentGender}');
            },
          ),
          onChangedBool: (bool? value) {
            widget.allowsStudents = value ?? false;
          },
          isSelected: widget.allowsStudents ?? false,
          onChangeVoid: () {
            widget.allowsStudents = !(widget.allowsStudents ?? false);
            setState(() {});
          },
        ),
        SliverToBoxAdapter(child: SizedBox(height: 6.h)),
        // workers filter
        FilterOptionCard(
          title: 'Workers',
          icon: Icon(Icons.work_rounded, size: 24.sp, color: AppColors.primary),
          bottomWidget: GenderSwitch(
            current: widget.workerGender ?? 'Male',
            genderChanged: (String? value) {
              widget.workerGender = value;
              log('worker gender is:${widget.workerGender}');
            },
          ),
          onChangedBool: (bool? value) {
            widget.allowsWorkers = value ?? false;
          },
          isSelected: widget.allowsWorkers ?? false,
          onChangeVoid: () {
            widget.allowsWorkers = !(widget.allowsWorkers ?? false);
            setState(() {});
          },
        ),
        SliverToBoxAdapter(child: SizedBox(height: 6.h)),
        // availability and switch
        AvailabilitySliver(
          current: widget.onlyAvailable ?? true,
          propertyType: widget.filterType,
        ),
        // Apply button
        SliverToBoxAdapter(child: SizedBox(height: 24.h)),
        BlocConsumer<FilterCubit, FilterState>(
          listener: (context, state) {
            // TODO: implement listener
            var cubit = BlocProvider.of<FilterCubit>(context);
            if (state is ApartmentFilterFailure) {
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.errMessage)));
            }
            if (state is RoomsFilterFailure) {
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.errMessage)));
            }
          },
          builder: (context, state) {
            bool isLoading =
                state is ApartmentFilterLoading || state is RoomsFilterLoading;
            return SliverToBoxAdapter(
              child: ApplyButton(
                onPressed: () async {
                  try {
                    if (widget.filterType == PropertyType.apartment) {
                      bool reset =
                          (widget.allowsStudents == false) ||
                          (widget.allowsFamilies == false) ||
                          (widget.allowsWorkers == false) ||
                          (widget.allowsChildren == false);
                      reset ? cubit.resetApartmentFilters()
                          : await cubit.updateApartmentFilter(
                              allowsFamilies: widget.allowsFamilies,
                              allowsChildren: widget.allowsChildren,
                              allowsStudents: widget.allowsStudents,
                              allowsWorkers: widget.allowsWorkers,
                              studentGender: (widget.allowsStudents ?? false)
                                  ? widget.studentGender
                                  : null,
                              workerGender: (widget.allowsWorkers ?? false)
                                  ? widget.workerGender
                                  : null,
                            );
                    } else {
                      await cubit.updateRoomsFilter(
                        allowsFamilies: widget.allowsFamilies,
                        allowsChildren: widget.allowsChildren,
                        allowsStudents: widget.allowsStudents,
                        allowsWorkers: widget.allowsWorkers,
                        studentGender: (widget.allowsStudents ?? false)
                            ? widget.studentGender
                            : null,
                        workerGender: (widget.allowsWorkers ?? false)
                            ? widget.workerGender
                            : null,
                      );
                    }
                    if (mounted) context.pop();
                  } catch (e, stackTrace) {
              
                    rethrow;
                  }
                },
                isLoading: isLoading,
              ),
            );
          },
        ),
      ],
    );
  }
}