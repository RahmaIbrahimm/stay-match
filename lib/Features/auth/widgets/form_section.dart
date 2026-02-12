import 'package:flutter/material.dart';

import '../../../core/constants/app_styles.dart';
import '../../../core/widgets/custom_text_form_field.dart';
class FormSection extends StatelessWidget {
  const FormSection(
      {super.key, required this.validator, required this.hintText, required this.fieldTitle});

  final String? Function(String?) validator;
  final String hintText;
  final String fieldTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Todo: add validator
        Text(fieldTitle, style: AppStyles.sectionTitle,),
        CustomTextFormField(
            hintText: hintText, validator: validator)
      ],
    );
  }
}