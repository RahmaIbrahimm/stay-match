import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/core/constants/app_colors.dart';

class CustomToggleSwitch extends StatefulWidget {
  const CustomToggleSwitch({
    super.key,
    required this.onTap,
    required this.current, this.height, this.width,
  });

  final VoidCallback onTap;
  final bool current;
  final double? height;
  final double? width;
  @override
  State<CustomToggleSwitch> createState() => _CustomToggleSwitchState();
}

// class _CustomToggleSwitchState extends State<CustomToggleSwitch> {
//   late bool isOn = widget.current;
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           log('${widget.current}');
//           isOn = !isOn;
//         });
//       },
//       child: AnimatedContainer(
//         duration: Duration(milliseconds: 300),
//         width: 50,
//         height: 28,
//         padding: EdgeInsets.all(4),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20),
//           color: isOn ? AppColors.primary : Colors.grey,
//         ),
//         child: AnimatedAlign(
//           duration: Duration(milliseconds: 200),
//           alignment: isOn ? Alignment.centerRight : Alignment.centerLeft,
//           child: Container(
//             width:widget.width?? 20,
//             height:widget.height?? 25,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: AppColors.containerColor,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class _CustomToggleSwitchState extends State<CustomToggleSwitch> {
  late bool isOn;

  @override
  void initState() {
    super.initState();
    isOn = widget.current;
  }

  // 1. This prevents "breaking" when the Cubit updates the value.
  // It ensures that if the 'current' prop changes from outside, the switch follows.
  @override
  void didUpdateWidget(covariant CustomToggleSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.current != oldWidget.current) {
      setState(() {
        isOn = widget.current;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // 2. We trigger the internal animation first
        setState(() {
          isOn = !isOn;
        });
        // 3. CRITICAL: We call the callback so the Cubit actually updates.
        // Without this line, the 'Yes/No' text in your Row won't change.
        widget.onTap();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 50,
        height: 28,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: isOn ? AppColors.primary : Colors.grey,
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 200),
          alignment: isOn ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: widget.width ?? 20.r,
            height: widget.height ?? 20.r, // Keep it circular for a better look
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