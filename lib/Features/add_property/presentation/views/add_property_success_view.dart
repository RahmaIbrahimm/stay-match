import 'package:flutter/material.dart';
import 'package:stay_match/Features/add_property/presentation/widgets/add_property_success_widgets/add_property_success_body.dart';
import 'package:stay_match/core/constants/app_styles.dart';

import '../../../../core/constants/app_colors.dart';

class AddPropertySuccessView extends StatelessWidget {
  const AddPropertySuccessView({super.key, required this.id});

  final int id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgGrey,
      appBar: AppBar(
        backgroundColor: AppColors.containerColor,
        elevation: 0,
        centerTitle: true,
        leading: Container(),
        title: Text(
          'Success',
          style: AppStyles.bold18poppins.copyWith(color: AppColors.textColorPrimary)
        ),
      ),
      body: AddPropertySuccessBody(id: id,),
    );
  }


}