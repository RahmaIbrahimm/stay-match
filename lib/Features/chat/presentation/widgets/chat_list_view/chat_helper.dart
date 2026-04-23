import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ChatHelper {
  static Color _getAvatarColor(String name) {
    // قائمة ألوان "شيك" ومناسبة للخلفيات
    final List<Color> colors = [
      Color(0xFF1abc9c), // Turquoise
      Color(0xFF2ecc71), // Emerald
      Color(0xFF3498db), // Peter River
      Color(0xFF9b59b6), // Amethyst
      Color(0xFFe67e22), // Carrot
      Color(0xFFe74c3c), // Alizarin
      Color(0xFF16a085), // Green Sea
      Color(0xFF2980b9), // Belize Hole
    ];

    // بنحول الاسم لرقم (HashCode) وعن طريقه بنختار اللون من القائمة
    int hash = name.hashCode;
    int index = hash.abs() % colors.length;
    return colors[index];
  }
  static Widget buildPlaceholder(String name) {
    List<String> nameParts = name.trim().split(' ');
    String initials = "";

    if (nameParts.length >= 2) {
      initials = nameParts[0][0] + nameParts[1][0];
    } else if (nameParts.isNotEmpty && nameParts[0].isNotEmpty) {
      initials = nameParts[0][0];
    }

    return Container(
      width: 50.r,
      height: 50.r,
      // هنا استدعينا دالة اللون العشوائي المبني على الاسم
      color: _getAvatarColor(name),
      alignment: Alignment.center,
      child: Text(
        initials.toUpperCase(),
        style: TextStyle(
          color: Colors.white, // الحروف بيضاء عشان تبان
          fontWeight: FontWeight.bold,
          fontSize: 18.sp, // كبرنا الخط شوية عشان يبقى أوضح
          letterSpacing: 1.2, // مسافة بسيطة بين الحرفين بتخلي الشكل أشيك
        ),
      ),
    );
  }
  static String formatChatTime(String? timeString) {
    if (timeString == null || timeString.isEmpty) return "";

    try {
      // 1. تحويل النص لـ DateTime object
      DateTime dateTime = DateTime.parse(
        timeString,
      ).toLocal(); // .toLocal() عشان يظبط التوقيت حسب مصر

      // 2. تحديد الشكل (Format) اللي إنت عاوزه
      // 'jm' بتطلع الوقت بنظام (1:01 AM)
      // لو عاوزها 24 ساعة (13:01) استخدم 'HH:mm'
      return DateFormat('h:mm a').format(dateTime);
    } catch (e) {
      return ""; // لو حصل خطأ في الـ String يرجع نص فاضي
    }
  }
}