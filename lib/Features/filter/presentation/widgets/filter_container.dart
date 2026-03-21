import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import 'filter_sheet_who.dart';

typedef OnWhoFilterApply = void Function({
bool? allowsFamilies,
bool? allowsChildren,
bool? allowsStudents,
String? workerGender,
});

class FilterContainer extends StatelessWidget {
  const FilterContainer({
    super.key, required this.filterContainerBody,
  });

  final Widget filterContainerBody;

  @override
  Widget build(BuildContext context) {
    return filterContainerBody;
  }
}