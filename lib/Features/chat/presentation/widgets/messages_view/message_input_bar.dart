import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/Features/chat/presentation/manager/message_cubit.dart';
import 'package:stay_match/core/widgets/custom_text_form_field.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_strings.dart';

class MessageInputBar extends StatefulWidget {
  final int chatId;
  const MessageInputBar({super.key, required this.chatId});

  @override
  State<MessageInputBar> createState() => _MessageInputBarState();
}

class _MessageInputBarState extends State<MessageInputBar> with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final ValueNotifier<bool> _isTextEmpty = ValueNotifier<bool>(true);
  final ValueNotifier<bool> _isRecording = ValueNotifier<bool>(false);
  final ValueNotifier<double> _dragOffset = ValueNotifier<double>(0.0);

  late AnimationController _pulseController;
  DateTime? _recordingStartTime;
  static const double _cancelThreshold = -100.0;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _showShortRecordingWarning() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Hold to record"),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(milliseconds: 800),
        width: 150.w,
        backgroundColor: Colors.black87,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.fieldFillColor)),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildFilePreview(context),
            Row(
              children: [
                _buildLeftIcon(),
                SizedBox(width: 12.w),
                Expanded(
                  child: ValueListenableBuilder<bool>(
                    valueListenable: _isRecording,
                    builder: (context, recording, _) {
                      return recording ? _buildRecordingStatus() : _buildTextField();
                    },
                  ),
                ),
                SizedBox(width: 12.w),
                _buildActionButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLeftIcon() {
    return ValueListenableBuilder<bool>(
      valueListenable: _isRecording,
      builder: (context, recording, _) {
        if (recording) {
          return FadeTransition(
            opacity: _pulseController,
            child: const Icon(Icons.fiber_manual_record, color: Colors.red, size: 22),
          );
        }
        return GestureDetector(
          onTap: () => _showAttachmentMenu(context),
          child: const Icon(Icons.add_circle_outline, color: AppColors.primary, size: 28),
        );
      },
    );
  }

  Widget _buildTextField() {
    return CustomTextFormField(
      controller: _controller,
      onChanged: (val) => _isTextEmpty.value = val.trim().isEmpty,
      focusColor: AppColors.stroke,
      hasShadow: false,
      borderRadius: 999,
      stroke: false,
      fillColor: AppColors.fieldFillColor,
      verticalPadding: 6,
      hintText: AppStrings.typeMessage,
      validator: (val) => null,
    );
  }

  Widget _buildRecordingStatus() {
    return ValueListenableBuilder<double>(
      valueListenable: _dragOffset,
      builder: (context, offset, _) {
        double opacity = (1.0 + (offset / 100)).clamp(0.2, 1.0);
        return Row(
          children: [
            Text("Recording...",
                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 14.sp)),
            const Spacer(),
            Opacity(
              opacity: opacity,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.arrow_back_ios, size: 10, color: Colors.grey),
                  Text("Slide to cancel", style: TextStyle(color: Colors.grey, fontSize: 12.sp)),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildActionButton() {
    return ValueListenableBuilder<bool>(
      valueListenable: _isTextEmpty,
      builder: (context, isEmpty, _) {
        return GestureDetector(
          onLongPressStart: (_) async {
            if (isEmpty) {
              _isRecording.value = true;
              _dragOffset.value = 0.0;
              _recordingStartTime = DateTime.now();
              await context.read<MessageCubit>().startRecording();
            }
          },
          onLongPressMoveUpdate: (details) {
            if (_isRecording.value) {
              _dragOffset.value = details.localOffsetFromOrigin.dx;

              if (_dragOffset.value < _cancelThreshold) {
                _isRecording.value = false;
                // --- FIX: Discard the recording hardware-wise ---
                context.read<MessageCubit>().discardRecording();
                log("🛑 Swiped to cancel: Discarded.");
              }
            }
          },
          onLongPressEnd: (_) async {
            if (_isRecording.value) {
              _isRecording.value = false;

              final duration = DateTime.now().difference(_recordingStartTime ?? DateTime.now());

              if (duration.inSeconds < 1) {
                _showShortRecordingWarning();
                // --- FIX: Discard the recording locally ---
                context.read<MessageCubit>().discardRecording();
                log("⏳ Too short: Discarded.");
              }
              else if (_dragOffset.value > _cancelThreshold) {
                // SUCCESS: Only call this when conditions are met
                await context.read<MessageCubit>().stopAndSendRecording();
                log("✅ Sent successfully.");
              }
            }
          },
          onTap: () {
            if (!isEmpty) {
              context.read<MessageCubit>().handleSendMessage(text: _controller.text.trim());
              _controller.clear();
              _isTextEmpty.value = true;
            }
          },
          child: ValueListenableBuilder<bool>(
            valueListenable: _isRecording,
            builder: (context, recording, _) {
              return AnimatedScale(
                scale: recording ? 1.5 : 1.0,
                duration: const Duration(milliseconds: 150),
                child: CircleAvatar(
                  backgroundColor: AppColors.primary,
                  radius: 20.r,
                  child: Icon(isEmpty ? Icons.mic : Icons.send, color: Colors.white, size: 20.sp),
                ),
              );
            },
          ),
        );
      },
    );
  }
  void _showAttachmentMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (innerContext) => Container(
        margin: EdgeInsets.all(16.r),
        decoration: BoxDecoration(color: const Color(0xFF1F1F1F), borderRadius: BorderRadius.circular(24.r)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildMenuItem(innerContext, Icons.insert_drive_file, "Document", Colors.deepPurpleAccent, () => context.read<MessageCubit>().pickAFile()),
            _buildMenuItem(innerContext, Icons.image, "Photos", Colors.blueAccent, () => context.read<MessageCubit>().pickAFile()),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, IconData icon, String title, Color color, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      onTap: () { Navigator.pop(context); onTap(); },
    );
  }

  Widget _buildFilePreview(BuildContext context) {
    return BlocBuilder<MessageCubit, MessageState>(
      builder: (context, state) {
        if (state is MessageSuccess && state.stagedFileName != null) {
          return Container(
            margin: EdgeInsets.only(bottom: 8.h),
            padding: EdgeInsets.all(8.h),
            decoration: BoxDecoration(color: AppColors.fieldFillColor, borderRadius: BorderRadius.circular(12.r)),
            child: Row(
              children: [
                const Icon(Icons.insert_drive_file, color: AppColors.primary),
                SizedBox(width: 8.w),
                Expanded(child: Text(state.stagedFileName!, overflow: TextOverflow.ellipsis)),
                GestureDetector(onTap: () => context.read<MessageCubit>().emit(state.copyWith(clearFile: true)), child: const Icon(Icons.cancel, color: Colors.grey)),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}