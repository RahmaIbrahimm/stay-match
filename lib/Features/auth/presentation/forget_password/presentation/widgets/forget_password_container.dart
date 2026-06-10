import 'package:flutter/cupertino.dart';

import '../../../widgets/custom_container.dart';
import 'forget_password_container_body.dart';

class ForgetPasswordContainer extends StatelessWidget {
  const ForgetPasswordContainer({super.key});


  @override
  Widget build(BuildContext context) {
    return CustomContainer(containerBody: const ForgetPasswordContainerBody());
  }
}