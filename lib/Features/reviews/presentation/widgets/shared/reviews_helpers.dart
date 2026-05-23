import 'dart:ui';

abstract class RColors {
  static const pageBg = Color(0xFFF7F8FC);
  static const hostRespBg = Color(0xFFEFF6FF);
  static const hostRespBorder = Color(0xFF6366F1);
  static const hostRespLabel = Color(0xFFF59E0B);
  static const primary = Color(0xFF182E6E);
  static const textPrimary = Color(0xFF111827);
  static const textSecondary = Color(0xFF6B7280);
  static const textHint = Color(0xFF9CA3AF);
  static const divider = Color(0xFFE5E7EB);
  static const barFill = Color(0xFF182E6E);
  static const barBg = Color(0xFFE5E7EB);
}
class Cat {
  final String label;
  final double value;

  const Cat(this.label, this.value);
}

class Dist {
  final int star;
  final int count;

  const Dist(this.star, this.count);
}
enum ReviewSortOption {
  all(apiValue: 'All', label: 'All Reviews'),
  highest(apiValue: 'Highest', label: 'Highest Rated'),
  lowest(apiValue: 'Lowest', label: 'Lowest Rated');

  const ReviewSortOption({required this.apiValue, required this.label});

  final String apiValue;
  final String label;
}