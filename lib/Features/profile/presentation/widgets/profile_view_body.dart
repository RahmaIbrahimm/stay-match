import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/Features/add_property/presentation/widgets/shared/add_property_app_bar.dart';
import 'package:stay_match/core/constants/app_strings.dart';
import 'package:stay_match/core/constants/app_styles.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: Text(AppStrings.editProfile, style: AppStyles.bold20poppins),
          centerTitle: true,
          pinned: true,
          leading: Icon(Icons.arrow_back, color: Colors.black),
          actions: [Icon(Icons.menu,color: Colors.black,)],
          actionsPadding: EdgeInsetsGeometry.directional(end: 12.w),
        ),

      ],
    );
  }
}