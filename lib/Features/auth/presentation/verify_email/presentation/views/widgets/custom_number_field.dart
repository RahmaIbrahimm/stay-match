import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../../../core/constants/app_colors.dart';
import '../../../../../../../core/constants/app_styles.dart';


class CustomNumberField extends StatelessWidget {
  const CustomNumberField({
    super.key, required this.validator,
  });
  final String? Function(String?) validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      expands: false,
      maxLength: 1,

      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
      ],
      textAlign: TextAlign.center,

      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.transparent),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.transparent),
        ),
        hintText: '-',
        hintStyle: AppStyles.cardTitle,

        fillColor: AppColors.grey,
        filled: true,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.width * 0.15,
          maxWidth: MediaQuery.of(context).size.width * 0.15,
        ),
        counterText: '',
      ),
    );
  }
}