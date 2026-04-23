import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:stay_match/Features/filter/presentation/manager/filter_cubit.dart';
import 'package:stay_match/Features/filter/presentation/widgets/filter_bottom_sheet_app_bar.dart';
import 'package:stay_match/Features/filter/presentation/widgets/filter_helper.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_strings.dart';
import 'package:stay_match/core/constants/app_styles.dart';

import 'apply_button_sliver.dart';

class FilterSheetWhen extends StatefulWidget {
  const FilterSheetWhen({super.key, required this.propertyType});

  final PropertyType propertyType;

  @override
  State<FilterSheetWhen> createState() => _FilterSheetWhenState();
}

class _FilterSheetWhenState extends State<FilterSheetWhen> {
  List<DateTime?> _dates = [];
  int numMonthsToStay = 1;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        FilterBottomSheetAppBar(
          propertyType: widget.propertyType,
          filterType: FilterType.when,
        ),
        SliverToBoxAdapter(
          child: CalendarDatePicker2(
            config: CalendarDatePicker2Config(
              monthTextStyle: AppStyles.semiBold14poppins.copyWith(
                color: AppColors.textColorPrimary,
              ),
              yearTextStyle: AppStyles.semiBold14poppins.copyWith(
                color: AppColors.textColorPrimary,
              ),
              weekdayLabelTextStyle: AppStyles.bold14poppins.copyWith(
                color: AppColors.textColorSecondary,
              ),
              weekdayLabels: AppStrings.weekDayLabels,
              selectedYearTextStyle: AppStyles.bold14poppins.copyWith(
                color: AppColors.textColorWhite,
              ),
              selectedDayTextStyle: AppStyles.bold14poppins.copyWith(
                color: AppColors.textColorWhite,
              ),
              selectedMonthTextStyle: AppStyles.bold14poppins.copyWith(
                color: AppColors.textColorWhite,
              ),
              selectedDayHighlightColor: AppColors.primary,
              dayTextStyle: AppStyles.semiBold14poppins.copyWith(
                color: AppColors.textColorPrimary,
              ),
              disabledDayTextStyle: AppStyles.regular14poppins.copyWith(
                color: AppColors.textColorSecondary,
              ),
              disabledMonthTextStyle: AppStyles.regular14poppins.copyWith(
                color: AppColors.textColorSecondary,
              ),
              disabledYearTextStyle: AppStyles.regular14poppins.copyWith(
                color: AppColors.textColorSecondary,
              ),
              currentDate: DateTime.now(),
              firstDate: DateTime.now(),
              calendarType: CalendarDatePicker2Type.single,
            ),
            value: _dates,
            onValueChanged: (dates) {
              setState(() {
                _dates = dates;
              });
            },
          ),
        ),
        SliverToBoxAdapter(
          child: RPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: AppStrings.checkOut,
                        style: AppStyles.semiBold16poppins.copyWith(
                          color: AppColors.textColorPrimary,
                        ),
                      ),
                      TextSpan(
                        text: '\n${AppStrings.addMonths}',
                        style: AppStyles.regular12poppins.copyWith(
                          color: AppColors.textColorSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  spacing: 16.w,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          numMonthsToStay--;
                          if (numMonthsToStay < 1) {
                            numMonthsToStay = 1;
                          }
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(10.r),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(999.r),
                          border: Border.all(color: AppColors.blueGrey),
                        ),
                        child: Icon(
                          FontAwesome.minus_solid,
                          size: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      numMonthsToStay.toString(),
                      style: AppStyles.medium16poppins,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          numMonthsToStay++;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(10.r),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(999.r),
                          border: Border.all(color: AppColors.blueGrey),
                        ),
                        child: Icon(
                          FontAwesome.plus_solid,
                          size: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ApplyButton(
                onPressed: () async {
                  if (_dates.isEmpty) {
                    FilterHelper.showDateRequiredSnackBar(context);
                    return;
                  }

                  setState(() {
                    isLoading = true;
                  });

                  final DateTime? selectedDate = _dates.first;

                  if (selectedDate != null) {
                    if (widget.propertyType == PropertyType.apartment) {
                      context.read<FilterCubit>().updateApartmentFilter(
                        start: selectedDate.toString(),
                        monthsCount: numMonthsToStay,
                      );
                    } else {
                      context.read<FilterCubit>().updateRoomsFilter(
                        start: selectedDate.toString(),
                        monthsCount: numMonthsToStay,
                      );
                    }
                  }

                  if (context.mounted && context.canPop()) {
                    context.pop();
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}