import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/constants/app_styles.dart';
import '../../manager/add_property_cubit.dart';

class AddPropertyAppBar extends StatelessWidget {
  const AddPropertyAppBar({
    super.key,
    required this.cubit,
    this.centerTitle = true,
    required this.title,
  });

  final AddPropertyCubit cubit;
  final bool centerTitle;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.white,
      centerTitle: centerTitle,
      elevation: 0,
      leading: cubit.currentStep == 0
          ? null
          : IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                cubit.prevStep();
                Future.microtask(() {
                  if (context.mounted) {
                    context.pop();
                  }
                });
              },
            ),
      title: Text(title, style: AppStyles.bold20poppins),
    );
  }
}