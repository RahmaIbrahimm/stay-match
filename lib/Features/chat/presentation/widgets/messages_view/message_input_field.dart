import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class MessageInputField extends StatefulWidget {
  final Function(String) onSendMessage;

  const MessageInputField({super.key, required this.onSendMessage});

  @override
  State<MessageInputField> createState() => _MessageInputFieldState();
}

class _MessageInputFieldState extends State<MessageInputField> {
  final TextEditingController _controller = TextEditingController();
  bool _hasText = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey[200]!)),
      ),
      child: Row(
        children: [
          Icon(Icons.add_circle_outline, color: const Color(0xFF1E2E5D), size: 28.r),
          SizedBox(width: 8.w),

          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(25.r),
              ),
              child: TextField(
                controller: _controller,
                onChanged: (val) => setState(() => _hasText = val.trim().isNotEmpty),
                decoration: const InputDecoration(
                  hintText: "Type a message...",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),

          SizedBox(width: 10.w),

          // زرار الإرسال
          GestureDetector(
            onTap: () {
              if (_hasText) {
                widget.onSendMessage(_controller.text.trim());
                _controller.clear();
                setState(() => _hasText = false);
              }
            },
            child: CircleAvatar(
              radius: 22.r,
              backgroundColor: const Color(0xFF1E2E5D),
              child: Icon(
                _hasText ? Icons.send : Icons.mic,
                color: Colors.white,
                size: 20.r,
              ),
            ),
          ),
        ],
      ),
    );
  }
}