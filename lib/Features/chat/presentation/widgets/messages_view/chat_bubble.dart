// todo: duration for voice messages

// import 'dart:developer';
// import 'dart:io';
//
// import 'package:audioplayers/audioplayers.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:stay_match/core/constants/app_colors.dart';
// import 'package:stay_match/core/constants/app_styles.dart';
// import 'package:stay_match/core/networking/endpoints.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// import '../../../data/models/start_chat_response.dart';
// import '../chat_list_view/chat_helper.dart';
//
// class ChatBubble extends StatelessWidget {
//   final Messages message;
//   final bool isMe;
//   final String? imageUrl;
//   final String? fullName;
//
//   const ChatBubble({
//     super.key,
//     required this.message,
//     required this.isMe,
//     required this.imageUrl,
//     required this.fullName,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     bool isText = message.type == "Text";
//     bool isVoice = message.type == "Voice";
//
//     return Align(
//       alignment: isMe ? AlignmentDirectional.centerEnd : AlignmentDirectional.centerStart,
//       child: Padding(
//         padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 12.w),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.end,
//           mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
//           children: [
//             if (!isMe) _buildAvatar(),
//             Flexible(
//               child: Column(
//                 crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
//                     padding: (isText || isVoice) ? EdgeInsets.all(12.r) : EdgeInsets.zero,
//                     decoration: BoxDecoration(
//                       color: isMe ? AppColors.primary : Colors.white,
//                       borderRadius: BorderRadius.only(
//                         topLeft: const Radius.circular(16),
//                         topRight: const Radius.circular(16),
//                         bottomLeft: Radius.circular(isMe ? 16 : 0),
//                         bottomRight: Radius.circular(isMe ? 0 : 16),
//                       ),
//                       boxShadow: [
//                         BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2))
//                       ],
//                     ),
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(14),
//                       child: _buildContent(context),
//                     ),
//                   ),
//                   _buildTimestamp(),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildContent(BuildContext context) {
//     final textColor = isMe ? Colors.white : AppColors.textColorPrimary;
//     String path = _getNormalizedPath(message.fileUrl);
//
//     switch (message.type) {
//       case "Text":
//         return Text(
//           message.content ?? "",
//           style: AppStyles.regular12poppins.copyWith(color: textColor, height: 1.4),
//         );
//       case "Image":
//         return _buildImage(path);
//       case "Voice":
//         return VoiceMessagePlayer(url: path, textColor: textColor);
//       default:
//         return _buildFileCard(path, textColor);
//     }
//   }
//
//   Widget _buildImage(String path) {
//     bool isLocal = path.startsWith('/data') || path.startsWith('/cache');
//     return GestureDetector(
//       onTap: () => _viewFile(path),
//       child: isLocal
//           ? Image.file(File(path), fit: BoxFit.cover)
//           : CachedNetworkImage(
//         imageUrl: path,
//         fit: BoxFit.cover,
//         placeholder: (context, url) => Container(height: 150.h, color: Colors.grey[200]),
//         errorWidget: (context, url, error) => const Icon(Icons.broken_image),
//       ),
//     );
//   }
//
//   Widget _buildFileCard(String path, Color textColor) {
//     bool isPdf = path.toLowerCase().contains('.pdf');
//     return GestureDetector(
//       onTap: () => _viewFile(path),
//       child: Container(
//         width: 220.w,
//         color: isMe ? Colors.black.withOpacity(0.1) : Colors.grey[50],
//         child: Column(
//           children: [
//             Container(
//               height: 65.h,
//               width: double.infinity,
//               color: isPdf ? Colors.red.withOpacity(0.1) : Colors.blue.withOpacity(0.1),
//               child: Icon(
//                 isPdf ? Icons.picture_as_pdf : Icons.insert_drive_file,
//                 color: isPdf ? Colors.red : AppColors.primary,
//                 size: 35.sp,
//               ),
//             ),
//             Container(
//               padding: EdgeInsets.all(10.r),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Text(
//                       path.split('/').last,
//                       style: TextStyle(color: textColor, fontSize: 11.sp, fontWeight: FontWeight.bold),
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                   Icon(Icons.download_for_offline, size: 18.sp, color: textColor.withOpacity(0.5)),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   String _getNormalizedPath(String? raw) {
//     if (raw == null || raw.isEmpty) return "";
//     if (raw.startsWith('http')) return raw;
//     if (raw.startsWith('/uploads')) return "${Endpoints.baseUrl}$raw";
//     if (raw.startsWith('/')) return raw;
//     return "${Endpoints.baseUrl}/uploads/$raw";
//   }
//
//   Widget _buildAvatar() {
//     return Container(
//       margin: EdgeInsetsDirectional.only(end: 8.w),
//       width: 32.r,
//       height: 32.r,
//       child: ClipOval(
//         child: (imageUrl == null || imageUrl!.isEmpty)
//             ? ChatHelper.buildPlaceholder(fullName ?? '?', fontSize: 12)
//             : CachedNetworkImage(imageUrl: imageUrl!, fit: BoxFit.cover),
//       ),
//     );
//   }
//
//   Widget _buildTimestamp() {
//     return Padding(
//       padding: EdgeInsets.only(top: 4.h, left: 4.w, right: 4.w),
//       child: Text(
//         message.sentAt?.substring(11, 16) ?? "",
//         style: TextStyle(fontSize: 10.sp, color: AppColors.textColorSecondary),
//       ),
//     );
//   }
//
//   void _viewFile(String url) async {
//     final uri = Uri.parse(url);
//     if (await canLaunchUrl(uri)) await launchUrl(uri, mode: LaunchMode.externalApplication);
//   }
// }
//
// // --- SUB-WIDGET FOR VOICE PLAYBACK ---
// class VoiceMessagePlayer extends StatefulWidget {
//   final String url;
//   final Color textColor;
//
//   const VoiceMessagePlayer({super.key, required this.url, required this.textColor});
//
//   @override
//   State<VoiceMessagePlayer> createState() => _VoiceMessagePlayerState();
// }
//
// class _VoiceMessagePlayerState extends State<VoiceMessagePlayer> {
//   final AudioPlayer _player = AudioPlayer();
//   bool isPlaying = false;
//   Duration duration = Duration.zero;
//   Duration position = Duration.zero;
//   bool isLoaded = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _initPlayer();
//   }
//
//   Future<void> _initPlayer() async {
//     try {
//       await _player.setSource(UrlSource(widget.url));
//
//       _player.onDurationChanged.listen((d) {
//         if (mounted && d != Duration.zero) {
//           setState(() {
//             duration = d;
//             isLoaded = true;
//           });
//         }
//       });
//
//       _player.onPositionChanged.listen((p) {
//         if (mounted) setState(() => position = p);
//       });
//
//       _player.onPlayerComplete.listen((_) {
//         if (mounted) {
//           setState(() {
//             isPlaying = false;
//             position = Duration.zero;
//           });
//         }
//       });
//     } catch (e) {
//       log("🎙️ Voice pre-fetch error: $e");
//     }
//   }
//
//   @override
//   void dispose() {
//     _player.stop();
//     _player.dispose();
//     super.dispose();
//   }
//
//   String _formatDuration(Duration d) {
//     String minutes = d.inMinutes.toString();
//     String seconds = (d.inSeconds % 60).toString().padLeft(2, '0');
//     return "$minutes:$seconds";
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         GestureDetector(
//           onTap: () async {
//             try {
//               if (isPlaying) {
//                 await _player.pause();
//               } else {
//                 await _player.play(UrlSource(widget.url));
//                 if (!isLoaded) {
//                   final d = await _player.getDuration();
//                   if (d != null && mounted) {
//                     setState(() {
//                       duration = d;
//                       isLoaded = true;
//                     });
//                   }
//                 }
//               }
//               if (mounted) setState(() => isPlaying = !isPlaying);
//             } catch (e) {
//               log("🎙️ Playback Error: $e");
//             }
//           },
//           child: Icon(
//             isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
//             color: widget.textColor,
//             size: 38.sp,
//           ),
//         ),
//         SizedBox(width: 8.w),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(
//               width: 130.w,
//               child: LinearProgressIndicator(
//                 value: (duration.inMilliseconds > 0)
//                     ? (position.inMilliseconds / duration.inMilliseconds)
//                     : 0.0,
//                 backgroundColor: widget.textColor.withOpacity(0.2),
//                 color: widget.textColor,
//                 minHeight: 3,
//               ),
//             ),
//             SizedBox(height: 6.h),
//             Text(
//               // If not loaded and not playing, show "..." instead of 0:00
//               !isLoaded && !isPlaying
//                   ? "..."
//                   : (isPlaying ? _formatDuration(position) : _formatDuration(duration)),
//               style: TextStyle(
//                   color: widget.textColor,
//                   fontSize: 10.sp,
//                   fontWeight: FontWeight.bold
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }







import 'dart:developer';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

  const ChatBubble({
    super.key,
    required this.message,
    required this.isMe,
    required this.imageUrl,
    required this.fullName,
  });

  @override
  Widget build(BuildContext context) {
    bool isText = message.type == "Text";
    bool isVoice = message.type == "Voice";

    return Align(
      alignment: isMe ? AlignmentDirectional.centerEnd : AlignmentDirectional.centerStart,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 12.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            if (!isMe) _buildAvatar(),
            Flexible(
              child: Column(
                crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Container(
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.72),
                    padding: (isText || isVoice) ? EdgeInsets.all(12.r) : EdgeInsets.zero,
                    decoration: BoxDecoration(
                      color: isMe ? AppColors.primary : Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(16),
                        topRight: const Radius.circular(16),
                        bottomLeft: Radius.circular(isMe ? 16 : 0),
                        bottomRight: Radius.circular(isMe ? 0 : 16),
                      ),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 4))
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: _buildContent(context),
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

  Widget _buildContent(BuildContext context) {
    final textColor = isMe ? Colors.white : AppColors.textColorPrimary;
    String path = _getNormalizedPath(message.fileUrl);

    switch (message.type) {
      case "Text":
        return Text(
          message.content ?? "",
          style: AppStyles.regular12poppins.copyWith(color: textColor, height: 1.4),
        );
      case "Image":
        return _buildImage(context, path);
      case "Voice":
        return VoiceMessagePlayer(url: path, textColor: textColor);
      default:
        return _buildFileCard(path, textColor);
    }
  }

  Widget _buildImage(BuildContext context, String path) {
    bool isLocal = path.startsWith('/data') || path.startsWith('/cache');
    return GestureDetector(
      onTap: () => _openFullScreenImage(context, path, isLocal),
      child: Hero(
        tag: path,
        child: isLocal
            ? Image.file(File(path), fit: BoxFit.cover)
            : CachedNetworkImage(
          imageUrl: path,
          fit: BoxFit.cover,
          placeholder: (context, url) => Container(height: 150.h, color: Colors.grey[100]),
          errorWidget: (context, url, error) => const Icon(Icons.broken_image),
        ),
      ),
    );
  }

  void _openFullScreenImage(BuildContext context, String path, bool isLocal) {
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
                  placeholder: (context, url) => const CircularProgressIndicator(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFileCard(String path, Color textColor) {
    String fileName = path.split('/').last;

    return GestureDetector(
      onTap: () => _viewFile(path),
      child: Container(
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
          // color: isMe ? Colors.white.withValues(alpha: 0.15) : Colors.grey[100],
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 40.r,
              width: 40.r,
              decoration: BoxDecoration(
                color: isMe ? Colors.white.withValues(alpha: 0.2) : Colors.white,
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
                    style: AppStyles.medium12poppins.copyWith(color: textColor),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "Tap to view document",
                    style: AppStyles.regular10poppins.copyWith(color: textColor.withValues(alpha: 0.6)),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded, size: 12.sp, color: textColor.withValues(alpha: 0.3)),
          ],
        ),
      ),
    );
  }

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
            : CachedNetworkImage(imageUrl: imageUrl!, fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildTimestamp() {
    return Padding(
      padding: EdgeInsets.only(top: 4.h, left: 4.w, right: 4.w),
      child: Text(
        message.sentAt?.substring(11, 16) ?? "",
        style: TextStyle(fontSize: 10.sp, color: AppColors.textColorSecondary),
      ),
    );
  }

  void _viewFile(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}