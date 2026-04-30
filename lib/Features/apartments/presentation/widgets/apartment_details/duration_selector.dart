// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../../../../../core/constants/app_colors.dart';
// import '../../../../../core/constants/app_styles.dart';
//
// class DurationSelector extends StatelessWidget {
//   const DurationSelector({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 8),
//       decoration: BoxDecoration(
//         color: AppColors.bgGrey,
//         borderRadius: BorderRadius.circular(15),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           RichText(
//             text: TextSpan(
//               children: [
//                 TextSpan(
//                   text: 'Move In',
//                   style: AppStyles.medium15poppins.copyWith(
//                     color: AppColors.textColorPrimary,
//                   ),
//                 ),
//                 // TextSpan(
//                 //   text: 'Move In',
//                 //   style: AppStyles.medium15poppins.copyWith(color: AppColors.textColorPrimary),
//                 // ),
//               ],
//             ),
//           ),
//           Icon(Icons.keyboard_arrow_down_rounded),
//           Container(height: 55.h, width: 1, color: Colors.black),
//           RichText(
//             text: TextSpan(
//               children: [
//                 TextSpan(
//                   text: 'Duration',
//                   style: AppStyles.medium15poppins.copyWith(
//                     color: AppColors.textColorPrimary,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Icon(Icons.keyboard_arrow_down_rounded),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_styles.dart';

class DurationSelector extends StatelessWidget {
  final DateTime? selectedDate;
  final int? selectedMonths;
  final Function(DateTime) onDateChanged;
  final Function(int) onDurationChanged;
  final int minimumStay;

  const DurationSelector({
    super.key,
    required this.selectedDate,
    required this.selectedMonths,
    required this.onDateChanged,
    required this.onDurationChanged, required this.minimumStay,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F4F7), // Light grey background
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            // Move In Section
            Expanded(
              child: GestureDetector(
                onTap: () => _selectDate(context),
                behavior: HitTestBehavior.opaque,
                child: _buildColumn(
                  "Move In",
                  selectedDate == null
                      ? "Select Date"
                      : DateFormat('MMM d, yyyy').format(selectedDate!),
                ),
              ),
            ),
            // Vertical Divider
            VerticalDivider(color: Colors.black12, thickness: 1.5, width: 32.w),
            // Duration Section
            Expanded(
              child: GestureDetector(
                onTap: () => _selectDuration(context),
                behavior: HitTestBehavior.opaque,
                child: _buildColumn(
                  "Duration",
                  selectedMonths == null
                      ? "Select Stay"
                      : "$selectedMonths months",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColumn(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label,
              style: AppStyles.medium15poppins.copyWith(
                  color: AppColors.textColorPrimary),
            ),
            const Icon(Icons.keyboard_arrow_down_rounded, size: 20,
                color: Colors.black54),
          ],
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: AppStyles.bold14poppins.copyWith(color: AppColors.primary,),
        ),
      ],
    );
  }

  // CALENDAR LOGIC
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(Duration(days: 1)),
      firstDate: DateTime.now().add(Duration(days: 1)),
      lastDate: DateTime.now().add(Duration(days: 5*365)),
      builder: (context, child) =>
          Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(primary: Color(0xFF1A2E63)),
            ),
            child: child!,
          ),
    );
    if (picked != null) onDateChanged(picked);
  }

  // DURATION WHEEL LOGIC
  void _selectDuration(BuildContext context) {
    int tempSelection = selectedMonths ?? 1;
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r))),
      builder: (context) =>
          Container(
            height: 300.h,
            padding: EdgeInsets.all(16.r),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(onPressed: () => Navigator.pop(context),
                    child: const Text("Cancel")),
                Text("Select Months", style: AppStyles.bold16poppins.copyWith(
                    color: AppColors.primary)),
                TextButton(
                  onPressed: () {
                    onDurationChanged(tempSelection);
                    Navigator.pop(context);
                  },
                  child: const Text("Done"),
                ),
              ],
            ),
                Expanded(
                  child: CupertinoPicker(
                    itemExtent: 40.h,
                    scrollController: FixedExtentScrollController(
                        initialItem: tempSelection - 1),
                    onSelectedItemChanged: (index) => tempSelection = index + minimumStay,
                    children: List.generate(60-(minimumStay-1), (index) =>
                        Center(
                          child: Text(
                              "${index + minimumStay} ${(index == 0 && minimumStay == 1)
                                  ? 'month'
                                  : 'months'}"),
                        )),
                  ),
                ),
              ],
            ),
      ),
    );
  }
}