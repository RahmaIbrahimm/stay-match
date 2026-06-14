import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';

class VerifyEmailOTP extends StatelessWidget {
  const VerifyEmailOTP({
    super.key,
    required this.validator,
    required this.controller,
  });
  final String? Function(String?) validator;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Pinput(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
      ],
      validator: validator,
      controller: controller,
    );
  }
}