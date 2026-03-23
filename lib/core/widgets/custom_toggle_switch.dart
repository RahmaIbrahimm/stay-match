
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:stay_match/core/constants/app_colors.dart';

class CustomToggleSwitch extends StatefulWidget {
  const CustomToggleSwitch(
      {super.key, required this.onTap, required this.current});

  final VoidCallback onTap;
  final bool current;
  @override
  State<CustomToggleSwitch> createState() => _CustomToggleSwitchState();
}

class _CustomToggleSwitchState extends State<CustomToggleSwitch> {
  late bool isOn = widget.current;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          log('${widget.current}');
          isOn = !isOn;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        width: 50,
        height: 28,
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isOn ? AppColors.primary : Colors.grey,
        ),
        child: AnimatedAlign(
          duration: Duration(milliseconds: 200),
          alignment: isOn ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 20,
            height: 25,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.containerColor,
            ),
          ),
        ),
      ),
    );
  }
}