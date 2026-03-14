import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:stay_match/core/constants/app_strings.dart';
import '../constants/app_colors.dart';
import '../constants/app_styles.dart';
class CustomDateSelector extends StatefulWidget {
  const CustomDateSelector({
    super.key,
    required this.size,
    required this.dateController
  });

  final Size size;
  final TextEditingController dateController;
  @override
  State<CustomDateSelector> createState() => _CustomDateSelectorState();
}

class _CustomDateSelectorState extends State<CustomDateSelector> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()async {
        var results = await showCalendarDatePicker2Dialog(
          context: context,
          config: CalendarDatePicker2WithActionButtonsConfig(
            selectedDayHighlightColor: AppColors.primary,
            firstDate: DateTime.now().subtract(Duration(days: 110 * 365)),
            currentDate: DateTime.now(),
            lastDate: DateTime.now(),
            animateToDisplayedMonthDate: true,
            gapBetweenCalendarAndButtons: 16,
          ),
          dialogSize: Size(widget.size.width * 0.8, widget.size.height * 0.25),
          borderRadius: BorderRadius.circular(15),
        );
        if (results != null) {
          widget.dateController.text =
          '${results[0]?.year}-${results[0]?.month != null ? (results[0]!.month < 10 ? '0${results[0]!.month}' : results[0]!.month.toString()) : ''}-${results[0]?.day != null ? (results[0]!.day < 10 ? '0${results[0]!.day}' : results[0]!.day.toString()) : ''}';
          setState(() {

          });
        }
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(
          right: 8,
          left: 16,
          top: 16,
          bottom: 16,
        ),
        decoration: BoxDecoration(
          color: AppColors.containerColor,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color:  widget.dateController.text == AppStrings.dateFormat ? Colors.red: AppColors.primary,
            width: 2,
          ),
          boxShadow: AppColors.boxShadow,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.dateController.text ,
              style: AppStyles.regular12poppins,
            ),
            Icon(
              Icons.calendar_month,
              color: AppColors.primary,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}