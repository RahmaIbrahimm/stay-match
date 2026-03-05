import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_strings.dart';
import 'package:stay_match/core/constants/app_styles.dart';

class CustomDropDownMenu extends StatelessWidget {
  CustomDropDownMenu({
    super.key,
    required this.menuItems,
    required this.hintText,
    this.hasSearch = true,
    required this.selectedValue,
    this.searchController,
  });

  String selectedValue;
  final String hintText;
  final List<String> menuItems;
  final bool hasSearch;
  final TextEditingController? searchController;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: AppColors.boxShadow,
        borderRadius: BorderRadius.circular(15)
      ),
      child: DropdownButtonFormField2<String>(
        isExpanded: true,
        decoration: InputDecoration(
          // Add Horizontal padding using menuItemStyleData.padding so it matches
          // the menu padding when button's width is not specified.
          contentPadding: const EdgeInsetsGeometry.only(
            top: 16,
            bottom: 16,
            left: 16,
          ),
          //===========================
          // border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(width: 2, color: AppColors.primary),
          ),
          // Add more decoration..
          fillColor: AppColors.containerColor,
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(width: 2, color: AppColors.primary),
          ),

        ),
        hint: Text(hintText, style: TextStyle(fontSize: 14)),
        items: menuItems
            .map(
              (item) => DropdownMenuItem<String>(
                value: item,
                child: Text(item, style: const TextStyle(fontSize: 14)),
              ),
            )
            .toList(),
        dropdownSearchData: hasSearch
            ? DropdownSearchData(
                searchInnerWidget: TextFormField(
                  decoration: InputDecoration(
                    hintText: AppStrings.search,
                    hintStyle: AppStyles.caption.copyWith(
                      color: AppColors.textColorSecondary,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 6,
                    ),
                  ),
                ),
                searchInnerWidgetHeight: 8,
              )
            : null,
        validator: (value) {
          if (value == null) {
            return 'Please select Item.';
          }
          return null;
        },
        onChanged: (value) {
          //Do something when selected item is changed.
        },
        onSaved: (value) {
          selectedValue = value.toString();
        },
        buttonStyleData: ButtonStyleData(
          padding: const EdgeInsets.only(right: 8),
          width: double.infinity,
        ),
        iconStyleData: const IconStyleData(
          icon: Icon(FontAwesome.caret_down_solid, color: AppColors.primary),
          iconSize: 24,
          openMenuIcon: Icon(
            FontAwesome.caret_right_solid,
            color: AppColors.primary,
          ),
        ),
        dropdownStyleData: DropdownStyleData(
          scrollbarTheme: ScrollbarThemeData(
            thickness: WidgetStateProperty.all(4),
            radius: Radius.circular(6),
            thumbColor: WidgetStateProperty.all(AppColors.primary),
            interactive: true,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColors.containerColor,
          ),
          maxHeight: 150,
        ),
        menuItemStyleData: const MenuItemStyleData(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
      ),
    );
  }
}