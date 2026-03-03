import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppStyles {
  static final logo = GoogleFonts.protestRiot(
    fontSize: 15,
    fontWeight: FontWeight.normal,
  );
  static final headLine = GoogleFonts.poppins(
    fontSize: 28,
    fontWeight: FontWeight.bold,
  );
  static final sectionTitle = GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.w600,
  );
  static final cardTitle = GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w500,
  );
  static final bodyText = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );
  static final secondary = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );
  static final caption = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.normal,
  );
}