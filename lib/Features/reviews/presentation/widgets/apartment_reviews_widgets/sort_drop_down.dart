import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/app_styles.dart';
import '../shared/reviews_helpers.dart';

class SortDropdown extends StatefulWidget {
  final ReviewSortOption current;
  final ValueChanged<ReviewSortOption> onChanged;

  const SortDropdown({super.key, required this.current, required this.onChanged});

  @override
  State<SortDropdown> createState() => _SortDropdownState();
}

class _SortDropdownState extends State<SortDropdown>
    with SingleTickerProviderStateMixin {
  OverlayEntry? _overlay;
  final LayerLink _link = LayerLink();
  late AnimationController _anim;
  late Animation<double> _rotate;

  @override
  void initState() {
    super.initState();
    _anim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 180),
    );
    _rotate = Tween(
      begin: 0.0,
      end: 0.5,
    ).animate(CurvedAnimation(parent: _anim, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _closeOverlay();
    _anim.dispose();
    super.dispose();
  }

  void _openOverlay() {
    _anim.forward();
    _overlay = OverlayEntry(
      builder: (context) => Stack(
        children: [
          // Transparent barrier to close on outside tap
          Positioned.fill(
            child: GestureDetector(
              onTap: _closeOverlay,
              behavior: HitTestBehavior.translucent,
              child: const SizedBox.expand(),
            ),
          ),
          // The dropdown panel — anchored to the pill via CompositedTransformFollower
          CompositedTransformFollower(
            link: _link,
            showWhenUnlinked: false,
            targetAnchor: Alignment.bottomRight,
            followerAnchor: Alignment.topRight,
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: 160.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.r),
                    bottomLeft: Radius.circular(10.r),
                    bottomRight: Radius.circular(10.r),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.12),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: ReviewSortOption.values.map((opt) {
                    final selected = opt == widget.current;
                    return GestureDetector(
                      onTap: () {
                        widget.onChanged(opt);
                        _closeOverlay();
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 14.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            left: BorderSide(
                              color: selected
                                  ? RColors.primary
                                  : Colors.transparent,
                              width: 3,
                            ),
                          ),
                        ),
                        child: Text(
                          opt.label,
                          style:
                              (selected
                                      ? AppStyles.semiBold14poppins
                                      : AppStyles.regular14poppins)
                                  .copyWith(
                                    color: selected
                                        ? RColors.textPrimary
                                        : RColors.textSecondary,
                                  ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
    Overlay.of(context).insert(_overlay!);
  }

  void _closeOverlay() {
    _anim.reverse();
    _overlay?.remove();
    _overlay = null;
    if (mounted) setState(() {});
  }

  void _toggle() {
    if (_overlay != null) {
      _closeOverlay();
    } else {
      setState(() {});
      _openOverlay();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _link,
      child: GestureDetector(
        onTap: _toggle,
        child: Container(
          width: 160.w,
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: RColors.primary,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.r),
              topRight: Radius.circular(10.r),
              bottomLeft: Radius.circular(_overlay != null ? 0 : 10.r),
              bottomRight: Radius.circular(_overlay != null ? 0 : 10.r),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.current.label,
                style: AppStyles.semiBold12poppins.copyWith(
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 6.w),
              RotationTransition(
                turns: _rotate,
                child: Icon(
                  Icons.keyboard_arrow_up_rounded,
                  size: 16.r,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}