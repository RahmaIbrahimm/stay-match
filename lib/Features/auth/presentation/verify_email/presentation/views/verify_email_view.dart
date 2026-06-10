import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/verify_email_view_body.dart';

class VerifyEmailView extends StatelessWidget {
  const VerifyEmailView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          leading: BackButton(onPressed: () {
            if (context.canPop()) context.pop();
          }, color: Colors.white,),
          elevation: 0,
          foregroundColor: Colors.transparent,
          shadowColor: Colors.transparent,

        ),
        extendBodyBehindAppBar: true,
        body: VerifyEmailViewBody()));
  }
}