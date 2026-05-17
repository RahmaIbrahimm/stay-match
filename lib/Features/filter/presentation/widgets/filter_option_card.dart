import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/Features/filter/presentation/widgets/filter_helper.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_styles.dart';

class FilterOptionCard extends StatefulWidget {
  FilterOptionCard({
    super.key,
    required this.title,
    this.desc,
    required this.icon,
    this.bottomWidget,
    required this.isSelected,
    required this.onChangeVoid,
    required this.onChangedBool,
  });

  final String title;
  final String? desc;
  final Widget icon;
  final Widget? bottomWidget;
  bool isSelected;
  final OnChangedBool onChangedBool;
  final VoidCallback onChangeVoid;

  @override
  State<FilterOptionCard> createState() => _FilterOptionCardState();
}

class _FilterOptionCardState extends State<FilterOptionCard> {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: GestureDetector(
        onTap: () {
          widget.onChangeVoid();
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 100),
          padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 16.r),
          margin: EdgeInsets.only(left: 8.r, right: 8.r),
          decoration: BoxDecoration(
            color: AppColors.containerColor,
            border: Border.all(
              color: widget.isSelected ? AppColors.primary : AppColors.blueGrey,
            ),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Column(
            spacing: 16.h,
            children: [
              Row(
                spacing: 16.w,
                children: [
                  Container(
                    padding: EdgeInsets.all(16.r),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      color: AppColors.blueGrey,
                    ),
                    child: widget.icon,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: widget.title,
                          style: AppStyles.semiBold14poppins.copyWith(
                            color: AppColors.textColorPrimary,
                          ),
                        ),
                        if (widget.desc != null)
                          TextSpan(
                            text: widget.desc,
                            style: AppStyles.regular12poppins.copyWith(
                              color: AppColors.textColorSecondary,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              if (widget.bottomWidget != null) widget.bottomWidget!,
            ],
          ),
        ),
      ),
    );
  }
}