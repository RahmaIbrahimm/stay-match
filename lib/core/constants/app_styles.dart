import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppStyles {
  // Helper method to create responsive styles
  static TextStyle _poppins({
    required double fontSize,
    required FontWeight fontWeight,
    Color? color,
    double? height,
    FontStyle? fontStyle,
    TextDecoration? decoration,
    Color? decorationColor,
    double? letterSpacing,
  }) {
    return GoogleFonts.poppins(
      fontSize: fontSize.sp, // Make font size responsive
      fontWeight: fontWeight,
      color: color,
      height: height,
      fontStyle: fontStyle,
      decoration: decoration,
      decorationColor: decorationColor,
      letterSpacing:
          letterSpacing?.sp, // Make letter spacing responsive if provided
    );
  }

  // Helper method for Protest Riot font
  static TextStyle _protestRiot({
    required double fontSize,
    required FontWeight fontWeight,
    Color? color,
  }) {
    return GoogleFonts.protestRiot(
      fontSize: fontSize.sp, // Make font size responsive
      fontWeight: fontWeight,
      color: color,
    );
  }

  // Helper method for Manrope font
  static TextStyle _manrope({
    required double fontSize,
    required FontWeight fontWeight,
    Color? color,
  }) {
    return GoogleFonts.manrope(
      fontSize: fontSize.sp, // Make font size responsive
      fontWeight: fontWeight,
      color: color,
    );
  }
  // Helper method for plus jakarta sans font
  static TextStyle _plusJakartaSans({
    required double fontSize,
    required FontWeight fontWeight,
    Color? color,
  }) {
    return GoogleFonts.plusJakartaSans(
      fontSize: fontSize.sp, // Make font size responsive
      fontWeight: fontWeight,
      color: color,
    );
  }

  // ---------------- PROTEST RIOT ----------------
  static TextStyle get regular15protestRiot =>
      _protestRiot(fontSize: 15, fontWeight: FontWeight.normal);

  static TextStyle get regular20protestRiot =>
      _protestRiot(fontSize: 20, fontWeight: FontWeight.normal);
  // ---------------- Manrope ----------------
  static TextStyle get bold14manrope =>
      _manrope(fontSize: 16, fontWeight: FontWeight.bold);
  static TextStyle get semiBold16manrope =>
      _manrope(fontSize: 16, fontWeight: FontWeight.w600);
  static TextStyle get bold12manrope =>
      _manrope(fontSize: 12, fontWeight: FontWeight.bold);
  // ---------------- Plus Jakarta Sans ----------------
  static TextStyle get bold24plusJakartaSans =>
      _plusJakartaSans(fontSize: 24, fontWeight: FontWeight.bold);
  static TextStyle get semiBold24plusJakartaSans =>
      _plusJakartaSans(fontSize: 24, fontWeight: FontWeight.w600);

  // ---------------- POPPINS - 28 ----------------
  static TextStyle get bold28poppins =>
      _poppins(fontSize: 28, fontWeight: FontWeight.bold);

  static TextStyle get semiBold28poppins =>
      _poppins(fontSize: 28, fontWeight: FontWeight.w600);

  static TextStyle get medium28poppins =>
      _poppins(fontSize: 28, fontWeight: FontWeight.w500);

  static TextStyle get regular28poppins =>
      _poppins(fontSize: 28, fontWeight: FontWeight.normal);

  // ---------------- POPPINS - 24 ----------------
  static TextStyle get bold24poppins =>
      _poppins(fontSize: 24, fontWeight: FontWeight.bold);

  static TextStyle get semibold24poppins =>
      _poppins(fontSize: 24, fontWeight: FontWeight.w600);

  static TextStyle get medium24poppins =>
      _poppins(fontSize: 24, fontWeight: FontWeight.w500);

  static TextStyle get regular24poppins =>
      _poppins(fontSize: 24, fontWeight: FontWeight.normal);

  // ---------------- POPPINS - 20 ----------------
  static TextStyle get bold20poppins =>
      _poppins(fontSize: 20, fontWeight: FontWeight.bold);

  static TextStyle get semiBold20poppins =>
      _poppins(fontSize: 20, fontWeight: FontWeight.w600);

  static TextStyle get medium20poppins =>
      _poppins(fontSize: 20, fontWeight: FontWeight.w500);

  static TextStyle get regular20poppins =>
      _poppins(fontSize: 20, fontWeight: FontWeight.normal);

  // ---------------- POPPINS - 18 ----------------
  static TextStyle get bold18poppins =>
      _poppins(fontSize: 18, fontWeight: FontWeight.bold);

  static TextStyle get semiBold18poppins =>
      _poppins(fontSize: 18, fontWeight: FontWeight.w600);

  static TextStyle get medium18poppins =>
      _poppins(fontSize: 18, fontWeight: FontWeight.w500);

  static TextStyle get regular18poppins =>
      _poppins(fontSize: 18, fontWeight: FontWeight.normal);

  // ---------------- POPPINS - 16 ----------------
  static TextStyle get bold16poppins =>
      _poppins(fontSize: 16, fontWeight: FontWeight.bold);

  static TextStyle get semiBold16poppins =>
      _poppins(fontSize: 16, fontWeight: FontWeight.w600);

  static TextStyle get medium16poppins =>
      _poppins(fontSize: 16, fontWeight: FontWeight.w500);

  static TextStyle get regular16poppins =>
      _poppins(fontSize: 16, fontWeight: FontWeight.normal);

  // ---------------- POPPINS - 15 ----------------
  static TextStyle get bold15poppins =>
      _poppins(fontSize: 15, fontWeight: FontWeight.bold);

  static TextStyle get semiBold15poppins =>
      _poppins(fontSize: 15, fontWeight: FontWeight.w600);

  static TextStyle get medium15poppins =>
      _poppins(fontSize: 15, fontWeight: FontWeight.w500);

  static TextStyle get regular15poppins =>
      _poppins(fontSize: 15, fontWeight: FontWeight.normal);

  // ---------------- POPPINS - 14 ----------------
  static TextStyle get bold14poppins =>
      _poppins(fontSize: 14, fontWeight: FontWeight.bold);

  static TextStyle get semiBold14poppins =>
      _poppins(fontSize: 14, fontWeight: FontWeight.w600);

  static TextStyle get medium14poppins =>
      _poppins(fontSize: 14, fontWeight: FontWeight.w500);

  static TextStyle get regular14poppins =>
      _poppins(fontSize: 14, fontWeight: FontWeight.normal);

  // ---------------- POPPINS - 12 ----------------
  static TextStyle get bold12poppins =>
      _poppins(fontSize: 12, fontWeight: FontWeight.bold);

  static TextStyle get semiBold12poppins =>
      _poppins(fontSize: 12, fontWeight: FontWeight.w600);

  static TextStyle get medium12poppins =>
      _poppins(fontSize: 12, fontWeight: FontWeight.w500);

  static TextStyle get regular12poppins =>
      _poppins(fontSize: 12, fontWeight: FontWeight.normal);

  // ---------------- POPPINS - 10 ----------------
  static TextStyle get bold10poppins =>
      _poppins(fontSize: 10, fontWeight: FontWeight.bold);

  static TextStyle get semiBold10poppins =>
      _poppins(fontSize: 10, fontWeight: FontWeight.w600);

  static TextStyle get medium10poppins =>
      _poppins(fontSize: 10, fontWeight: FontWeight.w500);

  static TextStyle get regular10poppins =>
      _poppins(fontSize: 10, fontWeight: FontWeight.normal);

  // ---------------- POPPINS - 8 ----------------
  static TextStyle get bold8poppins =>
      _poppins(fontSize: 8, fontWeight: FontWeight.bold);

  static TextStyle get semiBold8poppins =>
      _poppins(fontSize: 8, fontWeight: FontWeight.w600);

  static TextStyle get medium8poppins =>
      _poppins(fontSize: 8, fontWeight: FontWeight.w500);

  static TextStyle get regular8poppins =>
      _poppins(fontSize: 8, fontWeight: FontWeight.normal);

  // ---------------- POPPINS - 14 ----------------
  static TextStyle get semiBold14manrope =>
      _manrope(fontSize: 14, fontWeight: FontWeight.w600);
  static TextStyle get medium14manrope =>
      _manrope(fontSize: 14, fontWeight: FontWeight.w500);

  static TextStyle get regular14manrope =>
      _manrope(fontSize: 14, fontWeight: FontWeight.normal);

  // ---------------- POPPINS - 12 ----------------
  static TextStyle get regular12manrope =>
      _manrope(fontSize: 12, fontWeight: FontWeight.normal);

  // ---------------- POPPINS - 10 ----------------
  static TextStyle get bold10manrope =>
      _manrope(fontSize: 10, fontWeight: FontWeight.bold);

  // customize styles
  static TextStyle customPoppins({
    required double fontSize,
    required FontWeight fontWeight,
    Color? color,
    double? height,
    FontStyle? fontStyle,
    TextDecoration? decoration,
    Color? decorationColor,
    double? letterSpacing,
  }) {
    return _poppins(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: height,
      fontStyle: fontStyle,
      decoration: decoration,
      decorationColor: decorationColor,
      letterSpacing: letterSpacing,
    );
  }

  static TextStyle customProtestRiot({
    required double fontSize,
    required FontWeight fontWeight,
    Color? color,
  }) {
    return _protestRiot(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }
}