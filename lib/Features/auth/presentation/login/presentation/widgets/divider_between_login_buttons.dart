import 'package:flutter/material.dart';

import '../../../../../../../core/constants/app_strings.dart';
import '../../../../../../../core/constants/app_styles.dart';

class DividerBetweenLoginButtons extends StatelessWidget {
  const DividerBetweenLoginButtons({super.key, required this.size});

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Divider(
            color: Colors.black,
            thickness: 1,
            indent: size.width * 0.08,
            endIndent: 10,
          ),
        ),
        Text(AppStrings.or, style: AppStyles.medium20poppins),
        Expanded(
          child: Divider(
            color: Colors.black,
            thickness: 1,
            endIndent: size.width * 0.08,
            indent: 10,
          ),
        ),
      ],
    );
  }
}