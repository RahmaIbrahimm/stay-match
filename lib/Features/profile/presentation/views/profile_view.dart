import 'package:flutter/material.dart';
import 'package:stay_match/core/widgets/app_drawer/main_app_drawer.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_styles.dart';
import '../widgets/profile_body.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: MainAppDrawer(),
      appBar: AppBar(
        title: Text(AppStrings.editProfile, style: AppStyles.semiBold20poppins),
        backgroundColor: AppColors.containerColor,
        centerTitle: true,
      ),
        body: ProfileBody()
    );
  }


}