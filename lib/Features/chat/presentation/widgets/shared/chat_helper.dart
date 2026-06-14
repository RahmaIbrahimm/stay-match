import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../data/models/start_chat_response.dart';

class ChatHelper {
  static Color _getAvatarColor(String name) {
    final List<Color> colors = [
      const Color(0xFF1B4F72), // Deep Ocean Blue (متناسق مع الـ Primary)
      const Color(0xFF1E8449), // Rich Green (أغمق من الـ Secondary للوضوح)
      const Color(0xFF943126), // Dark Terra Cotta (تباين رهيب مع الأبيض)
      const Color(0xFF7D3C98), // Deep Amethyst
      const Color(0xFF2471A3), // Strong Azure
      const Color(0xFF148F77), // Dark Turquoise
    ];

    int hash = name.hashCode;
    int index = hash.abs() % colors.length;
    return colors[index];
  }
  static Widget buildPlaceholder(String name, {int? fontSize}) {
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
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: (fontSize ?? 18).sp,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
  static DateTime parseServerDate(String date) {
    return DateTime.parse('${date}Z').toLocal();
  }
  static String formatChatTime(String? timeString) {
    if (timeString == null || timeString.isEmpty) return "";

    try {
      // DateTime messageDate = DateTime.parse(timeString).toLocal();
      DateTime messageDate = parseServerDate(timeString);
      DateTime now = DateTime.now();

      DateTime today = DateTime(now.year, now.month, now.day);
      DateTime dateToCompare = DateTime(messageDate.year, messageDate.month, messageDate.day);

      final int differenceInDays = today.difference(dateToCompare).inDays;

      // ا 10:30 AM
      if (differenceInDays == 0) {
        return DateFormat('h:mm a').format(messageDate);
      }

      // ا (Yesterday)
      if (differenceInDays == 1) {
        return "Yesterday";
      }

      // ا(Monday)
      if (differenceInDays < 7) {
        return DateFormat('EEEE').format(messageDate); // EEEE
      }

      return DateFormat('d/M/yyyy').format(messageDate);

    } catch (e) {
      return "";
    }
  }

  static String getGroupDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final aWeekAgo = today.subtract(const Duration(days: 7));

    final msgDate = DateTime(date.year, date.month, date.day);

    if (msgDate == today) {
      return "TODAY";
    } else if (msgDate == yesterday) {
      return "YESTERDAY";
    } else if (msgDate.isAfter(aWeekAgo)) {
      // Returns Monday, Tuesday, etc.
      return DateFormat('EEEE').format(date).toUpperCase();
    } else {
      // Returns 25 APR 2026
      return DateFormat('dd MMM yyyy').format(date).toUpperCase();
    }
  }
  static Map<String, List<Messages>> groupMessagesByDate(
      List<Messages> messages) {
    Map<String, List<Messages>> groups = {};

    for (var message in messages) {
      final localDate = parseServerDate(message.sentAt!);

      final dateKey = getGroupDate(localDate);

      groups.putIfAbsent(dateKey, () => []);
      groups[dateKey]!.add(message);
    }

    return groups;
  }
}