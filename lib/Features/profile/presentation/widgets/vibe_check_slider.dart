import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_styles.dart';
class VibeCheckSlider extends StatefulWidget {
  const VibeCheckSlider({
    super.key,
    required this.title,
    required this.options,
    required this.initialValue,
    required this.onChanged,
  });

  final String title;
  final List<String> options;
  final int initialValue; // Index of the options list
  final ValueChanged<int> onChanged;

  @override
  State<VibeCheckSlider> createState() => _VibeCheckSliderState();
}

class _VibeCheckSliderState extends State<VibeCheckSlider> {
  late double _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.title,
              style: AppStyles.regular14poppins.copyWith(color: const Color(0xFF5A6B87)),
            ),
            Text(
              widget.options[_currentValue.toInt()],
              style: AppStyles.bold14poppins.copyWith(color: AppColors.primary),
            ),
          ],
        ),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 6.h,
            activeTrackColor: AppColors.primary.withValues(alpha: 0.2),
            inactiveTrackColor: AppColors.primary.withValues(alpha: 0.1),
            thumbColor: AppColors.primary,
            overlayColor: AppColors.primary.withValues(alpha: 0.1),
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8.r),
            // Removes the default tick marks for a cleaner look like the image
            tickMarkShape: SliderTickMarkShape.noTickMark,
          ),
          child: Slider(
            value: _currentValue,
            min: 0,
            max: (widget.options.length - 1).toDouble(),
            divisions: widget.options.length - 1,
            onChanged: (value) {
              setState(() {
                _currentValue = value;
              });
              widget.onChanged(value.toInt());
            },
          ),
        ),
        SizedBox(height: 10.h),
      ],
    );
  }
}