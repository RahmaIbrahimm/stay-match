import 'package:flutter/material.dart';
import '../constants/app_styles.dart';
import 'custom_text_form_field.dart';

class FormSection extends StatelessWidget {
  FormSection({
    super.key,
    required this.validator,
    required this.hintText,
    required this.fieldTitle,
    this.suffixIcon,
    required this.controller,
    this.isObscure = false,
    this.stroke = true,
    this.size,
  });

  final String? Function(String?) validator;
  final String hintText;
  final String fieldTitle;
  final Widget? suffixIcon;
  final TextEditingController controller;
  final bool isObscure;
  final bool stroke;
  final Size? size;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(fieldTitle, style: AppStyles.sectionTitle),
        const SizedBox(height: 8),
        CustomTextFormField(
          hintText: hintText,
          validator: validator,
          suffixIcon: suffixIcon,
          controller: controller,
          stroke: stroke,
          isObscure: isObscure,
        ),
      ],
    );
  }
}