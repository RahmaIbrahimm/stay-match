import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_strings.dart';
import 'package:stay_match/core/constants/app_styles.dart';

class CustomDropDownMenu<T> extends StatefulWidget {
  const CustomDropDownMenu({
    super.key,
    required this.menuItems,
    required this.hintText,
    this.hasSearch = true,
    this.selectedValue,
    this.displayString,
    this.onChanged,
    this.selectedItem,
    this.searchController,
    this.strokeColor,
    this.hasShadow,
    this.fillColor, this.hintStyle, this.iconColor,
  });

  final TextEditingController? selectedValue;
  final String hintText;
  final List<T> menuItems;
  final bool hasSearch;
  final TextEditingController? searchController;
  final String Function(T)? displayString;
  final void Function(T?)? onChanged;
  final T? selectedItem;
  final Color? strokeColor;
  final Color? iconColor;
  final Color? fillColor;
  final bool? hasShadow;
  final TextStyle? hintStyle;
  @override
  State<CustomDropDownMenu<T>> createState() => _CustomDropDownMenuState<T>();
}

class _CustomDropDownMenuState<T> extends State<CustomDropDownMenu<T>> {
  bool isMenuOpen = false;
  late List<T> filteredItems;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredItems = widget.menuItems;
    _searchController.addListener(_filterItems);
  }

  @override
  void didUpdateWidget(covariant CustomDropDownMenu<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update filteredItems when menuItems changes
    if (oldWidget.menuItems != widget.menuItems) {
      filteredItems = widget.menuItems;
      _filterItems(); // Re-apply search filter
    }
  }

  void _filterItems() {
    final query = _searchController.text.toLowerCase().trim();
    setState(() {
      if (query.isEmpty) {
        filteredItems = widget.menuItems;
      } else {
        filteredItems = widget.menuItems.where((item) {
          final displayText = _getDisplayString(item).toLowerCase();
          return displayText.contains(query);
        }).toList();
      }
    });
  }

  String _getDisplayString(T item) {
    if (widget.displayString != null) {
      return widget.displayString!(item);
    }
    return item.toString();
  }

  void _resetFilter() {
    _searchController.clear();
    setState(() {
      filteredItems = widget.menuItems;
    });
  }

  @override
  Widget build(BuildContext context) {
    // T? currentValue;
    //
    // if (widget.selectedItem != null) {
    //   // Find the matching object in filteredItems by comparing display strings
    //   final selectedDisplayString = _getDisplayString(widget.selectedItem as T);
    //   currentValue = filteredItems.cast<T>().firstWhere(
    //         (item) => _getDisplayString(item) == selectedDisplayString,
    //     orElse: () => null as T,
    //   );
    // } else if (widget.selectedValue != null &&
    //     widget.selectedValue!.text.isNotEmpty) {
    //   // For string backward compatibility
    //   final selectedText = widget.selectedValue?.text;
    //   currentValue = filteredItems.cast<T>().firstWhere(
    //         (item) => _getDisplayString(item) == selectedText,
    //     orElse: () => null as T,
    //   );
    // }
    T? currentValue;

    if (widget.selectedItem != null) {
      final selectedDisplayString = _getDisplayString(widget.selectedItem as T);
      currentValue = filteredItems.cast<T?>().firstWhere(
            (item) => _getDisplayString(item as T) == selectedDisplayString,
        orElse: () => null,
      ) as T?;
    } else if (widget.selectedValue != null &&
        widget.selectedValue!.text.isNotEmpty) {
      final selectedText = widget.selectedValue?.text;
      currentValue = filteredItems.cast<T?>().firstWhere(
            (item) => _getDisplayString(item as T) == selectedText,
        orElse: () => null,
      ) as T?;
    }
    return AnimatedContainer(
      padding: EdgeInsets.zero,
      duration: const Duration(milliseconds: 150),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: (widget.hasShadow ?? true) ? AppColors.boxShadow : null,
      ),
      child: DropdownButtonFormField2<T>(
        isExpanded: true,
        onMenuStateChange: (isOpen) {
          setState(() {
            isMenuOpen = isOpen;
            if (!isOpen) {
              _resetFilter();
            }
          });
        },
        decoration: InputDecoration(
          contentPadding:  EdgeInsets.only(top: 16.r, bottom: 16.r, left: 12.r),
          border: buildOutlineInputBorder(),
          errorBorder: buildOutlineInputBorder(isError: true),
          enabledBorder: buildOutlineInputBorder(),
          focusedBorder: buildOutlineInputBorder(),
          fillColor: widget.fillColor ?? AppColors.containerColor,
          filled: true,
        ),
        hint: Text(
          widget.hintText,
          style: (widget.hintStyle ?? AppStyles.regular12poppins).copyWith(
            color: AppColors.textColorSecondary,
          ),
        ),
        value: currentValue, // Use the found instance!
        items: filteredItems.map((item) {
          return DropdownMenuItem<T>(
            value: item, // This is the actual instance from filteredItems
            child: Text(
              _getDisplayString(item),
              style: TextStyle(fontSize: 14.sp),
            ),
          );
        }).toList(),
        dropdownSearchData: widget.hasSearch
            ? DropdownSearchData(
          searchController: _searchController,
          searchInnerWidgetHeight: 60.h,
          searchInnerWidget: RPadding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _searchController,
              decoration: InputDecoration(
                isDense: true,
                hintText: AppStrings.search,
                hintStyle: AppStyles.regular12poppins.copyWith(
                  color: AppColors.textColorSecondary,
                ),
                      contentPadding:  EdgeInsets.symmetric(vertical: 10.r),
                      border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: widget.strokeColor ?? AppColors.primary,
                        )),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(
                          color:
                              widget.strokeColor ??
                              AppColors.primary.withAlpha(50),
                        )),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: widget.strokeColor ?? AppColors.primary,
                    width: 2,
                  ),
                ),
                prefixIcon:  Icon(Icons.search, size: 20.sp),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                  icon:  Icon(Icons.clear, size: 18.sp),
                  onPressed: _resetFilter,
                )
                    : null,
              ),
            ),
          ),
        )
            : null,
        validator: (value) {
          if (isMenuOpen) return null;
          if (value == null) {
            return 'Required';
          }
          return null;
        },
        onChanged: (value) {
          if (value != null) {
            if (widget.selectedValue != null) {
              widget.selectedValue!.text = _getDisplayString(value);
            }
            widget.onChanged?.call(value);
          }
        },
        buttonStyleData: ButtonStyleData(
          padding: EdgeInsets.only(right: 8.w),
        ),
        iconStyleData: IconStyleData(
          icon: Icon(FontAwesome.caret_down_solid, color: widget.iconColor?? AppColors.primary),
          iconSize: 24.sp,
          openMenuIcon:  Icon(
            FontAwesome.caret_right_solid,
            color: widget.iconColor??AppColors.primary,
          ),
        ),
        dropdownStyleData: DropdownStyleData(
          scrollbarTheme: ScrollbarThemeData(
            thickness: WidgetStateProperty.all(3),
            radius: Radius.circular(6.r),
            thumbColor: WidgetStateProperty.all(AppColors.primary),
            interactive: true,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            color: AppColors.containerColor,
            boxShadow: AppColors.boxShadow,
          ),
          maxHeight: 210.h,
        ),
        menuItemStyleData:  MenuItemStyleData(
          padding: EdgeInsets.symmetric(horizontal: 16.r),
        ),
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder({bool isError = false}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.r),
      borderSide: BorderSide(
        width: 2,
        color: isError ? Colors.red : widget.strokeColor ?? AppColors.primary,
      ),
      gapPadding: 0,
    );
  }
}