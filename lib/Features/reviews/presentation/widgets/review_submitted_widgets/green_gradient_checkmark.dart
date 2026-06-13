import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class GreenGradientCheckmark extends StatelessWidget {
  final double? size;

  const GreenGradientCheckmark({super.key, this.size});

  @override
  Widget build(BuildContext context) {
    final double effectiveSize = size ?? 96.w;

    return Container(
      width: effectiveSize,
      height: effectiveSize,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF22C55E),
            Color(0xFF16A34A),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x2216A34A),
            blurRadius: 15,
            offset: Offset(0, 8),
            spreadRadius: 5,
          )
        ],
      ),
      child: Icon(
        Icons.check_circle,
        color: Colors.white,
        size: effectiveSize * 0.5,
      ),
    );
  }
}