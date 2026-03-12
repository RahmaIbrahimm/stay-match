import 'package:flutter/material.dart';
import 'package:stay_match/core/constants/app_strings.dart';
import 'package:stay_match/core/constants/app_styles.dart';

import '../../../../../core/constants/app_colors.dart';

class FindRoomView extends StatelessWidget {
  const FindRoomView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            AppStrings.stayMatch,
            style: AppStyles.logo.copyWith(
              color: AppColors.primary,
              fontSize: 20,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(10),
            child: Divider(color: AppColors.grey,)
          ),
        ),
        ),
    );
  }
}