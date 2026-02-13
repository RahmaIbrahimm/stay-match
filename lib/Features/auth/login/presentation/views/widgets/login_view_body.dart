import 'package:flutter/material.dart';

import '../../../../../../core/constants/app_colors.dart';
import 'login_view_body_bottom_sheet.dart';
import 'login_view_header.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LoginViewHeader(),
        const SizedBox(height: 20),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            height: MediaQuery.of(context).size.height * 0.75,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: AppColors.containerColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
            ),
            child: LoginViewBodyBottomSheet(),
          ),
        ),
      ],
    );
  }
}