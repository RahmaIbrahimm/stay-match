import 'package:flutter/material.dart';

class FilterContainer extends StatelessWidget {
  const FilterContainer({super.key, required this.filterContainerBody});

  final Widget filterContainerBody;

  @override
  Widget build(BuildContext context) {
    return filterContainerBody;
  }
}