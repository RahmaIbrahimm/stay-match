import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_styles.dart';

import '../manager/chatbot_cubit.dart';

class ChatbotDrawer extends StatelessWidget {
  const ChatbotDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.primary,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ───────────────────────────────────────────────────
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'StayMatch',
                    style: AppStyles.bold20poppins.copyWith(
                      color: AppColors.textColorWhite,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'AI ASSISTANT',
                    style: AppStyles.semiBold10poppins.copyWith(
                      color: AppColors.textColorWhite.withOpacity(0.6),
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // Online badge — static for now
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 8.r,
                          height: 8.r,
                          decoration: const BoxDecoration(
                            color: Color(0xFF4CD964),
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'Online',
                          style: AppStyles.semiBold12poppins.copyWith(
                            color: AppColors.textColorWhite,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 28.h),
                  Text(
                    'QUICK ACTIONS',
                    style: AppStyles.semiBold12poppins.copyWith(
                      color: AppColors.textColorWhite.withOpacity(0.4),
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(height: 12.h),
                ],
              ),
            ),

            // ── Quick actions ────────────────────────────────────────────
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Column(
                children: [
                  _QuickActionTile(
                    icon: Icons.apartment_rounded,
                    label: 'Find Full Apartment',
                    highlighted: true,
                    onTap: () => _sendAndClose(
                      context,
                      'I want to find a full apartment to rent',
                    ),
                  ),
                  _QuickActionTile(
                    icon: Icons.bed_outlined,
                    label: 'Find Room',
                    onTap: () => _sendAndClose(
                      context,
                      'I want to find a room to rent',
                    ),
                  ),
                  _QuickActionTile(
                    icon: Icons.menu_book_outlined,
                    label: 'Booking Guide',
                    onTap: () => _sendAndClose(
                      context,
                      'How do I submit a booking request?',
                    ),
                  ),
                  _QuickActionTile(
                    icon: Icons.support_agent_outlined,
                    label: 'How to add Property',
                    onTap: () => _sendAndClose(
                      context,
                      'How do I add a property?',
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            // ── Footer ───────────────────────────────────────────────────
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 16.h),
              child: Column(
                children: [
                  Divider(color: Colors.white.withOpacity(0.1)),
                  SizedBox(height: 12.h),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () => _confirmClearChat(context),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white.withOpacity(0.06),
                        side: BorderSide(color: Colors.white.withOpacity(0.1)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                      ),
                      icon: Icon(Icons.delete_outline, size: 18.r, color: const Color(0xFFE57373)),
                      label: Text(
                        'Clear Chat',
                        style: AppStyles.semiBold14poppins.copyWith(
                          color: const Color(0xFFE57373),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 14.h),

                  // Decorative page-indicator dots
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(4, (i) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 3.w),
                        width: 6.r,
                        height: 6.r,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity( 0.6 ),
                          shape: BoxShape.circle,
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _sendAndClose(BuildContext context, String message) {
    context.read<ChatbotCubit>().sendMessage(message);
    Navigator.of(context).pop();
  }

  Future<void> _confirmClearChat(BuildContext context) async {
    final cubit = context.read<ChatbotCubit>();

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.containerColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: Text(
          'Clear chat?',
          style: AppStyles.semiBold16poppins.copyWith(color: AppColors.textColorPrimary),
        ),
        content: Text(
          'This will clear the current conversation and start a new session.',
          style: AppStyles.regular14poppins.copyWith(color: AppColors.textColorSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(
              'Cancel',
              style: AppStyles.semiBold14poppins.copyWith(color: AppColors.textColorSecondary),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(
              'Clear',
              style: AppStyles.semiBold14poppins.copyWith(color: Colors.red),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      cubit.clearChat();
      if (context.mounted) Navigator.of(context).pop();
    }
  }
}

// ── Quick action tile ───────────────────────────────────────────────────────────

class _QuickActionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool highlighted;

  const _QuickActionTile({
    required this.icon,
    required this.label,
    required this.onTap,
    this.highlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
          decoration: BoxDecoration(
            color: highlighted ? AppColors.secondary : Colors.transparent,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: 20.r,
                color: highlighted ? AppColors.primary : AppColors.textColorWhite.withOpacity(0.8),
              ),
              SizedBox(width: 14.w),
              Text(
                label,
                style: AppStyles.semiBold14poppins.copyWith(
                  color: highlighted ? AppColors.primary : AppColors.textColorWhite,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}