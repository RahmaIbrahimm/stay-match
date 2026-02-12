import 'package:flutter/material.dart ';
import 'package:stay_match/core/constants/app_styles.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        overlayColor: Colors.transparent,
        textStyle:AppStyles.secondary
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}