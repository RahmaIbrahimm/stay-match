//
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:stay_match/core/constants/app_strings.dart';
//
// import '../../../../core/constants/app_colors.dart';
// import '../../../../core/constants/app_styles.dart';
//
// enum PropertyType { apartment, room }
// enum FilterTypeGender { student, worker }
// enum FilterType{
//   who,
//   where,
//   when
// }
// typedef OnFiltersChanged =
//     void Function({
//       bool? allowsFamilies,
//       bool? allowsChildren,
//       bool? allowsStudents,
//       String? studentGender,
//       bool? allowsWorkers,
//       String? workerGender,
//       bool? onlyAvailable,
//       PropertyType? filterType,
//     });
// typedef OnChangeGender = void Function(String? value);
// typedef OnChangedBool = void Function(bool? value);
// class FilterHelper {
//   static void _showDateRequiredSnackBar(BuildContext context) {
//     final messenger = ScaffoldMessenger.maybeOf(context);
//     if (messenger == null) {
//       return;
//     }
//
//     messenger
//       ..clearSnackBars()
//       ..showSnackBar(
//         SnackBar(
//           behavior: SnackBarBehavior.floating,
//           margin: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 24.h),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16.r),
//           ),
//           elevation: 6,
//           content: Text(
//             AppStrings.theCheckInDateCantBeEmpty,
//             style: AppStyles.medium14poppins.copyWith(
//               color: AppColors.textColorWhite,
//             ),
//           ),
//         ),
//       );
//   }
// }
//
//
//
//

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/core/constants/app_strings.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_styles.dart';

enum PropertyType { apartment, room }
enum FilterTypeGender { student, worker }
enum FilterType {
  who,
  where,
  when
}

typedef OnFiltersChanged = void Function({
bool? allowsFamilies,
bool? allowsChildren,
bool? allowsStudents,
String? studentGender,
bool? allowsWorkers,
String? workerGender,
bool? onlyAvailable,
PropertyType? filterType,
});

typedef OnChangeGender = void Function(String? value);
typedef OnChangedBool = void Function(bool? value);

class FilterHelper {
  static void showDateRequiredSnackBar(BuildContext context) {
    final messenger = ScaffoldMessenger.maybeOf(context);
    if (messenger == null) {
      return;
    }

    messenger
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 24.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          elevation: 6,
          content: Text(
            AppStrings.theCheckInDateCantBeEmpty,
            style: AppStyles.medium14poppins.copyWith(
              color: AppColors.textColorWhite,
            ),
          ),
        ),
      );
  }


  static String formatDate(dynamic value) {
    if (value == null) return '';
    if (value is DateTime) {
      return DateFormat('yyyy-MM-dd').format(value);
    }
    if (value is String) {
      final parsed = DateTime.tryParse(value);
      if (parsed != null) {
        return DateFormat('yyyy-MM-dd').format(parsed);
      }
      return value; // fallback if backend returns non-ISO string
    }
    return value.toString();
  }

  // Extracted from repeated bottom sheet code
  static void showFilterBottomSheet({
    required BuildContext context,
    required Widget Function(BuildContext) builder,
  }) {
    Scaffold.of(context).showBottomSheet(
      backgroundColor: AppColors.containerColor,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder,
    );
  }
}