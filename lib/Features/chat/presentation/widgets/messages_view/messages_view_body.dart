import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:go_router/go_router.dart';
import 'package:stay_match/Features/chat/presentation/manager/message_cubit.dart';
import 'package:stay_match/core/constants/app_styles.dart';
import 'package:stay_match/core/routing/app_routing.dart';
import 'package:stay_match/core/utils/secure_storage_helper.dart';
import 'package:stay_match/core/utils/secure_storage_keys.dart';
import 'package:stay_match/core/utils/service_locator.dart';
import 'package:stay_match/core/widgets/global_error_widget.dart';

import '../../../../../core/constants/app_colors.dart';
import '../shared/chat_helper.dart';
import 'chat_bubble.dart';

class MessagesViewBody extends StatefulWidget {
  const MessagesViewBody({super.key});

  @override
  State<MessagesViewBody> createState() => _MessagesViewBodyState();
}

class _MessagesViewBodyState extends State<MessagesViewBody> {
  String? myId;
  final ScrollController _scrollController = ScrollController();

  // Track message count to only trigger scroll when actual new items arrive
  int _previousMessageCount = 0;

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    final value = await getIt
        .get<SecureStorageHelper>()
        .readFromSecureStorage(key: SecureStorageKeys.userIdKey);
    setState(() {
      myId = value;
    });
    if (mounted) {
      context.read<MessageCubit>().myUserId = value;
    }
  }

  void _jumpToBottom() {
    if (_scrollController.hasClients) {
      // jumpTo eliminates the animated fighting/bouncing that caused the stuttering
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MessageCubit, MessageState>(
      listenWhen: (previous, current) {
        if (previous is MessageSuccess && current is MessageSuccess) {
          // Only trigger listener if a new message was actually appended
          return current.messages.length != previous.messages.length;
        }
        return current is MessageSuccess;
      },
      listener: (context, state) {
        if (state is MessageSuccess) {
          // Schedule a clean jump to the bottom position after the frame maps out
          WidgetsBinding.instance.addPostFrameCallback((_) => _jumpToBottom());
        }
      },
      builder: (context, state) {
        if (state is MessageSuccess) {
          final otherUserName = state.otherUserName;
          final profilePic = state.otherUserProfile;

          final groupedMessages = ChatHelper.groupMessagesByDate(state.messages);
          final dateKeys = groupedMessages.keys.toList();

          // Initial check: if this is our first successful fetch, jump down immediately
          if (_previousMessageCount == 0 && state.messages.isNotEmpty) {
            _previousMessageCount = state.messages.length;
            WidgetsBinding.instance.addPostFrameCallback((_) => _jumpToBottom());
          } else {
            _previousMessageCount = state.messages.length;
          }

          return CustomScrollView(

            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            slivers: [
              // ── Header Toolbar ─────────────────────────────────────────────
              SliverAppBar(
                pinned: true,
                elevation: 0.5,
                backgroundColor: AppColors.containerColor,
                title: Row(
                  children: [
                    _buildHeaderAvatar(profilePic, otherUserName),
                    SizedBox(width: 12.w),
                    Text(otherUserName ?? 'User',
                        style: AppStyles.semiBold14poppins),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: Divider(color: AppColors.stroke),
              ),

              // ── Scrollable Chat Content ────────────────────────────────────
              ...dateKeys.map((date) {
                final messages = groupedMessages[date]!;
                return SliverStickyHeader(
                  header: _buildDateHeader(date),
                  sliver: SliverPadding(
                    padding: EdgeInsets.symmetric(vertical: 4.h),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                            (context, index) {
                          final message = messages[index];
                          final isMe = message.senderId == myId;

                          final bool isPending = isMe &&
                              message.id == -1 &&
                              !state.failedMessageIds.contains(message.content ?? 'file');
                          final bool isFailed = isMe &&
                              state.failedMessageIds.contains(message.content ?? 'file');

                          return ChatBubble(
                            key: ValueKey(message.id),
                            message: message,
                            isMe: isMe,
                            imageUrl: profilePic,
                            fullName: otherUserName,
                            isPending: isPending,
                            isFailed: isFailed,
                          );
                        },
                        childCount: messages.length,
                        findChildIndexCallback: (Key key) {
                          if (key is ValueKey<int>) {
                            final int id = key.value;
                            final int index = messages.indexWhere((m) => m.id == id);
                            return index >= 0 ? index : null;
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                );
              }),
              SliverToBoxAdapter(child: SizedBox(height: 20.h)),
            ],
          );
        }

        if (state is MessageFailure) {
          return GlobalErrorWidget(
            onReturnHome: () {
              context.goNamed(AppRouting.chatListName);
            },
            onTryAgain: () {
              BlocProvider.of<MessageCubit>(context).startChat(
                otherUserId: BlocProvider.of<MessageCubit>(context).otherUserId,
              );
            },
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildHeaderAvatar(String? url, String? name) {
    return SizedBox(
      width: 35.r,
      height: 35.r,
      child: ClipOval(
        child: (url == null || url.isEmpty)
            ? ChatHelper.buildPlaceholder(name ?? '?', fontSize: 14)
            : CachedNetworkImage(
          imageUrl: url,
          fit: BoxFit.cover,
          placeholder: (context, url) =>
              ChatHelper.buildPlaceholder(name ?? '?', fontSize: 14),
          errorWidget: (context, url, error) =>
              ChatHelper.buildPlaceholder(name ?? '?', fontSize: 14),
        ),
      ),
    );
  }

  Widget _buildDateHeader(String text) {
    return Container(
      height: 45.h,
      alignment: Alignment.center,
      color: Colors.transparent,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(240),
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(20),
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 11.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF54656F),
          ),
        ),
      ),
    );
  }
}