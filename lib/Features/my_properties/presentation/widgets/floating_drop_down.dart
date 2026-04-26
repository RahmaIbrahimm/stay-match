import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:stay_match/core/constants/app_colors.dart';

import '../../../../core/constants/app_styles.dart';
import '../manager/my_properties_cubit.dart';
//
// class FloatingDropDown extends StatefulWidget {
//   const FloatingDropDown({super.key, required this.context});
//
//   final BuildContext context;
//
//   @override
//   State<FloatingDropDown> createState() => _FloatingDropDownState();
// }
//
// class _FloatingDropDownState extends State<FloatingDropDown> {
//   final _overlayController = OverlayPortalController();
//   final _layerLink = LayerLink();
//   String selectedFilter = 'All Properties';
//   bool isOpen = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return CompositedTransformTarget(
//       link: _layerLink,
//       child: OverlayPortal(
//         controller: _overlayController,
//         overlayChildBuilder: (context) {
//           return CompositedTransformFollower(
//             link: _layerLink,
//             targetAnchor: Alignment.bottomLeft,
//             followerAnchor: Alignment.topLeft,
//             offset: Offset(0, 5.h),
//             child: Align(
//               alignment: Alignment.topLeft,
//               child: Container(
//                 width: 180.w,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(12.r),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withValues(alpha: 0.1),
//                       blurRadius: 10,
//                       spreadRadius: 2,
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: ['All Properties', 'Apartments', 'Rooms'].map((
//                     option,
//                   ) {
//                     bool isSelected = selectedFilter == option;
//                     return InkWell(
//                       onTap: () async {
//                         setState(() => selectedFilter = option);
//                         _overlayController.toggle();
//                         final cubit = BlocProvider.of<MyPropertiesCubit>(
//                           context,
//                         );
//                         var filterOption = option == 'All Properties'
//                             ? 'all'
//                             : option.toLowerCase();
//                         await cubit.getMyProperties(filter: filterOption);
//                       },
//                       child: Container(
//                         width: double.infinity,
//                         padding: EdgeInsets.symmetric(
//                           horizontal: 16.w,
//                           vertical: 12.h,
//                         ),
//                         decoration: BoxDecoration(
//                           color: isSelected
//                               ? const Color(0xFFF1F4FF)
//                               : Colors.transparent,
//                           border: Border(
//                             left: BorderSide(
//                               color: isSelected
//                                   ? const Color(0xFF182E6E)
//                                   : Colors.transparent,
//                               width: 4,
//                             ),
//                           ),
//                         ),
//                         child: Text(
//                           option,
//                           style: TextStyle(
//                             color: isSelected
//                                 ? const Color(0xFF182E6E)
//                                 : Colors.black87,
//                             fontWeight: isSelected
//                                 ? FontWeight.bold
//                                 : FontWeight.normal,
//                           ),
//                         ),
//                       ),
//                     );
//                   }).toList(),
//                 ),
//               ),
//             ),
//           );
//         },
//         child: GestureDetector(
//           onTap: () {
//             _overlayController.toggle();
//             isOpen = !isOpen;
//             setState(() {});
//           },
//           child: Container(
//             padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
//             decoration: BoxDecoration(
//               color: AppColors.secondary,
//               borderRadius: BorderRadius.circular(12.r),
//               boxShadow: [
//                 BoxShadow(
//                   color: const Color(0x33000000), // shadowColor
//                   blurRadius: 10,
//                   offset: const Offset(0, 4),
//                 ),
//               ],
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   selectedFilter,
//                   style: AppStyles.semiBold14poppins.copyWith(
//                     color: AppColors.textColorPrimary,
//                   ),
//                 ),
//
//                 Icon(
//                   isOpen
//                       ? FontAwesome.caret_down_solid
//                       : FontAwesome.caret_right_solid,
//                   color: AppColors.textColorPrimary,
//                   size: 20.sp,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


class FloatingDropDown extends StatefulWidget {
  const FloatingDropDown({super.key});

  @override
  State<FloatingDropDown> createState() => _FloatingDropDownState();
}

class _FloatingDropDownState extends State<FloatingDropDown> {
  final _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;
  late MyPropertiesCubit cubit ;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
     cubit = BlocProvider.of<MyPropertiesCubit>(context);

}
  void _toggleDropdown() {
    if (_isOpen) {
      _closeMenu();
    } else {
      _openMenu();
    }
  }

  void _openMenu() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
    setState(() => _isOpen = true);
  }

  void _closeMenu() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() => _isOpen = false);
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;

    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          // This captures taps outside the menu to close it
          GestureDetector(
            onTap: _closeMenu,
            child: Container(color: Colors.transparent),
          ),
          CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            offset: Offset(0, size.height + 5.h),
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: 180.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: ['All Properties', 'Apartments', 'Rooms'].map((option) {
                    bool isSelected = cubit.selectedFilter == option;
                    return InkWell(
                      onTap: () async {
                        cubit.selectedFilter = option;
                        _closeMenu();
                        var filterOption = cubit.selectedFilter == 'All Properties'? 'all' : cubit.selectedFilter.toLowerCase();
                        await cubit.getMyProperties(filter:filterOption );
                        log(filterOption);
                        log('cubit ${cubit.selectedFilter}');
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFFF1F4FF) : Colors.transparent,
                          border: Border(
                            left: BorderSide(
                              color: isSelected ? const Color(0xFF182E6E) : Colors.transparent,
                              width: 4,
                            ),
                          ),
                        ),
                        child: Text(
                          option,
                          style: TextStyle(
                            color: isSelected ? const Color(0xFF182E6E) : Colors.black87,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
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
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: _toggleDropdown,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: AppColors.secondary,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: const [
              BoxShadow(
                color: Color(0x33000000),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                cubit.selectedFilter,
                style: AppStyles.semiBold14poppins.copyWith(
                  color: AppColors.textColorPrimary,
                ),
              ),
              Icon(
                _isOpen ? FontAwesome.caret_down_solid : FontAwesome.caret_right_solid,
                color: AppColors.textColorPrimary,
                size: 20.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}