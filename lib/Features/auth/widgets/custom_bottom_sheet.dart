import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({super.key, required this.sheetBody});

  final Widget sheetBody;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: MediaQuery.of(context).size.height * 0.75,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        color: AppColors.containerColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      child: sheetBody,
    );
  }
}