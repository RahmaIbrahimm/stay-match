import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_styles.dart';

class GenderSwitch extends StatefulWidget {
  GenderSwitch({super.key, required this.current});

  String current;

  @override
  State<GenderSwitch> createState() => _GenderSwitchState();
}

class _GenderSwitchState extends State<GenderSwitch> {
  @override
  Widget build(BuildContext context) {
    return AnimatedToggleSwitch<String>.size(
      current: widget.current,
      values: const ['Male', 'Female'],
      onChanged: (String value) {
        setState(() => widget.current = value);
      },
      height: 45,
      spacing: 2,
      animationDuration: Duration(milliseconds: 200),
      style: ToggleStyle(
        backgroundColor: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12.r),
        indicatorColor: Colors.white,
        borderColor: Colors.transparent,
      ),
      indicatorSize: const Size.fromWidth(double.infinity),
      customIconBuilder: (context, local, global) {
        return Center(
          child: Text(
            local.value,
            style: AppStyles.medium12poppins.copyWith(
              color: local.value == widget.current
                  ? AppColors.textColorSecondary
                  : Colors.grey[900],
            ),
          ),
        );
      },
    );
  }
}