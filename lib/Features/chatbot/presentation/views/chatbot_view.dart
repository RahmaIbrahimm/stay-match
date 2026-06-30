import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stay_match/Features/chatbot/data/models/chatbot_response.dart';
import 'package:stay_match/Features/chatbot/data/repos/chatbot_repo_impl.dart';
import 'package:stay_match/Features/chatbot/presentation/widgets/chatbot_drawer.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_styles.dart';
import 'package:stay_match/core/routing/app_routing.dart';
import 'package:stay_match/core/utils/service_locator.dart';

import '../../../../core/widgets/custom_elevated_button.dart';
import '../../data/models/chat_message_item.dart';
import '../manager/chatbot_cubit.dart';

class ChatbotView extends StatelessWidget {
  const ChatbotView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatbotCubit(chatbotRepo: getIt.get<ChatbotRepoImpl>()),
      child: const _ChatbotContent(),
    );
  }
}

// ── Main scaffold ─────────────────────────────────────────────────────────────

class _ChatbotContent extends StatefulWidget {
  const _ChatbotContent();

  @override
  State<_ChatbotContent> createState() => _ChatbotContentState();
}

class _ChatbotContentState extends State<_ChatbotContent> {
  final TextEditingController _controller = TextEditingController();
  final ValueNotifier<bool> _isTextEmpty = ValueNotifier<bool>(true);
  final ScrollController _scrollController = ScrollController();

  int _previousMessageCount = 0;

  @override
  void dispose() {
    _controller.dispose();
    _isTextEmpty.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    }
  }

  void _send() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    context.read<ChatbotCubit>().sendMessage(text);
    _controller.clear();
    _isTextEmpty.value = true;
  }

  @override
  Widget build(BuildContext context) {
    final keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    final bottomSafeArea = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.secondaryScaffBg,
      appBar: _ChatbotAppBar(),
      endDrawer: ChatbotDrawer(),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<ChatbotCubit, ChatbotState>(
              listenWhen: (previous, current) =>
              current.messages.length != _previousMessageCount ||
                  current.isSending != previous.isSending,
              listener: (context, state) {
                _previousMessageCount = state.messages.length;
                WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
              },
              builder: (context, state) {
                return ListView.builder(
                  controller: _scrollController,
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  physics: const BouncingScrollPhysics(),
                  itemCount: 1 + state.messages.length + (state.isSending ? 1 : 0),
                  itemBuilder: (context, index) {
                    // First item: welcome card
                    if (index == 0) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 16.h),
                        child: _WelcomeCard(
                          onSuggestionTap: (message) =>
                              context.read<ChatbotCubit>().sendSuggestion(message),
                        ),
                      );
                    }

                    final messageIndex = index - 1;

                    // Typing indicator (last item, only while sending)
                    if (messageIndex == state.messages.length) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: const _TypingIndicator(),
                      );
                    }

                    final message = state.messages[messageIndex];
                    final isLastMessage = messageIndex == state.messages.length - 1;
                    final showRetry = state is ChatbotError &&
                        isLastMessage &&
                        message.sender == ChatSender.user;

                    return Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: message.sender == ChatSender.user
                          ? _UserBubble(message: message, showRetry: showRetry)
                          : _BotBubble(
                        message: message,
                        onSuggestionTap: (value) =>
                            context.read<ChatbotCubit>().sendSuggestion(value),
                        onShowMore: () =>
                            context.read<ChatbotCubit>().sendMessage('Show more results'),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          _ChatInputBar(
            controller: _controller,
            isTextEmpty: _isTextEmpty,
            onSend: _send,
            keyboardOpen: keyboardOpen,
            bottomSafeArea: bottomSafeArea,
          ),
        ],
      ),
    );
  }
}

// ── App bar ───────────────────────────────────────────────────────────────────

