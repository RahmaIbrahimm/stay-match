// // import 'dart:developer';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';
// // import 'package:stay_match/Features/chat/presentation/manager/message_cubit.dart';
// // import 'package:stay_match/core/widgets/custom_text_form_field.dart';
// //
// // import '../../../../../core/constants/app_colors.dart';
// // import '../../../../../core/constants/app_strings.dart';
// //
// // class MessageInputBar extends StatefulWidget {
// //   final int chatId;
// //   const MessageInputBar({super.key, required this.chatId});
// //
// //   @override
// //   State<MessageInputBar> createState() => _MessageInputBarState();
// // }
// //
// // class _MessageInputBarState extends State<MessageInputBar>
// //     with SingleTickerProviderStateMixin {
// //   final TextEditingController _controller = TextEditingController();
// //
// //   final ValueNotifier<bool> _isTextEmpty = ValueNotifier<bool>(true);
// //   final ValueNotifier<bool> _isRecording = ValueNotifier<bool>(false);
// //   final ValueNotifier<double> _dragOffset = ValueNotifier<double>(0.0);
// //
// //   late AnimationController _pulseController;
// //
// //   DateTime? _recordingStartTime;
// //   static const double _cancelThreshold = -100.0;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _pulseController = AnimationController(
// //       vsync: this,
// //       duration: const Duration(milliseconds: 800),
// //     )..repeat(reverse: true);
// //   }
// //
// //   @override
// //   void dispose() {
// //     _pulseController.dispose();
// //     _controller.dispose();
// //     super.dispose();
// //   }
// //
// //   void _showShortRecordingWarning() {
// //     ScaffoldMessenger.of(context).showSnackBar(
// //       SnackBar(
// //         content: const Text("Hold to record"),
// //         behavior: SnackBarBehavior.floating,
// //         duration: const Duration(milliseconds: 800),
// //         width: 150.w,
// //         backgroundColor: Colors.black87,
// //         shape: RoundedRectangleBorder(
// //           borderRadius: BorderRadius.circular(20),
// //         ),
// //       ),
// //     );
// //   }
// //
// //   bool _hasAttachment(MessageState state) {
// //     return state is MessageSuccess && state.stagedFileName != null;
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
// //       decoration: const BoxDecoration(
// //         color: Colors.white,
// //         border: Border(top: BorderSide(color: AppColors.fieldFillColor)),
// //       ),
// //       child: SafeArea(
// //         child: Column(
// //           mainAxisSize: MainAxisSize.min,
// //           children: [
// //             _buildFilePreview(),
// //             Row(
// //               children: [
// //                 _buildLeftIcon(),
// //                 SizedBox(width: 12.w),
// //                 Expanded(child: _buildInput()),
// //                 SizedBox(width: 12.w),
// //                 _buildActionButton(),
// //               ],
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// //   // ---------------- INPUT ----------------
// //
// //   Widget _buildInput() {
// //     return CustomTextFormField(
// //       controller: _controller,
// //       onChanged: (val) => _isTextEmpty.value = val.trim().isEmpty,
// //       focusColor: AppColors.stroke,
// //       hasShadow: false,
// //       borderRadius: 999,
// //       stroke: false,
// //       fillColor: AppColors.fieldFillColor,
// //       verticalPadding: 6,
// //       hintText: AppStrings.typeMessage,
// //       validator: (val) => null,
// //     );
// //   }
// //
// //   // ---------------- LEFT ICON (ATTACHMENT) ----------------
// //
// //   Widget _buildLeftIcon() {
// //     return ValueListenableBuilder<bool>(
// //       valueListenable: _isRecording,
// //       builder: (context, recording, _) {
// //         if (recording) {
// //           return FadeTransition(
// //             opacity: _pulseController,
// //             child: const Icon(
// //               Icons.fiber_manual_record,
// //               color: Colors.red,
// //               size: 22,
// //             ),
// //           );
// //         }
// //
// //         return GestureDetector(
// //           onTap: _showAttachmentMenu,
// //           child: const Icon(
// //             Icons.add_circle_outline,
// //             color: AppColors.primary,
// //             size: 28,
// //           ),
// //         );
// //       },
// //     );
// //   }
// //
// //   // ---------------- SEND / MIC BUTTON ----------------
// //
// //   Widget _buildActionButton() {
// //     return BlocBuilder<MessageCubit, MessageState>(
// //       builder: (context, state) {
// //         return ValueListenableBuilder<bool>(
// //           valueListenable: _isTextEmpty,
// //           builder: (context, isEmpty, _) {
// //             final hasAttachment = _hasAttachment(state);
// //             final canSend = !isEmpty || hasAttachment;
// //
// //             return GestureDetector(
// //               // onTap: () {
// //               //   if (canSend) {
// //               //     context.read<MessageCubit>().handleSendMessage(
// //               //       text: _controller.text.trim(),
// //               //     );
// //               //
// //               //     _controller.clear();
// //               //     _isTextEmpty.value = true;
// //               //   }
// //               // },
// //               // onTap: () async {
// //               //   if (canSend) {
// //               //     await context.read<MessageCubit>().handleSendMessage(
// //               //       text: _controller.text.trim(),
// //               //     );
// //               //
// //               //     _controller.clear();
// //               //     _isTextEmpty.value = true;
// //               //
// //               //     // IMPORTANT: clear attached file after sending
// //               //     context.read<MessageCubit>().clearStagedFile();
// //               //   }
// //               // },
// //               onTap: () async {
// //                 if (canSend) {
// //                   final textToSend = _controller.text.trim();
// //
// //                   // Clear UI immediately for optimistic feel
// //                   _controller.clear();
// //                   _isTextEmpty.value = true;
// //
// //                   await context.read<MessageCubit>().handleSendMessage(
// //                     text: textToSend,
// //                   );
// //                   // clearStagedFile() is now handled inside handleSendMessage
// //                 }
// //               },
// //               onLongPressStart: (_) async {
// //                 if (isEmpty) {
// //                   _isRecording.value = true;
// //                   _dragOffset.value = 0.0;
// //                   _recordingStartTime = DateTime.now();
// //                   await context.read<MessageCubit>().startRecording();
// //                 }
// //               },
// //               onLongPressMoveUpdate: (details) {
// //                 if (_isRecording.value) {
// //                   _dragOffset.value = details.localOffsetFromOrigin.dx;
// //
// //                   if (_dragOffset.value < _cancelThreshold) {
// //                     _isRecording.value = false;
// //                     context.read<MessageCubit>().discardRecording();
// //                   }
// //                 }
// //               },
// //               onLongPressEnd: (_) async {
// //                 if (_isRecording.value) {
// //                   _isRecording.value = false;
// //
// //                   final duration = DateTime.now()
// //                       .difference(_recordingStartTime ?? DateTime.now());
// //
// //                   if (duration.inSeconds < 1) {
// //                     _showShortRecordingWarning();
// //                     context.read<MessageCubit>().discardRecording();
// //                   } else {
// //                     await context
// //                         .read<MessageCubit>()
// //                         .stopAndSendRecording();
// //                   }
// //                 }
// //               },
// //               child: AnimatedScale(
// //                 scale: _isRecording.value ? 1.5 : 1.0,
// //                 duration: const Duration(milliseconds: 150),
// //                 child: CircleAvatar(
// //                   backgroundColor: AppColors.primary,
// //                   radius: 20.r,
// //                   child: Icon(
// //                     canSend ? Icons.send : Icons.mic,
// //                     color: Colors.white,
// //                     size: 20.sp,
// //                   ),
// //                 ),
// //               ),
// //             );
// //           },
// //         );
// //       },
// //     );
// //   }
// //
// //   // ---------------- FILE PREVIEW ----------------
// //
// //   Widget _buildFilePreview() {
// //     return BlocBuilder<MessageCubit, MessageState>(
// //       builder: (context, state) {
// //         if (state is MessageSuccess &&
// //             state.stagedFileName != null) {
// //           return Container(
// //             margin: EdgeInsets.only(bottom: 8.h),
// //             padding: EdgeInsets.all(8.h),
// //             decoration: BoxDecoration(
// //               color: AppColors.fieldFillColor,
// //               borderRadius: BorderRadius.circular(12.r),
// //             ),
// //             child: Row(
// //               children: [
// //                 const Icon(Icons.insert_drive_file,
// //                     color: AppColors.primary),
// //                 SizedBox(width: 8.w),
// //                 Expanded(
// //                   child: Text(
// //                     state.stagedFileName!,
// //                     overflow: TextOverflow.ellipsis,
// //                   ),
// //                 ),
// //                 GestureDetector(
// //                   onTap: () =>
// //                       context.read<MessageCubit>().discardRecording(),
// //                   child: IconButton(onPressed: (){
// //                     context.read<MessageCubit>().clearStagedFile();
// //                   }, icon: const Icon(Icons.cancel, color: Colors.grey)),
// //                   // child: const Icon(Icons.cancel, color: Colors.grey),
// //                 ),
// //               ],
// //             ),
// //           );
// //         }
// //         return const SizedBox.shrink();
// //       },
// //     );
// //   }
// //
// //   // ---------------- ATTACHMENT MENU ----------------
// //
// //   void _showAttachmentMenu() {
// //     showModalBottomSheet(
// //       context: context,
// //       backgroundColor: Colors.transparent,
// //       builder: (innerContext) => Container(
// //         margin: EdgeInsets.all(16.r),
// //         decoration: BoxDecoration(
// //           color: const Color(0xFF1F1F1F),
// //           borderRadius: BorderRadius.circular(24.r),
// //         ),
// //         child: Column(
// //           mainAxisSize: MainAxisSize.min,
// //           children: [
// //             ListTile(
// //               leading: const Icon(Icons.insert_drive_file,
// //                   color: Colors.deepPurpleAccent),
// //               title: const Text("Document",
// //                   style: TextStyle(color: Colors.white)),
// //               onTap: () {
// //                 Navigator.pop(innerContext);
// //                 context.read<MessageCubit>().pickAFile();
// //               },
// //             ),
// //             ListTile(
// //               leading: const Icon(Icons.image,
// //                   color: Colors.blueAccent),
// //               title: const Text("Photos",
// //                   style: TextStyle(color: Colors.white)),
// //               onTap: () {
// //                 Navigator.pop(innerContext);
// //                 context.read<MessageCubit>().pickAFile();
// //               },
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:stay_match/Features/chat/presentation/manager/message_cubit.dart';
// import 'package:stay_match/core/widgets/custom_text_form_field.dart';
//
// import '../../../../../core/constants/app_colors.dart';
// import '../../../../../core/constants/app_strings.dart';
//
// class MessageInputBar extends StatefulWidget {
//   final int chatId;
//   const MessageInputBar({super.key, required this.chatId});
//
//   @override
//   State<MessageInputBar> createState() => _MessageInputBarState();
// }
//
// class _MessageInputBarState extends State<MessageInputBar>
//     with SingleTickerProviderStateMixin {
//   final TextEditingController _controller = TextEditingController();
//
//   final ValueNotifier<bool> _isTextEmpty = ValueNotifier<bool>(true);
//   final ValueNotifier<bool> _isRecording = ValueNotifier<bool>(false);
//   final ValueNotifier<double> _dragOffset = ValueNotifier<double>(0.0);
//
//   late AnimationController _pulseController;
//
//   DateTime? _recordingStartTime;
//   static const double _cancelThreshold = -100.0;
//
//   @override
//   void initState() {
//     super.initState();
//     _pulseController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 800),
//     )..repeat(reverse: true);
//   }
//
//   @override
//   void dispose() {
//     _pulseController.dispose();
//     _controller.dispose();
//     _isTextEmpty.dispose();
//     _isRecording.dispose();
//     _dragOffset.dispose();
//     super.dispose();
//   }
//
//   void _showShortRecordingWarning() {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: const Text("Hold to record"),
//         behavior: SnackBarBehavior.floating,
//         duration: const Duration(milliseconds: 800),
//         width: 150.w,
//         backgroundColor: Colors.black87,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20),
//         ),
//       ),
//     );
//   }
//
//   bool _hasAttachment(MessageState state) {
//     return state is MessageSuccess && state.stagedFileName != null;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 12.h),
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         border: Border(top: BorderSide(color: AppColors.fieldFillColor)),
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           _buildFilePreview(),
//           Row(
//             children: [
//               _buildLeftIcon(),
//               SizedBox(width: 12.w),
//               Expanded(child: _buildInput()),
//               SizedBox(width: 12.w),
//               _buildActionButton(),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   // ---------------- INPUT ----------------
//
//   Widget _buildInput() {
//     return CustomTextFormField(
//       controller: _controller,
//       onChanged: (val) => _isTextEmpty.value = val.trim().isEmpty,
//       focusColor: AppColors.stroke,
//       hasShadow: false,
//       borderRadius: 999,
//       stroke: false,
//       fillColor: AppColors.fieldFillColor,
//       verticalPadding: 6,
//       hintText: AppStrings.typeMessage,
//       validator: (val) => null,
//     );
//   }
//
//   // ---------------- LEFT ICON (ATTACHMENT) ----------------
//
//   Widget _buildLeftIcon() {
//     return ValueListenableBuilder<bool>(
//       valueListenable: _isRecording,
//       builder: (context, recording, _) {
//         if (recording) {
//           return FadeTransition(
//             opacity: _pulseController,
//             child: const Icon(
//               Icons.fiber_manual_record,
//               color: Colors.red,
//               size: 22,
//             ),
//           );
//         }
//
//         return GestureDetector(
//           onTap: _showAttachmentMenu,
//           child: const Icon(
//             Icons.add_circle_outline,
//             color: AppColors.primary,
//             size: 28,
//           ),
//         );
//       },
//     );
//   }
//
//   // ---------------- SEND / MIC BUTTON ----------------
//
//   Widget _buildActionButton() {
//     return BlocBuilder<MessageCubit, MessageState>(
//       builder: (context, state) {
//         return ValueListenableBuilder<bool>(
//           valueListenable: _isTextEmpty,
//           builder: (context, isEmpty, _) {
//             final hasAttachment = _hasAttachment(state);
//             final canSend = !isEmpty || hasAttachment;
//
//             return ValueListenableBuilder<bool>(
//               valueListenable: _isRecording,
//               builder: (context, isRecording, _) {
//                 return GestureDetector(
//                   onTap: () async {
//                     if (canSend) {
//                       final textToSend = _controller.text.trim();
//
//                       // Clear UI immediately for snappy feel
//                       _controller.clear();
//                       _isTextEmpty.value = true;
//
//                       await context.read<MessageCubit>().handleSendMessage(
//                         text: textToSend,
//                       );
//                     }
//                   },
//                   onLongPressStart: (_) async {
//                     if (isEmpty && !hasAttachment) {
//                       _isRecording.value = true;
//                       _dragOffset.value = 0.0;
//                       _recordingStartTime = DateTime.now();
//                       await context.read<MessageCubit>().startRecording();
//                     }
//                   },
//                   onLongPressMoveUpdate: (details) {
//                     if (_isRecording.value) {
//                       _dragOffset.value = details.localOffsetFromOrigin.dx;
//
//                       if (_dragOffset.value < _cancelThreshold) {
//                         _isRecording.value = false;
//                         context.read<MessageCubit>().discardRecording();
//                       }
//                     }
//                   },
//                   onLongPressEnd: (_) async {
//                     if (_isRecording.value) {
//                       _isRecording.value = false;
//
//                       final duration = DateTime.now()
//                           .difference(_recordingStartTime ?? DateTime.now());
//
//                       if (duration.inSeconds < 1) {
//                         _showShortRecordingWarning();
//                         context.read<MessageCubit>().discardRecording();
//                       } else {
//                         await context
//                             .read<MessageCubit>()
//                             .stopAndSendRecording();
//                       }
//                     }
//                   },
//                   child: AnimatedScale(
//                     scale: isRecording ? 1.5 : 1.0,
//                     duration: const Duration(milliseconds: 150),
//                     child: CircleAvatar(
//                       backgroundColor: AppColors.primary,
//                       radius: 20.r,
//                       child: Icon(
//                         canSend ? Icons.send : Icons.mic,
//                         color: Colors.white,
//                         size: 20.sp,
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             );
//           },
//         );
//       },
//     );
//   }
//
//   // ---------------- FILE PREVIEW ----------------
//
//   Widget _buildFilePreview() {
//     return BlocBuilder<MessageCubit, MessageState>(
//       builder: (context, state) {
//         if (state is MessageSuccess && state.stagedFileName != null) {
//           return Container(
//             margin: EdgeInsets.only(bottom: 8.h),
//             padding: EdgeInsets.all(8.h),
//             decoration: BoxDecoration(
//               color: AppColors.fieldFillColor,
//               borderRadius: BorderRadius.circular(12.r),
//             ),
//             child: Row(
//               children: [
//                 const Icon(Icons.insert_drive_file, color: AppColors.primary),
//                 SizedBox(width: 8.w),
//                 Expanded(
//                   child: Text(
//                     state.stagedFileName!,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//                 IconButton(
//                   onPressed: () =>
//                       context.read<MessageCubit>().clearStagedFile(),
//                   icon: const Icon(Icons.cancel, color: Colors.grey),
//                 ),
//               ],
//             ),
//           );
//         }
//         return const SizedBox.shrink();
//       },
//     );
//   }
//
//   // ---------------- ATTACHMENT MENU ----------------
//
//   void _showAttachmentMenu() {
//     showModalBottomSheet(
//       context: context,
//       backgroundColor: Colors.transparent,
//       builder: (innerContext) => Container(
//         margin: EdgeInsets.all(16.r),
//         decoration: BoxDecoration(
//           color: const Color(0xFF1F1F1F),
//           borderRadius: BorderRadius.circular(24.r),
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             ListTile(
//               leading: const Icon(Icons.insert_drive_file,
//                   color: Colors.deepPurpleAccent),
//               title: const Text("Document",
//                   style: TextStyle(color: Colors.white)),
//               onTap: () {
//                 Navigator.pop(innerContext);
//                 context.read<MessageCubit>().pickAFile();
//               },
//             ),
//             ListTile(
//               leading:
//               const Icon(Icons.image, color: Colors.blueAccent),
//               title: const Text("Photos",
//                   style: TextStyle(color: Colors.white)),
//               onTap: () {
//                 Navigator.pop(innerContext);
//                 context.read<MessageCubit>().pickAFile();
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:async';

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

class _MessageInputBarState extends State<MessageInputBar>
    with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();

  final ValueNotifier<bool> _isTextEmpty = ValueNotifier<bool>(true);
  final ValueNotifier<bool> _isRecording = ValueNotifier<bool>(false);
  final ValueNotifier<double> _dragOffset = ValueNotifier<double>(0.0);
  final ValueNotifier<Duration> _recordDuration =
  ValueNotifier<Duration>(Duration.zero);

  late AnimationController _pulseController;
  Timer? _recordTimer;

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
    _recordTimer?.cancel();
    _controller.dispose();
    _isTextEmpty.dispose();
    _isRecording.dispose();
    _dragOffset.dispose();
    _recordDuration.dispose();
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  bool _hasAttachment(MessageState state) {
    return state is MessageSuccess && state.stagedFileName != null;
  }

  // ---------------- RECORDING TIMER ----------------

  void _startRecordingTimer() {
    _recordDuration.value = Duration.zero;
    _recordTimer?.cancel();
    _recordTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      _recordDuration.value += const Duration(seconds: 1);
    });
  }

  void _stopRecordingTimer() {
    _recordTimer?.cancel();
    _recordTimer = null;
  }

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes;
    final seconds = d.inSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    final bottomSafeArea = MediaQuery.of(context).padding.bottom;

    return Container(
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
        top: 12.h,
        // Only reserve space for the home indicator / gesture bar when the
        // keyboard is closed. When it's open, the keyboard itself sits
        // flush against the input bar — adding this padding on top of that
        // creates extra white space.
        bottom: keyboardOpen ? 12.h : (12.h + bottomSafeArea),
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.fieldFillColor)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildFilePreview(),
          ValueListenableBuilder<bool>(
            valueListenable: _isRecording,
            builder: (context, recording, _) {
              return Row(
                children: [
                  if (!recording) ...[
                    _buildLeftIcon(),
                    SizedBox(width: 12.w),
                    Expanded(child: _buildInput()),
                  ] else
                    Expanded(child: _buildRecordingIndicator()),
                  SizedBox(width: 12.w),
                  _buildActionButton(),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  // ---------------- INPUT ----------------

  Widget _buildInput() {
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

  // ---------------- LEFT ICON (ATTACHMENT) ----------------

  Widget _buildLeftIcon() {
    return GestureDetector(
      onTap: _showAttachmentMenu,
      child: const Icon(
        Icons.add_circle_outline,
        color: AppColors.primary,
        size: 28,
      ),
    );
  }

  // ---------------- RECORDING INDICATOR ----------------

  Widget _buildRecordingIndicator() {
    return Container(
      height: 44.h,
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      decoration: BoxDecoration(
        color: AppColors.fieldFillColor,
        borderRadius: BorderRadius.circular(999),
      ),
      child: ValueListenableBuilder<double>(
        valueListenable: _dragOffset,
        builder: (context, offset, _) {
          // 0 = no drag, 1 = at/past cancel threshold
          final cancelProgress = (offset / _cancelThreshold).clamp(0.0, 1.0);

          return Row(
            children: [
              // Pulsing recording dot
              FadeTransition(
                opacity: _pulseController,
                child: Container(
                  width: 10.r,
                  height: 10.r,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              SizedBox(width: 10.w),

              // Live duration
              ValueListenableBuilder<Duration>(
                valueListenable: _recordDuration,
                builder: (context, duration, _) => Text(
                  _formatDuration(duration),
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textColorPrimary,
                  ),
                ),
              ),

              const Spacer(),

              // "Slide to cancel" hint — fades out as the user drags toward
              // the cancel threshold.
              Opacity(
                opacity: 1 - cancelProgress,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.chevron_left,
                      size: 18.r,
                      color: AppColors.textColorSecondary,
                    ),
                    Text(
                      'Slide to cancel',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.textColorSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // ---------------- SEND / MIC BUTTON ----------------

  Widget _buildActionButton() {
    return BlocBuilder<MessageCubit, MessageState>(
      builder: (context, state) {
        return ValueListenableBuilder<bool>(
          valueListenable: _isTextEmpty,
          builder: (context, isEmpty, _) {
            final hasAttachment = _hasAttachment(state);
            final canSend = !isEmpty || hasAttachment;

            return ValueListenableBuilder<bool>(
              valueListenable: _isRecording,
              builder: (context, isRecording, _) {
                return GestureDetector(
                  onTap: () async {
                    if (canSend) {
                      final textToSend = _controller.text.trim();

                      // Clear UI immediately for snappy feel
                      _controller.clear();
                      _isTextEmpty.value = true;

                      await context.read<MessageCubit>().handleSendMessage(
                        text: textToSend,
                      );
                    }
                  },
                  onLongPressStart: (_) async {
                    if (isEmpty && !hasAttachment) {
                      _isRecording.value = true;
                      _dragOffset.value = 0.0;
                      _recordingStartTime = DateTime.now();
                      _startRecordingTimer();
                      await context.read<MessageCubit>().startRecording();
                    }
                  },
                  onLongPressMoveUpdate: (details) {
                    if (_isRecording.value) {
                      _dragOffset.value = details.localOffsetFromOrigin.dx;

                      if (_dragOffset.value < _cancelThreshold) {
                        _isRecording.value = false;
                        _stopRecordingTimer();
                        context.read<MessageCubit>().discardRecording();
                      }
                    }
                  },
                  onLongPressEnd: (_) async {
                    if (_isRecording.value) {
                      _isRecording.value = false;
                      _stopRecordingTimer();

                      final duration = DateTime.now()
                          .difference(_recordingStartTime ?? DateTime.now());

                      if (duration.inSeconds < 1) {
                        _showShortRecordingWarning();
                        context.read<MessageCubit>().discardRecording();
                      } else {
                        await context
                            .read<MessageCubit>()
                            .stopAndSendRecording();
                      }
                    }
                  },
                  child: AnimatedScale(
                    scale: isRecording ? 1.5 : 1.0,
                    duration: const Duration(milliseconds: 150),
                    child: CircleAvatar(
                      backgroundColor: AppColors.primary,
                      radius: 20.r,
                      child: Icon(
                        canSend ? Icons.send : Icons.mic,
                        color: Colors.white,
                        size: 20.sp,
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  // ---------------- FILE PREVIEW ----------------

  Widget _buildFilePreview() {
    return BlocBuilder<MessageCubit, MessageState>(
      builder: (context, state) {
        if (state is MessageSuccess && state.stagedFileName != null) {
          return Container(
            margin: EdgeInsets.only(bottom: 8.h),
            padding: EdgeInsets.all(8.h),
            decoration: BoxDecoration(
              color: AppColors.fieldFillColor,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              children: [
                const Icon(Icons.insert_drive_file, color: AppColors.primary),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    state.stagedFileName!,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  onPressed: () =>
                      context.read<MessageCubit>().clearStagedFile(),
                  icon: const Icon(Icons.cancel, color: Colors.grey),
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  // ---------------- ATTACHMENT MENU ----------------

  void _showAttachmentMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (innerContext) => Container(
        margin: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.insert_drive_file,
                  color: Colors.deepPurpleAccent),
              title: const Text("Document",
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(innerContext);
                context.read<MessageCubit>().pickAFile();
              },
            ),
            ListTile(
              leading:
              const Icon(Icons.image, color: Colors.blueAccent),
              title: const Text("Photos",
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(innerContext);
                context.read<MessageCubit>().pickAFile();
              },
            ),
          ],
        ),
      ),
    );
  }
}