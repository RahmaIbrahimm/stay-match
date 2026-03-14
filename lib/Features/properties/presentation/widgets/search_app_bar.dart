import 'package:flutter/material.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/widgets/custom_text_form_field.dart';

import '../../../../core/constants/app_strings.dart';

class SearchAppBar extends StatelessWidget {
  const SearchAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      leading: Container(),
      title: Container(),
      backgroundColor: Colors.white,
      pinned: true,
      // todo: implement search logic :)
      flexibleSpace: FlexibleSpaceBar(
        expandedTitleScale: 1,
        centerTitle: true,
        title: CustomTextFormField(
          hasShadow: false,
          suffixIcon: Icon(
            Icons.search,
            color: AppColors.textColorSecondary,
            size: 20,
          ),
          strokeWidth: 1,
          borderRadius: 12,
          strokeColor: AppColors.textColorSecondary,
          verticalPadding: 10,
          hintText: AppStrings.search,
          validator: (v) {
            return null;
          },
          controller: TextEditingController(),
        ),
      ),
    );
  }
}