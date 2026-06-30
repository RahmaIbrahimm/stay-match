
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/Features/chatbot/presentation/views/chatbot_view.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_icons.dart';

/// A draggable floating bubble that opens [ChatbotView]. Add this
/// explicitly to any screen you want it on — wrap that screen's body:
///
/// ```dart
/// Scaffold(
///   body: DraggableChatbotFab(
///     child: YourScreenContent(),
///   ),
/// )
/// ```
///
/// There's no global placement or route-based exclusion — every screen
/// opts in by wrapping itself with this widget directly.
class DraggableChatbotFab extends StatefulWidget {
  final Widget child;
  final bool hasBottomNav; // add this

  const DraggableChatbotFab({super.key, required this.child, required this.hasBottomNav});

  @override
  State<DraggableChatbotFab> createState() => _DraggableChatbotFabState();
}

class _DraggableChatbotFabState extends State<DraggableChatbotFab> {
  Offset? _position;
  static const double _bubbleSize = 56;
  static const double _margin = 12;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    // Reserve space for a bottom nav bar if present on this screen. If
    // this screen has no bottom nav, the bubble will just have a bit of
    // extra breathing room at the bottom — harmless.
    // final reservedBottom = 90.h;
    // Replace with this:
    final navBarHeight = kBottomNavigationBarHeight; // = 56.0, Flutter constant
    final systemBottom = MediaQuery.of(context).viewPadding.bottom; // gesture bar / home indicator
    // final reservedBottom = navBarHeight + systemBottom + _margin.h;
    final reservedBottom = 110.h + systemBottom; // matches your NavBar height exactly
    _position ??= Offset(
      screenSize.width - _bubbleSize.r - _margin.w,
      screenSize.height -
          _bubbleSize.r -
          _margin.h -
          reservedBottom -
          bottomPadding,
    );

    return Stack(
      fit: StackFit.expand,
      children: [
        widget.child,
        Positioned(
          left: _position!.dx,
          top: _position!.dy,
          child: GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                final newX = (_position!.dx + details.delta.dx).clamp(
                  _margin.w,
                  screenSize.width - _bubbleSize.r - _margin.w,
                );
                final newY = (_position!.dy + details.delta.dy).clamp(
                  MediaQuery.of(context).padding.top + _margin.h,
                  screenSize.height -
                      _bubbleSize.r -
                      _margin.h -
                      reservedBottom -
                      bottomPadding,
                );
                _position = Offset(newX, newY);
              });
            },
            onPanEnd: (_) {
              setState(() {
                final isCloserToLeft =
                    _position!.dx < (screenSize.width - _bubbleSize.r) / 2;
                final clampedY = _position!.dy.clamp(
                  MediaQuery.of(context).padding.top + _margin.h,
                  screenSize.height -
                      _bubbleSize.r -
                      _margin.h -
                      reservedBottom -
                      bottomPadding,
                );
                _position = Offset(
                  isCloserToLeft
                      ? _margin.w
                      : screenSize.width - _bubbleSize.r - _margin.w,
                  clampedY,
                );
              });
            },
            onTap: () => _openChatbot(context),
            child: _ChatbotBubble(size: _bubbleSize.r),
          ),
        ),
      ],
    );
  }

  /// Opens [ChatbotView] full-screen with a "rising up from the bubble"
  /// entrance: scales/fades in from the bubble's current position.
  void _openChatbot(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    final originAlignment = Alignment(
      ((_position!.dx + _bubbleSize.r / 2) / screenSize.width) * 2 - 1,
      ((_position!.dy + _bubbleSize.r / 2) / screenSize.height) * 2 - 1,
    );

    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: true,
        barrierColor: Colors.transparent,
        transitionDuration: const Duration(milliseconds: 320),
        reverseTransitionDuration: const Duration(milliseconds: 220),
        pageBuilder: (context, animation, secondaryAnimation) =>
        const ChatbotView(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final curved = CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
            reverseCurve: Curves.easeInCubic,
          );
          return FadeTransition(
            opacity: curved,
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.6, end: 1.0).animate(curved),
              alignment: originAlignment,
              child: child,
            ),
          );
        },
      ),
    );
  }
}

class _ChatbotBubble extends StatelessWidget {
  final double size;
  const _ChatbotBubble({required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.primary,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(size * 0.22),
        // pubspec.yaml's assets: section.
        child: Image.asset(
          scale:0.8,
          AppIcons.chatbotIcon,
          color: Colors.white,
          errorBuilder: (_, __, ___) => const Icon(
            Icons.chat_bubble_rounded,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}