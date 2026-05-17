import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_styles.dart';
import 'package:stay_match/core/routing/app_routing.dart';

import '../../../data/models/my_chats.dart';
import '../shared/chat_helper.dart';

class ChatTile extends StatelessWidget {
  final dynamic chatData;
  const ChatTile({super.key, required this.chatData});

  @override
  Widget build(BuildContext context) {
    final String fullName = chatData.otherUserFullName ?? "User";
    final String? imageUrl = chatData.otherUserProfileImageUrl;

    return ListTile(
      onTap: () {
        //todo: Navigate to actual chat room using chatData.chatId
        if(context.mounted) context.pushNamed(AppRouting.messagesName,pathParameters: {'otherUserId':chatData.otherUserId ?? '-1'});
      },
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      leading: Stack(
        children: [
          SizedBox(
            width: 48.r,
            height: 48.r,
            child: ClipOval(
              child: (imageUrl == null || imageUrl.isEmpty)
                  ? ChatHelper.buildPlaceholder(fullName)
                  : CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => ChatHelper.buildPlaceholder(fullName),
                errorWidget: (context, url, error) => ChatHelper.buildPlaceholder(fullName),
              ),
            ),
          ),
        ],
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            fullName,
            style: AppStyles.semiBold16manrope
          ),
          Text(
            ChatHelper.formatChatTime(chatData.lastMessageTime),
            style: AppStyles.regular12manrope,
          ),
        ],
      ),
      subtitle: Padding(
        padding: EdgeInsets.only(top: 4.h),
        child: Row(
          children: [
            Expanded(
              child: Text(
                chatData.lastMessage ?? "No messages",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style:(chatData.unreadCount ?? 0) > 0? AppStyles.semiBold14manrope:AppStyles.regular14manrope,
              ),
            ),
            if ((chatData.unreadCount ?? 0) > 0)
              Container(
                margin: EdgeInsets.only(left: 8.w),
                padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Text(
                  '${chatData.unreadCount}',
                  style: AppStyles.bold10manrope.copyWith(color: Colors.white),
                ),
              ),
          ],
        ),
      ),
    );
  }
}