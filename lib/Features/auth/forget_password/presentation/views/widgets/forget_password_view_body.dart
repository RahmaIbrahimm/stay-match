import 'package:flutter/material.dart';

import '../../../../../../core/constants/app_images.dart';
import 'forget_password_container.dart';

class ForgetPasswordViewBody extends StatelessWidget {
  const ForgetPasswordViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.forgetPasswordBg),
              fit: BoxFit.fill,
            ),
          ),
        ),
        ForgetPasswordContainer(size: size),
      ],
    );
  }
}