import 'package:flutter/material.dart';
import '../widgets/add_property_widgets/add_property_body.dart';
class AddPropertyView extends StatelessWidget {
  const AddPropertyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AddPropertyBody(),
    );
  }

}