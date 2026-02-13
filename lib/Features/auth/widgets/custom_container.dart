import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key, required this.containerBody,
  });
  final Widget containerBody;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 16),
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.containerColor,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: Colors.black)
      ),
      child:  containerBody,
    );
  }
}