import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VoiceMessagePlayer extends StatefulWidget {
  final String url;
  final Color textColor;

  const VoiceMessagePlayer({
    super.key,
    required this.url,
    required this.textColor,
  });

  @override
  State<VoiceMessagePlayer> createState() => _VoiceMessagePlayerState();
}

class _VoiceMessagePlayerState extends State<VoiceMessagePlayer> {
  final AudioPlayer _player = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    super.initState();
    _player.onPositionChanged.listen((p) {
      if (mounted) setState(() => position = p);
    });
    _player.onDurationChanged.listen((d) {
      if (mounted) setState(() => duration = d);
    });
    _player.onPlayerComplete.listen((_) {
      if (mounted) {
        setState(() {
          isPlaying = false;
          position = Duration.zero;
        });
      }
    });
  }

  @override
  void dispose() {
    _player.stop();
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () async {
            if (isPlaying) {
              await _player.pause();
            } else {
              await _player.play(UrlSource(widget.url));
            }
            if (mounted) setState(() => isPlaying = !isPlaying);
          },
          child: Icon(
            isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
            color: widget.textColor,
            size: 30.sp,
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LinearProgressIndicator(
                value: (duration.inMilliseconds > 0)
                    ? (position.inMilliseconds / duration.inMilliseconds)
                    : 0.0,
                backgroundColor: widget.textColor.withOpacity(0.1),
                color: widget.textColor,
                minHeight: 2,
              ),
              if (isPlaying) ...[
                SizedBox(height: 4.h),
                Text(
                  "${position.inMinutes}:${(position.inSeconds % 60).toString().padLeft(2, '0')}",
                  style: TextStyle(color: widget.textColor, fontSize: 9.sp),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}