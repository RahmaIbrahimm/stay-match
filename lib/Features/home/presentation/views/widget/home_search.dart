import 'package:flutter/material.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/widgets/custom_text_form_field.dart';

class HomeSearch extends StatelessWidget {
  HomeSearch({super.key, required this.validator, required this.hintText});

  final TextEditingController controller = TextEditingController();
  final String? Function(String?) validator;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColors.containerColor),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Flexible(
              child: CustomTextFormField(
                hintText: hintText,
                validator: validator,
                controller: controller,
                stroke: false,
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ],
        ),
      ),
    );
  }
}