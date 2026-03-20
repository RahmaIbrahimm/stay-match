import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_styles.dart';

class DetailsViewAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DetailsViewAppBar({super.key, required this.title, required this.barHeight});

  final String title;
  final double barHeight;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      leading: IconButton(
        onPressed: () async {
          if (context.canPop()) context.pop(true);
        },
        icon: Icon(Icons.arrow_back, color: AppColors.primary),
      ),
      title: Text(
        title,
        style: AppStyles.bold18poppins.copyWith(
          color: AppColors.textColorPrimary,
          letterSpacing: -0.45.r,
        ),
      ),
      actions: [Icon(Icons.share, color: AppColors.primary)],
      centerTitle: true,
      backgroundColor: Colors.transparent,
      flexibleSpace: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(color: Colors.white.withValues(alpha: 0.8)),
        ),
      ),
      elevation: 0,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(barHeight);
}