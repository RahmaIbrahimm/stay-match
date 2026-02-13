import 'package:flutter/material.dart';

import '../../../core/constants/app_images.dart';
class GradientBackground extends StatelessWidget {
  const GradientBackground({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.gradientBg),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}