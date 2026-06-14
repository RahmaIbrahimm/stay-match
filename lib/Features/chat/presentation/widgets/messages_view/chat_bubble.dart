import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/Features/chat/presentation/manager/message_cubit.dart';
import 'package:stay_match/Features/chat/presentation/widgets/messages_view/voice_message_player.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_styles.dart';
import 'package:stay_match/core/networking/endpoints.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/models/start_chat_response.dart';
import '../shared/chat_helper.dart';

class ChatBubble extends StatelessWidget {
  final Messages message;
  final bool isMe;
  final String? imageUrl;
  final String? fullName;
  final bool isPending;
  final bool isFailed;
  const ChatBubble({
    super.key,
    required this.message,
    required this.isMe,
    required this.imageUrl,
    required this.fullName,
    this.isPending = false,
    this.isFailed = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool isText = message.type == "Text";
    final bool isVoice = message.type == "Voice";

    return Align(
      alignment: isMe
          ? AlignmentDirectional.centerEnd
          : AlignmentDirectional.centerStart,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 12.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment:
          isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            if (!isMe) _buildAvatar(),
            Flexible(
              child: Column(
                crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onLongPress:
                    isFailed ? () => _showRetryMenu(context) : null,
                    child: Opacity(
                      opacity: isPending ? 0.6 : 1.0,
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.72,
                        ),
                        padding: (isText || isVoice)
                            ? EdgeInsets.all(12.r)
                            : EdgeInsets.zero,
                        decoration: BoxDecoration(
                          color: isMe ? AppColors.primary : Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(16),
                            topRight: const Radius.circular(16),
                            bottomLeft: Radius.circular(isMe ? 16 : 0),
                            bottomRight: Radius.circular(isMe ? 0 : 16),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.04),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: _buildContent(context),
                        ),
                      ),
                    ),
                  ),
                  _buildTimestamp(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- CONTENT ----------------

  Widget _buildContent(BuildContext context) {
    final textColor = isMe ? Colors.white : AppColors.textColorPrimary;
    final String path = _getNormalizedPath(message.fileUrl);

    switch (message.type) {
      case "Text":
        return Text(
          message.content ?? "",
          style: AppStyles.regular12poppins
              .copyWith(color: textColor, height: 1.4),
        );
      case "Image":
        return _buildImage(context, path);
      case "Voice":
        return VoiceMessagePlayer(url: path, textColor: textColor);
      default:
        return _buildFileCard(path, textColor);
    }
  }

  // ---------------- IMAGE ----------------

  Widget _buildImage(BuildContext context, String path) {
    final bool isLocal =
        path.startsWith('/data') || path.startsWith('/cache');
    return GestureDetector(
      onTap: () => _openFullScreenImage(context, path, isLocal),
      child: Hero(
        tag: path,
        child: isLocal
            ? Image.file(File(path), fit: BoxFit.cover)
            : CachedNetworkImage(
          height: 150.h,
          width: 200.h,
          imageUrl: path,
          fit: BoxFit.cover,
          placeholder: (context, url) =>
              Container(height: 150.h, color: Colors.grey[100]),
          errorWidget: (context, url, error) =>
          const Icon(Icons.broken_image),
        ),
      ),
    );
  }

  void _openFullScreenImage(
      BuildContext context, String path, bool isLocal) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            iconTheme: const IconThemeData(color: Colors.white),
            elevation: 0,
          ),
          body: Center(
            child: InteractiveViewer(
              panEnabled: true,
              minScale: 0.5,
              maxScale: 4.0,
              child: Hero(
                tag: path,
                child: isLocal
                    ? Image.file(File(path))
                    : CachedNetworkImage(
                  imageUrl: path,
                  fit: BoxFit.contain,
                  placeholder: (context, url) =>
                  const CircularProgressIndicator(
                      color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ---------------- FILE CARD ----------------

  Widget _buildFileCard(String path, Color textColor) {
    final String fileName = path.split('/').last;

    return GestureDetector(
      onTap: () => _viewFile(path),
      child: Container(
        padding: EdgeInsets.all(10.r),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 40.r,
              width: 40.r,
              decoration: BoxDecoration(
                color: isMe
                    ? Colors.white.withValues(alpha: 0.2)
                    : Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.description_outlined,
                color: isMe ? Colors.white : AppColors.primary,
                size: 20.sp,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fileName,
                    style: AppStyles.medium12poppins
                        .copyWith(color: textColor),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "Tap to view document",
                    style: AppStyles.regular10poppins
                        .copyWith(color: textColor.withValues(alpha: 0.6)),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 12.sp,
              color: textColor.withValues(alpha: 0.3),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- TIMESTAMP ----------------

  Widget _buildTimestamp() {
    return Padding(
      padding: EdgeInsets.only(top: 2.h, left: 4.w, right: 4.w),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _formatTime(message.sentAt),
            style: TextStyle(
                fontSize: 10.sp, color: AppColors.textColorSecondary),
          ),
          if (isMe) ...[
            SizedBox(width: 4.w),
            if (isPending)
              SizedBox(
                width: 10.r,
                height: 10.r,
                child: CircularProgressIndicator(
                  strokeWidth: 1.5,
                  color: AppColors.textColorSecondary,
                ),
              )
            else if (isFailed) ...[
              Text(
                "Hold to retry",
                style:
                TextStyle(fontSize: 9.sp, color: Colors.red.shade400),
              ),
              SizedBox(width: 3.w),
              Icon(
                Icons.error_outline_rounded,
                size: 12.sp,
                color: Colors.red.shade400,
              ),
            ],
          ],
        ],
      ),
    );
  }
  /// Formats an ISO 8601 timestamp (e.g. "2026-06-12T16:07:38...") as
  /// "h:mm AM/PM" (e.g. "4:07 PM"). Returns "" if [isoDate] is null/invalid.
  // String _formatTime(String? isoDate) {
  //   if (isoDate == null) return "";
  //   try {
  //     final date = DateTime.parse(isoDate);
  //     final hour24 = date.hour;
  //     final hour12 = hour24 % 12 == 0 ? 12 : hour24 % 12;
  //     final minute = date.minute.toString().padLeft(2, '0');
  //     final period = hour24 >= 12 ? 'PM' : 'AM';
  //     return '$hour12:$minute $period';
  //   } catch (_) {
  //     return "";
  //   }
  // }
  String _formatTime(String? isoDate) {
    if (isoDate == null) return "";

    try {
      final dateUtc = DateTime.parse('${isoDate}Z');
      final egyptTime = dateUtc.toLocal();

      final hour24 = egyptTime.hour;
      final hour12 = hour24 % 12 == 0 ? 12 : hour24 % 12;
      final minute = egyptTime.minute.toString().padLeft(2, '0');
      final period = hour24 >= 12 ? 'PM' : 'AM';

      return '$hour12:$minute $period';
    } catch (_) {
      return "";
    }
  }
  // ---------------- RETRY MENU ----------------

  void _showRetryMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        margin: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading:
              const Icon(Icons.refresh, color: Colors.greenAccent),
              title: const Text(
                "Retry",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);
                context.read<MessageCubit>().retrySendMessage(message);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete_outline,
                  color: Colors.redAccent),
              title: const Text(
                "Delete",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);
                context
                    .read<MessageCubit>()
                    .deleteFailedMessage(message);
              },
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- HELPERS ----------------

  String _getNormalizedPath(String? raw) {
    if (raw == null || raw.isEmpty) return "";
    if (raw.startsWith('http')) return raw;
    if (raw.startsWith('/uploads')) return "${Endpoints.baseUrl}$raw";
    if (raw.startsWith('/')) return raw;
    return "${Endpoints.baseUrl}/uploads/$raw";
  }

  Widget _buildAvatar() {
    return Container(
      margin: EdgeInsetsDirectional.only(end: 8.w),
      width: 32.r,
      height: 32.r,
      child: ClipOval(
        child: (imageUrl == null || imageUrl!.isEmpty)
            ? ChatHelper.buildPlaceholder(fullName ?? '?', fontSize: 12)
            : CachedNetworkImage(
          imageUrl: imageUrl!,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  void _viewFile(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}