class _ChatbotAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.containerColor,
      elevation: 0,
      title: Text(
        'AI Assistant',
        style: AppStyles.bold18poppins.copyWith(color: AppColors.primary),
      ),
      centerTitle: true,
    );
  }
}



class _WelcomeCard extends StatelessWidget {
  final void Function(String message) onSuggestionTap;

  const _WelcomeCard({required this.onSuggestionTap});

  static const _suggestions = [
    ('🔍', 'Apartments in Cairo', 'Show me apartments in Cairo'),
    ('🛏️', 'Room for Students', 'I need a room for students'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.containerColor,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: AppColors.elevationShadow,
      ),
      padding: EdgeInsets.all(24.r),
      child: Column(
        children: [
          Container(
            width: 64.r,
            height: 64.r,
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.check, color: AppColors.textColorWhite, size: 32.r),
          ),
          SizedBox(height: 16.h),
          Text(
            'Welcome to StayMatch!',
            textAlign: TextAlign.center,
            style: AppStyles.bold20poppins.copyWith(color: AppColors.textColorPrimary),
          ),
          SizedBox(height: 10.h),
          Text(
            "I'm your AI assistant. I can help you find an apartment, a room, or a suitable place to stay.",
            textAlign: TextAlign.center,
            style: AppStyles.regular14poppins.copyWith(
              color: AppColors.textColorSecondary,
              height: 1.5,
            ),
          ),
          SizedBox(height: 20.h),
          ..._suggestions.map((s) => Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: SizedBox(
              width: double.infinity,
              child: _SuggestionChip(
                emoji: s.$1,
                label: s.$2,
                onTap: () => onSuggestionTap(s.$3),
              ),
            ),
          )),
        ],
      ),
    );
  }
}

// ── Suggestion chip ───────────────────────────────────────────────────────────

class _SuggestionChip extends StatelessWidget {
  final String label;
  final String? emoji;
  final VoidCallback onTap;

  const _SuggestionChip({required this.label, required this.onTap, this.emoji});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: AppColors.blueGrey,
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (emoji != null) ...[
              Text(emoji!, style: TextStyle(fontSize: 16.sp)),
              SizedBox(width: 8.w),
            ],
            Expanded(
              child: Text(
                label,
                style: AppStyles.semiBold14poppins.copyWith(color: AppColors.primary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── User bubble (right side) ────────────────────────────────────────────────────

class _UserBubble extends StatelessWidget {
  final ChatMessageItem message;
  final bool showRetry;

  const _UserBubble({required this.message, this.showRetry = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.r),
                    topRight: Radius.circular(16.r),
                    bottomLeft: Radius.circular(16.r),
                    bottomRight: Radius.circular(4.r),
                  ),
                ),
                child: Text(
                  message.text ?? '',
                  style: AppStyles.regular14poppins.copyWith(
                    color: AppColors.textColorWhite,
                    height: 1.4,
                  ),
                ),
              ),
              SizedBox(height: 4.h),
              if (showRetry)
                GestureDetector(
                  onTap: () => context.read<ChatbotCubit>().retryLastMessage(),
                  child: Row(
                    children: [
                      Icon(Icons.error_outline_rounded, size: 12.r, color: Colors.red.shade400),
                      SizedBox(width: 4.w),
                      Text(
                        'Failed — tap to retry',
                        style: AppStyles.regular12poppins.copyWith(color: Colors.red.shade400),
                      ),
                    ],
                  ),
                )
              else
                Text(
                  _formatTime(message.timestamp),
                  style: AppStyles.regular10poppins.copyWith(color: AppColors.textColorSecondary),
                ),
            ],
          ),
        ),
        SizedBox(width: 8.w),
        _Avatar(isUser: true),
      ],
    );
  }
}

// ── Bot bubble (left side) ─────────────────────────────────────────────────────

class _BotBubble extends StatelessWidget {
  final ChatMessageItem message;
  final void Function(String value) onSuggestionTap;
  final VoidCallback onShowMore;

