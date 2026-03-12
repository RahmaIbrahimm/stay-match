import 'package:flutter/material.dart';

import 'custom_number_field.dart';

class VerificationNumbers extends StatelessWidget {
  const VerificationNumbers({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomNumberField(validator: (p1) {  },),
        CustomNumberField(validator: (p1) {  },),
        CustomNumberField(validator: (p1) {  },),
        CustomNumberField(validator: (p1) {  },),
      ],
    );
  }
}