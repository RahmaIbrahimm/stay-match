import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  StickyTabBarDelegate({required this.child});

  @override
  double get minExtent => 54.h;

  @override
  double get maxExtent => 54.h;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: const Color(0xFFF8F9FC),
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: child,
    );
  }

  @override
  bool shouldRebuild(covariant StickyTabBarDelegate oldDelegate) {
    return oldDelegate.child != child;
  }
}