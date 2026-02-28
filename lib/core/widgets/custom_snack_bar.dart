import 'package:flutter/material.dart';

class CustomSnackBar extends StatelessWidget {
  CustomSnackBar({
    super.key,
    this.backgroundColor,
    required this.content,
    required this.context,
  });

  final Widget content;
  final Color? backgroundColor;
  BuildContext context;

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      child: SnackBar(content: content, backgroundColor: backgroundColor ??  Colors.red[800]),
    );
  }
}