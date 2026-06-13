import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stay_match/Features/booking/presentation/manager/booking_request_cubit.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_styles.dart';

class FilterByLocationAndCalendar extends StatelessWidget {
  const FilterByLocationAndCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<BookingRequestCubit>();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.02),
                    blurRadius: 8.r,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(
                      Icons.search, size: 20.r, color: const Color(0xFF9CA3AF)),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: TextField(
                      onChanged: (value) => cubit.updateRenterSearch(value),
                      style: AppStyles.regular14poppins.copyWith(
                        color: const Color(0xFF111827),
                      ),
                      decoration: InputDecoration(
                        hintText: 'Search by location',
                        hintStyle: AppStyles.regular14poppins.copyWith(
                          color: const Color(0xFF9CA3AF),
                        ),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 12.w),
          GestureDetector(
            onTap: () => _showFlexibleDateFilterBottomSheet(context, cubit),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                'Calendar',
                style: AppStyles.medium14poppins.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showFlexibleDateFilterBottomSheet(BuildContext context,
      BookingRequestCubit cubit) {
    int? selectedYear = cubit.renterSelectedYear;
    int? selectedMonth = cubit.renterSelectedMonth;
    int? selectedDay = cubit.renterSelectedDay;
    String? errorMessage;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      // Allows for better spacing
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r))),
      builder: (context) {
        var start = DateTime.now().subtract(Duration(days: 10*365));
        List<int?> years = List.generate(15, (i) => start.year + i);
        years.insert(0, null);
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: EdgeInsets.fromLTRB(24.r, 24.r, 24.r, 32.r),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Filter by Date', style: AppStyles.bold18poppins),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      Expanded(child: _buildLabeledDropdown(
                          'Year', selectedYear, years, (v) =>
                      selectedYear = v, (v) => v?.toString() ?? 'All',
                          setModalState)),
                      SizedBox(width: 8.w),
                      Expanded(child: _buildLabeledDropdown(
                          'Month', selectedMonth,
                          [null, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], (v) =>
                      selectedMonth = v, (v) =>
                      v == null ? 'All' : [
                        'Jan',
                        'Feb',
                        'Mar',
                        'Apr',
                        'May',
                        'Jun',
                        'Jul',
                        'Aug',
                        'Sep',
                        'Oct',
                        'Nov',
                        'Dec'
                      ][v - 1], setModalState)),
                      SizedBox(width: 8.w),
                      Expanded(child: _buildLabeledDropdown(
                          'Day', selectedDay, [null, ...List.generate(
                          31, (i) => i + 1)
                      ], (v) => selectedDay = v, (v) => v?.toString() ?? 'All',
                          setModalState)),
                    ],
                  ),

                  // In-line error message instead of Snack Bar
                  if (errorMessage != null) ...[
                    SizedBox(height: 12.h),
                    Text(errorMessage!,
                        style: AppStyles.medium12poppins.copyWith(
                            color: const Color(0xFFEF4444))),
                  ],

                  SizedBox(height: 24.h),

                  // Buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF6B7280),
                            side: const BorderSide(color: Color(0xFFE5E7EB)),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r)),
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                          ),
                          onPressed: () {
                            setModalState(() {
                              selectedYear = selectedMonth = selectedDay = null;
                              errorMessage = null;
                            });
                            cubit.clearRenterDateFilters();
                            context.pop(context);
                          },
                          child: Text('Reset', style: AppStyles.bold14poppins),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r)),
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                          ),
                          onPressed: () {
                            if (selectedDay != null && (selectedMonth == null ||
                                selectedYear == null)) {
                              setModalState(() =>
                              errorMessage =
                              'Please select a Year and Month first.');
                            } else {
                              cubit.applyRenterDateFilters(year: selectedYear,
                                  month: selectedMonth,
                                  day: selectedDay);
                              Navigator.pop(context);
                            }
                          },
                          child: Text('Apply Filter',
                              style: AppStyles.bold14poppins.copyWith(
                                  color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

// Helper to bundle Label + Dropdown
  Widget _buildLabeledDropdown<T>(String label, T? value, List<T?> items,
      Function(T?) onChanged, String Function(T?) labelBuilder,
      StateSetter setModalState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppStyles.bold12poppins.copyWith(
            color: const Color(0xFF6B7280))),
        SizedBox(height: 4.h),
        _buildFilterDropdown<T?>(
          hint: label,
          value: value,
          items: items,
          itemLabel: labelBuilder,
          onChanged: (val) => setModalState(() => onChanged(val)),
        ),
      ],
    );
  }
  Widget _buildFilterDropdown<T>({
    required String hint,
    required T value,
    required List<T> items,
    required String Function(T) itemLabel,
    required ValueChanged<T?> onChanged,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          hint: Text(hint, style: AppStyles.regular12poppins.copyWith(color: const Color(0xFF9CA3AF))),
          isExpanded: true,
          icon: Icon(Icons.keyboard_arrow_down, color: const Color(0xFF6B7280), size: 18.r),
          borderRadius: BorderRadius.circular(12.r),
          menuMaxHeight: 250.h,
          items: items.map((T item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Text(itemLabel(item), style: AppStyles.medium14poppins.copyWith(color: const Color(0xFF111827))),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}