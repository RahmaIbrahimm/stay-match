import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:stay_match/core/constants/app_icons.dart';
import 'package:stay_match/features/filter/presentation/widgets/apply_button_sliver.dart';
import 'package:stay_match/features/filter/presentation/widgets/filter_bottom_sheet_app_bar.dart';

import '../../../../core/constants/app_colors.dart';
import 'availability_sliver.dart';
import 'custom_gender_toggle.dart';
import 'filter_option_card.dart';

typedef OnWhoFilterApply =
    void Function({
      bool? allowsFamilies,
      bool? allowsChildren,
      bool? allowsStudents,
      String? workerGender,
    });

class FilterSheetWho extends StatefulWidget {
  const FilterSheetWho({
    super.key,
    required this.onApply,
    required this.allowsFamilies,
    required this.allowsChildren,
    required this.allowsStudents,
    required this.workerGender,
    this.onlyAvailable,
  });

  final OnWhoFilterApply onApply;
  final bool? allowsFamilies;
  final bool? allowsChildren;
  final bool? allowsStudents;
  final String? workerGender;
  final bool? onlyAvailable;

  @override
  State<FilterSheetWho> createState() => _FilterSheetWhoState();
}

class _FilterSheetWhoState extends State<FilterSheetWho> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        FilterBottomSheetAppBar(),
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
          bottomWidget: GenderSwitch(current: 'Female'),
        ),
        SliverToBoxAdapter(child: SizedBox(height: 6.h)),
        // workers filter
        FilterOptionCard(
          title: 'Workers',
          icon: Icon(Icons.work_rounded, size: 24.sp, color: AppColors.primary),
          bottomWidget: GenderSwitch(current: 'Female'),
        ),
        SliverToBoxAdapter(child: SizedBox(height: 6.h)),
        // availability and switch
        AvailabilitySliver(),
        // Apply button
        SliverToBoxAdapter(child: SizedBox(height: 24.h)),
        ApplyButtonSliver(onPressed: () {}),
      ],
    );
  }
}