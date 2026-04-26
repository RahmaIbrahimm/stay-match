import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class MenuIconButton extends StatelessWidget {
  const MenuIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      // todo : Implement menu button
    onPressed: () {
     if(context.mounted) Scaffold.of(context).openDrawer();
    },
      icon: Icon(Icons.menu, color: AppColors.textColorPrimary),
    );
  }
}