import 'package:flutter/cupertino.dart';

import '../../../widgets/custom_container.dart';
import 'forget_password_container_body.dart';

class ForgetPasswordContainer extends StatelessWidget {
  const ForgetPasswordContainer({super.key, required this.size});

  final Size size;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(containerBody: ForgetPasswordContainerBody());
  }
}