import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_strings.dart';
import 'package:stay_match/core/constants/app_styles.dart';

class CustomDropDownMenu extends StatefulWidget {
  const CustomDropDownMenu({
    super.key,
    required this.menuItems,
    required this.hintText,
    this.hasSearch = true,
    this.selectedValue,
    this.searchController,
  });

  final TextEditingController? selectedValue;
  final String hintText;
  final List<String> menuItems;
  final bool hasSearch;
  final TextEditingController? searchController;
  @override
  State<CustomDropDownMenu> createState() => _CustomDropDownMenuState();
}

class _CustomDropDownMenuState extends State<CustomDropDownMenu> {
  bool isMenuOpen = false;
  late List<String> filteredItems;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredItems = widget.menuItems;
    _searchController.addListener(_filterItems);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterItems);
    _searchController.dispose();
    super.dispose();
  }

  void _filterItems() {
    final query = _searchController.text.toLowerCase().trim();
    setState(() {
      if (query.isEmpty) {
        filteredItems = widget.menuItems;
      } else {
        filteredItems = widget.menuItems
            .where((item) => item.toLowerCase().contains(query))
            .toList();
      }
    });
  }

  void _resetFilter() {
    _searchController.clear();
    setState(() {
      filteredItems = widget.menuItems;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      padding: EdgeInsets.zero,
      duration: const Duration(milliseconds: 150),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: AppColors.boxShadow,
      ),
      child: DropdownButtonFormField2<String>(
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
          contentPadding: const EdgeInsets.only(
            top: 16,
            bottom: 16,
            left: 12,

          ),
          //==================borders===========================
          border: buildOutlineInputBorder(),
          errorBorder: buildOutlineInputBorder(isError: true),
          enabledBorder: buildOutlineInputBorder(),
          focusedBorder: buildOutlineInputBorder(),
          fillColor: AppColors.containerColor,
          filled: true,
        ),
        hint: Text(widget.hintText, style:AppStyles.regular12poppins.copyWith(color: AppColors.textColorSecondary)),
        value: widget.selectedValue?.text.isNotEmpty == true
            ? widget.selectedValue?.text
            : null,
        items: filteredItems
            .map(
              (item) => DropdownMenuItem<String>(
            value: item,
            child: Text(item, style: const TextStyle(fontSize: 14)),
          ),
        )
            .toList(),
        dropdownSearchData: widget.hasSearch
            ? DropdownSearchData(
          searchController: _searchController,
          searchInnerWidgetHeight: 60,
          searchInnerWidget: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _searchController,
              decoration: InputDecoration(
                isDense: true,
                hintText: AppStrings.search,
                hintStyle: AppStyles.regular12poppins.copyWith(
                  color: AppColors.textColorSecondary,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: AppColors.primary),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: AppColors.primary.withAlpha(50)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: AppColors.primary, width: 2),
                ),
                prefixIcon: const Icon(Icons.search, size: 20),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                  icon: const Icon(Icons.clear, size: 18),
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
          if (value == null || value.isEmpty) {
            return 'Required';
          }
          return null;
        },
        onChanged: (value) {
          if (value != null) {
            widget.selectedValue?.text = value;
          }
        },
        onSaved: (value) {
          if (value != null) {
            widget.selectedValue?.text = value;
          }
        },
        buttonStyleData: const ButtonStyleData(
          padding: EdgeInsets.only(right: 8),
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
            thickness: WidgetStateProperty.all(3),
            radius: const Radius.circular(6),
            thumbColor: WidgetStateProperty.all(AppColors.primary),
            interactive: true,
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: AppColors.containerColor,
              boxShadow: AppColors.boxShadow
          ),
          maxHeight: 210,
        ),
        menuItemStyleData: const MenuItemStyleData(
          padding: EdgeInsets.symmetric(horizontal: 16),
        ),
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder({bool isError = false}) {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(
          width: 2,
          color: isError ? Colors.red : AppColors.primary,
        ),
        gapPadding: 0
    );
  }
}