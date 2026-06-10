import 'package:flutter/material.dart';

abstract class AppColors {
  static const primary = Color(0xff182E6E);
  static const secondary = Color(0xff86C9A9);
  static const secondaryLight = Color(0xff2F68C5);
  static const accentColor = Color(0xff4D84C8);
  static const backgroundColor = Colors.black;
  static const containerColor = Colors.white;
  static const textColorWhite = Color(0xffffffff);
  static const textColorPrimary = Color(0xff19212C);
  static const textColorSecondary = Color(0xff565B66);
  static const textColorError = Color(0xffBF3636);
  static const textColorSuccess = Color(0xff0D9467);
  static const shadowColor = Color(0x33000000);
  static const blue = Color(0xffA4D5EA);
  static const grey = Color.fromARGB(200, 243, 244, 246);
  static const pink = Color.fromRGBO(255, 186, 225, 0.7);
  static const bgGrey = Color(0xffEEEEEF);
  static const darkerGrey = Color(0xffF6F7F8);
  static const blueGrey = Color.fromRGBO(30, 58, 138, 0.1);
  static const stroke = Color(0xffE5E7EB);
  static const fieldFillColor = Color(0xFFF7F9FC);
  static const secondaryScaffBg = Color(0xFFF4F3FA);

  static const boxShadow = [
    BoxShadow(
      color: AppColors.shadowColor,
      offset: Offset(5, 5),
      blurRadius: 5,
      spreadRadius: 2,
    ),
  ];
  static const elevationShadow = [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.15),
      blurRadius: 3,
      offset: Offset(0, 1),
    ),
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.3),
      blurRadius: 2,
      offset: Offset(0, 1),
    ),
  ];
}