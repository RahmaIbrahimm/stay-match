// // import 'dart:developer';
// // import 'dart:io';
// //
// // import 'package:cached_network_image/cached_network_image.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';
// // import 'package:stay_match/Features/chat/presentation/manager/message_cubit.dart';
// // import 'package:stay_match/core/constants/app_styles.dart';
// // import 'package:stay_match/core/networking/endpoints.dart';
// // import 'package:stay_match/core/utils/secure_storage_helper.dart';
// // import 'package:stay_match/core/utils/secure_storage_keys.dart';
// // import 'package:stay_match/core/utils/service_locator.dart';
// // import 'package:url_launcher/url_launcher.dart';
// //
// // import '../../../../../core/constants/app_colors.dart';
// // import '../../../data/models/start_chat_response.dart';
// // import '../chat_list_view/chat_helper.dart';
// // import 'chat_bubble.dart';
// //
// // class MessagesViewBody extends StatefulWidget {
// //   const MessagesViewBody({super.key});
// //
// //   @override
// //   State<MessagesViewBody> createState() => _MessagesViewBodyState();
// // }
// //
// // class _MessagesViewBodyState extends State<MessagesViewBody> {
// //   late String? myId;
// //
// //   @override
// //   void initState() {
// //     // TODO: implement initState
// //     super.initState();
// //     getIt.get<SecureStorageHelper>()
// //         .readFromSecureStorage(key: SecureStorageKeys.userIdKey)
// //         .then((value) {
// //       setState(() {
// //         myId = value;
// //       });
// //     });
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return BlocBuilder<MessageCubit, MessageState>(
// //       builder: (context, state) {
// //         if (state is MessageSuccess) {
// //           final chatId = state.chatId;
// //           final otherUserName = state.otherUserName;
// //           final messages = state.messages;
// //           final profilePic = state.otherUserProfile;
// //
// //           log('my id is : $myId');
// //           return CustomScrollView(
// //             slivers: [
// //               SliverAppBar(
// //                 pinned: true,
// //                 backgroundColor: AppColors.containerColor,
// //                 title: Row(
// //                   spacing: 12,
// //                   children: [
// //                     // Container(
// //                     //   height: 35.r,
// //                     //   width: 35.r,
// //                     //   decoration: BoxDecoration(
// //                     //     shape: BoxShape.circle,
// //                     //     color: AppColors.containerColor,
// //                     //     border: Border.all(
// //                     //       color: AppColors.primary.withValues(alpha: 0.05),
// //                     //       width: 2.r,
// //                     //     ),
// //                     //     image: (profilePic != null && profilePic.isNotEmpty)
// //                     //         ? DecorationImage(
// //                     //       fit: BoxFit.cover,
// //                     //       image: CachedNetworkImageProvider(profilePic),
// //                     //     )
// //                     //         : null,
// //                     //   ),
// //                     //   child: (profilePic == null || profilePic.isEmpty)
// //                     //       ? Icon(
// //                     //     Icons.person,
// //                     //     size: 30.sp,
// //                     //     color: AppColors.textColorSecondary.withValues(
// //                     //         alpha: 0.7),
// //                     //   )
// //                     //       : null,
// //                     // ),
// //                     SizedBox(
// //                       width: 35.r,
// //                       height: 35.r,
// //                       child: ClipOval(
// //                         child: (profilePic == null || profilePic.isEmpty)
// //                             ? ChatHelper.buildPlaceholder(
// //                             otherUserName ?? 'Guest User', fontSize: 14)
// //                             : CachedNetworkImage(
// //                           imageUrl: otherUserName ?? '',
// //                           fit: BoxFit.cover,
// //                           placeholder: (context, url) =>
// //                               ChatHelper.buildPlaceholder(
// //                                   otherUserName ?? 'Guest User', fontSize: 14),
// //                           errorWidget: (context, url, error) =>
// //                               ChatHelper.buildPlaceholder(
// //                                   otherUserName ?? 'Guest User', fontSize: 14),
// //                         ),
// //                       ),
// //                     ),
// //
// //                     Text(otherUserName ?? 'User Name',
// //                       style: AppStyles.semiBold14poppins,),
// //                   ],
// //                 ),
// //               ),
// //               SliverToBoxAdapter(child: Divider(color: AppColors.stroke)),
// //               SliverList(
// //                   delegate: SliverChildBuilderDelegate(
// //                           (context, index) =>
// //                           ChatBubble(message: messages[index],
// //                               isMe: messages[index].senderId == myId,
// //                               imageUrl: profilePic,
// //                               fullName: otherUserName),
// //                       childCount: messages.length)),
// //
// //             ],
// //           );
// //         }
// //         return SizedBox.shrink();
// //       },
// //     );
// //   }
// // }
// import 'dart:developer';
// import 'dart:io';
//
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:stay_match/Features/chat/presentation/manager/message_cubit.dart';
// import 'package:stay_match/core/constants/app_styles.dart';
// import 'package:stay_match/core/networking/endpoints.dart';
// import 'package:stay_match/core/utils/secure_storage_helper.dart';
// import 'package:stay_match/core/utils/secure_storage_keys.dart';
// import 'package:stay_match/core/utils/service_locator.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// import '../../../../../core/constants/app_colors.dart';
// import '../../../data/models/start_chat_response.dart';
// import '../shared/chat_helper.dart';
// import 'chat_bubble.dart';
//
// class MessagesViewBody extends StatefulWidget {
//   const MessagesViewBody({super.key});
//
//   @override
//   State<MessagesViewBody> createState() => _MessagesViewBodyState();
// }
//
// class _MessagesViewBodyState extends State<MessagesViewBody> {
//   String? myId;
//   final ScrollController _scrollController = ScrollController();
//
//   @override
//   void initState() {
//     super.initState();
//     _loadUserId();
//   }
//
//   Future<void> _loadUserId() async {
//     final value = await getIt.get<SecureStorageHelper>()
//         .readFromSecureStorage(key: SecureStorageKeys.userIdKey);
//     setState(() {
//       myId = value;
//     });
//   }
//
//   void _scrollToBottom() {
//     if (_scrollController.hasClients) {
//       _scrollController.animateTo(
//         _scrollController.position.maxScrollExtent,
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeOut,
//       );
//     }
//   }
//
//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<MessageCubit, MessageState>(
//       listener: (context, state) {
//         if (state is MessageSuccess) {
//           WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
//         }
//       },
//       builder: (context, state) {
//         if (state is MessageSuccess) {
//           final chatId = state.chatId;
//           final otherUserName = state.otherUserName;
//           final messages = state.messages;
//           final profilePic = state.otherUserProfile;
//
//           return Column(
//             children: [
//               Expanded(
//                 child: CustomScrollView(
//                   controller: _scrollController,
//                   slivers: [
//                     SliverAppBar(
//                       pinned: true,
//                       elevation: 0.5,
//                       backgroundColor: AppColors.containerColor,
//                       title: Row(
//                         children: [
//                           _buildHeaderAvatar(profilePic, otherUserName),
//                           SizedBox(width: 12.w),
//                           Text(otherUserName ?? 'User', style: AppStyles.semiBold14poppins),
//                         ],
//                       ),
//                     ),
//                     SliverPadding(
//                       padding: EdgeInsets.symmetric(vertical: 10.h),
//                       sliver: SliverList(
//                         delegate: SliverChildBuilderDelegate(
//                               (context, index) => ChatBubble(
//                             message: messages[index],
//                             isMe: messages[index].senderId == myId,
//                             imageUrl: profilePic,
//                             fullName: otherUserName,
//                           ),
//                           childCount: messages.length,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           );
//         }
//         return const Center(child: CircularProgressIndicator());
//       },
//     );
//   }
//
//   Widget _buildHeaderAvatar(String? url, String? name) {
//     return SizedBox(
//       width: 35.r,
//       height: 35.r,
//       child: ClipOval(
//         child: (url == null || url.isEmpty)
//             ? ChatHelper.buildPlaceholder(name ?? '?', fontSize: 14)
//             : CachedNetworkImage(
//           imageUrl: url,
//           fit: BoxFit.cover,
//           placeholder: (context, url) => ChatHelper.buildPlaceholder(name ?? '?', fontSize: 14),
//           errorWidget: (context, url, error) => ChatHelper.buildPlaceholder(name ?? '?', fontSize: 14),
//         ),
//       ),
//     );
//   }
// }

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart'; // Ensure this is in pubspec
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

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    final value = await getIt.get<SecureStorageHelper>()
        .readFromSecureStorage(key: SecureStorageKeys.userIdKey);
    setState(() {
      myId = value;
    });
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
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
      listener: (context, state) {
        if (state is MessageSuccess) {
          WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
        }
      },
      builder: (context, state) {
        if (state is MessageSuccess) {
          final otherUserName = state.otherUserName;
          final profilePic = state.otherUserProfile;

          // Use your ChatHelper to group the messages
          final groupedMessages = ChatHelper.groupMessagesByDate(
              state.messages);
          final dateKeys = groupedMessages.keys.toList();

          return CustomScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            slivers: [
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
              SliverToBoxAdapter(child: Divider(color: AppColors.stroke,),),
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
                          return ChatBubble(
                            key: ValueKey(message.id),
                            message: message,
                            isMe: message.senderId == myId,
                            imageUrl: profilePic,
                            fullName: otherUserName,
                          );
                        },
                        childCount: messages.length,
                        // findChildIndexCallback: (Key key) {
                        //   final ValueKey valueKey = key as ValueKey;
                        //   final String id = valueKey.value;
                        //   final int index = messages.indexWhere((m) =>
                        //   m.id == id);
                        //   return index >= 0 ? index : null;
                        // },
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

              // Bottom padding so the last message isn't hidden by the input bar
              SliverToBoxAdapter(child: SizedBox(height: 20.h)),
            ],
          );
        }
        if (state is MessageFailure) {
          return GlobalErrorWidget(onReturnHome: () {
            context.goNamed(AppRouting.chatListName);
          }, onTryAgain: () {
            BlocProvider.of<MessageCubit>(context).startChat(
                otherUserId: BlocProvider
                    .of<MessageCubit>(context)
                    .otherUserId);
          });
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
          placeholder: (context, url) => ChatHelper.buildPlaceholder(name ?? '?', fontSize: 14),
          errorWidget: (context, url, error) => ChatHelper.buildPlaceholder(name ?? '?', fontSize: 14),
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