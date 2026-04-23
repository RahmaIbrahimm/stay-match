import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/Features/add_property/presentation/widgets/add_basic_info_widgets/counter_widget.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_styles.dart';

class CounterRow extends StatelessWidget {
  const CounterRow({super.key, required this.context, required this.title, required this.sub, required this.val});

  final BuildContext context;
  final String title;
  final String sub;
  final int val;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F9FC),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppStyles.semiBold14poppins),
              Text(
                sub,
                style: AppStyles.regular12poppins.copyWith(
                  color: AppColors.textColorSecondary,
                ),
              ),
            ],
          ),
          CounterWidget(context: context,cubitKey:  title,val:  val),
        ],
      ),
    );
  }

}