  const _BotBubble({
    required this.message,
    required this.onSuggestionTap,
    required this.onShowMore,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _Avatar(isUser: false),
        SizedBox(width: 8.w),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (message.text != null && message.text!.isNotEmpty)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    color: AppColors.containerColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16.r),
                      topRight: Radius.circular(16.r),
                      bottomLeft: Radius.circular(4.r),
                      bottomRight: Radius.circular(16.r),
                    ),
                    boxShadow: AppColors.elevationShadow,
                  ),
                  child: Text(
                    message.text!,
                    style: AppStyles.regular14poppins.copyWith(
                      color: AppColors.textColorPrimary,
                      height: 1.4,
                    ),
                  ),
                ),
              SizedBox(height: 4.h),
              Text(
                _formatTime(message.timestamp),
                style: AppStyles.regular10poppins.copyWith(color: AppColors.textColorSecondary),
              ),

              // Suggestions
              if (message.suggestions.isNotEmpty) ...[
                SizedBox(height: 8.h),
                Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  children: message.suggestions
                      .where((s) => s.label != null && s.value != null)
                      .map((s) => _SuggestionChip(
                    label: s.label!,
                    onTap: () => onSuggestionTap(s.value!),
                  ))
                      .toList(),
                ),
              ],

              // Results
              if (message.results.isNotEmpty) ...[
                SizedBox(height: 12.h),
                ...message.results.map((r) => Padding(
                  padding: EdgeInsets.only(bottom: 10.h),
                  // todo: the nav thingie idk whatever
                  child: _ResultCard(result: r,onTap: (){
                    if(context.mounted) {
                      if(r.resultType?.toLowerCase() == 'room'){
                        context.pushNamed(AppRouting.roomDetailsViewName,pathParameters:{
                          'roomId': r.id.toString(),
                          'propertyId': r.propertyId.toString(),
                        } );
                      }
                      else if(r.resultType?.toLowerCase() == 'property'){
                        context.pushNamed(AppRouting.apartmentDetailsViewName,pathParameters:{
                          'id': r.id.toString(),
                        } );
                      }
                    }
                  }),
                )),
                if (message.pagination?.hasMore == true)
                  Padding(
                    padding: EdgeInsets.only(top: 4.h),
                    child: TextButton(
                      onPressed: onShowMore,
                      child: Text(
                        'Show more results',
                        style: AppStyles.semiBold14poppins.copyWith(color: AppColors.primary),
                      ),
                    ),
                  ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

// ── Result (property) card ──────────────────────────────────────────────────────
class _ResultCard extends StatelessWidget {
  final Results result;
  final VoidCallback? onTap;

  const _ResultCard({required this.result, this.onTap});

  @override
  Widget build(BuildContext context) {
    final priceLabel = (result.priceText != null && result.priceText!.isNotEmpty)
        ? result.priceText!
        : (result.monthlyRent != null ? '${result.monthlyRent} EGP/mo' : null);

    final chips = <String>[...?result.details, ...?result.amenities];
    final score = result.recommendationScore;
    final hasScore = score != null;
    final scoreColor = score != null
        ? (score >= 75
        ? const Color(0xFF22C55E)
        : score >= 50
        ? const Color(0xFFF59E0B)
        : const Color(0xFFEF4444))
        : null;

    return GestureDetector(
      onTap: (){
        if(context.mounted) {
          if(result.resultType?.toLowerCase() == 'room'){
            context.pushNamed(AppRouting.roomDetailsViewName,pathParameters:{
              'roomId': result.id.toString(),
              'propertyId': result.propertyId.toString(),
            } );
          }
          else if(result.resultType?.toLowerCase() == 'property'){
            context.pushNamed(AppRouting.apartmentDetailsViewName,pathParameters:{
              'id': result.id.toString(),
            } );
          }
        }
      },
      // onTap: onTap,
      child: Container(
        width: 230.w,
        decoration: BoxDecoration(
          color: AppColors.containerColor,
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(color: AppColors.stroke),
          boxShadow: AppColors.elevationShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── Header ───────────────────────────────────────────
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 11.h),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary,
                    AppColors.primary.withOpacity(0.80),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18.r),
                  topRight: Radius.circular(18.r),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(7.r),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.18),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Icon(
                      _iconForType(result.resultType),
                      size: 15.r,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          result.title ?? 'Untitled',
                          style: AppStyles.semiBold14poppins.copyWith(
                            color: Colors.white,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (result.subtitle != null &&
                            result.subtitle!.isNotEmpty)
                          Text(
                            result.subtitle!,
                            style: AppStyles.regular12poppins.copyWith(
                              color: Colors.white.withOpacity(0.80),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                      ],
                    ),
                  ),
                  // Type badge
                  if (result.resultType != null) ...[
                    SizedBox(width: 6.w),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 7.w, vertical: 3.h),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.18),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Text(
                        result.resultType!.toUpperCase(),
                        style: AppStyles.regular10poppins.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // ── Body ─────────────────────────────────────────────
            Padding(
              padding: EdgeInsets.all(12.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Score + deposit row
                  if (hasScore || result.deposit != null) ...[
                    Row(
                      children: [
                        if (hasScore) ...[
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              color: scoreColor!.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(8.r),
                              border: Border.all(
                                  color: scoreColor.withOpacity(0.35)),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.star_rounded,
                                    size: 11.r, color: scoreColor),
                                SizedBox(width: 3.w),
                                Text(
                                  '$score% match',
                                  style: AppStyles.regular10poppins.copyWith(
                                    color: scoreColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                        ],
                        if (result.deposit != null)
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.shield_outlined,
                                  size: 11.r,
                                  color: AppColors.textColorSecondary),
                              SizedBox(width: 3.w),
                              Text(
                                'Dep. ${result.deposit} EGP',
                                style: AppStyles.regular10poppins.copyWith(
                                  color: AppColors.textColorSecondary,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                  ],

                  // Location
                  if (result.location != null &&
                      result.location!.isNotEmpty) ...[
                    Row(
                      children: [
                        Icon(Icons.location_on_rounded,
                            size: 12.r, color: AppColors.primary),
                        SizedBox(width: 3.w),
                        Expanded(
                          child: Text(
                            result.location!,
                            style: AppStyles.regular12poppins.copyWith(
                              color: AppColors.textColorSecondary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                  ],

                  // Chips
                  if (chips.isNotEmpty) ...[
                    Wrap(
                      spacing: 5.w,
                      runSpacing: 5.h,
                      children: chips
                          .take(4)
                          .map(
                            (c) => Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 7.w, vertical: 3.h),
                          decoration: BoxDecoration(
                            color: AppColors.blueGrey,
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: Text(
                            c,
                            style: AppStyles.regular10poppins.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      )
                          .toList(),
                    ),
                    SizedBox(height: 8.h),
                  ],

                  // Price + button
                  Divider(height: 1, color: AppColors.stroke),
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (priceLabel != null)
                              Text(
                                priceLabel,
                                style: AppStyles.bold14poppins.copyWith(
                                  color: AppColors.primary,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              )
                            else
                              Text(
                                'Price N/A',
                                style: AppStyles.regular12poppins.copyWith(
                                  color: AppColors.textColorSecondary,
                                ),
                              ),
                          ],
                        ),
                      ),
                      SizedBox(width: 8.w),
                      CustomElevatedButton(
                        text: 'View',
                        onPressed: onTap,
                        borderRadius: 10.r,
                        horizontalPadding: 14.r,
                        verticalPadding: 6.r,
                        textStyle: AppStyles.semiBold12poppins,
                        icon: Icon(
                          Icons.arrow_forward_rounded,
                          size: 13.r,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _iconForType(String? type) {
    switch ((type ?? '').toLowerCase()) {
      case 'room':
        return Icons.bed_outlined;
      case 'apartment':
        return Icons.apartment_rounded;
      default:
        return Icons.home_outlined;
    }
  }
}
// ── Typing indicator ────────────────────────────────────────────────────────────

class _TypingIndicator extends StatefulWidget {
  const _TypingIndicator();

  @override
  State<_TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<_TypingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _Avatar(isUser: false),
        SizedBox(width: 8.w),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          decoration: BoxDecoration(
            color: AppColors.containerColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.r),
              topRight: Radius.circular(16.r),
              bottomLeft: Radius.circular(4.r),
              bottomRight: Radius.circular(16.r),
            ),
            boxShadow: AppColors.elevationShadow,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(3, (i) {
              return AnimatedBuilder(
                animation: _controller,
                builder: (context, _) {
                  final t = ((_controller.value - (i * 0.2)) % 1.0).clamp(0.0, 1.0);
                  final opacity = (0.3 + 0.7 * (1 - (t - 0.5).abs() * 2)).clamp(0.3, 1.0);
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.w),
                    child: Opacity(
                      opacity: opacity,
                      child: Container(
                        width: 6.r,
                        height: 6.r,
                        decoration: BoxDecoration(
                          color: AppColors.textColorSecondary,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ),
      ],
    );
  }
}

// ── Avatar ────────────────────────────────────────────────────────────────────

class _Avatar extends StatelessWidget {
  final bool isUser;

  const _Avatar({required this.isUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30.r,
      height: 30.r,
      decoration: BoxDecoration(
        color: isUser ? AppColors.blueGrey : AppColors.primary,
        shape: BoxShape.circle,
      ),
      child: Icon(
        isUser ? Icons.person : Icons.smart_toy_outlined,
        size: 16.r,
        color: isUser ? AppColors.primary : AppColors.textColorWhite,
      ),
    );
  }
}

// ── Input bar (text only — no attachments/voice) ───────────────────────────────

class _ChatInputBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueNotifier<bool> isTextEmpty;
  final VoidCallback onSend;
  final bool keyboardOpen;
  final double bottomSafeArea;

  const _ChatInputBar({
    required this.controller,
    required this.isTextEmpty,
    required this.onSend,
    required this.keyboardOpen,
    required this.bottomSafeArea,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
        top: 12.h,
        bottom: keyboardOpen ? 12.h : (12.h + bottomSafeArea),
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.fieldFillColor)),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: (val) => isTextEmpty.value = val.trim().isEmpty,
              minLines: 1,
              maxLines: 4,
              textCapitalization: TextCapitalization.sentences,
              style: AppStyles.regular14poppins.copyWith(color: AppColors.textColorPrimary),
              decoration: InputDecoration(
                hintText: 'Type your message...',
                hintStyle: AppStyles.regular14poppins.copyWith(color: AppColors.textColorSecondary),
                filled: true,
                fillColor: AppColors.fieldFillColor,
                contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(999),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          SizedBox(width: 10.w),
          ValueListenableBuilder<bool>(
            valueListenable: isTextEmpty,
            builder: (context, empty, _) {
              return GestureDetector(
                onTap: empty ? null : onSend,
                child: CircleAvatar(
                  backgroundColor: empty
                      ? AppColors.primary.withOpacity(0.4)
                      : AppColors.primary,
                  radius: 22.r,
                  child: Icon(Icons.send_rounded, color: Colors.white, size: 20.sp),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// ── Helpers ───────────────────────────────────────────────────────────────────

String _formatTime(DateTime date) {
  final hour24 = date.hour;
  final hour12 = hour24 % 12 == 0 ? 12 : hour24 % 12;
  final minute = date.minute.toString().padLeft(2, '0');
  final period = hour24 >= 12 ? 'PM' : 'AM';
  return '$hour12:$minute $period';
}