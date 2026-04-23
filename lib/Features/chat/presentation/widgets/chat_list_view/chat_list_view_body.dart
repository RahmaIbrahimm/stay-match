import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stay_match/Features/chat/presentation/manager/chat_cubit.dart';
import 'package:stay_match/Features/chat/presentation/widgets/chat_list_view/chat_helper.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_strings.dart';
import 'package:stay_match/core/constants/app_styles.dart';
import 'package:stay_match/core/routing/app_routing.dart';
import 'package:stay_match/core/widgets/custom_text_form_field.dart';

class ChatListViewBody extends StatelessWidget {
  const ChatListViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        if (state is ChatLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ChatSuccess) {
          final chats = state.response.data ?? [];

          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(16.r),
                  child: CustomTextFormField(
                    hintStyle: AppStyles.regular14manrope.copyWith(
                      color: AppColors.textColorSecondary,
                    ),
                    verticalPadding: 12,
                    hintText: AppStrings.searchConvo,
                    validator: (s) {},
                    controller: TextEditingController(),
                    hasShadow: false,
                    stroke: false,
                    fillColor: Color(0xFFF1F5F9),
                    prefixIcon: Icon(
                      Icons.search,
                      size: 20.sp,
                      color: AppColors.textColorSecondary,
                    ),
                  ),
                ),
              ),

              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final chat = chats[index];
                  return Column(
                    children: [
                      ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(25.r),
                          child: CachedNetworkImage(
                            width: 50.r,
                            height: 50.r,
                            fit: BoxFit.cover,
                            imageUrl: chat.otherUserProfileImageUrl ?? '',
                            placeholder: (context, url) =>
                                ChatHelper.buildPlaceholder(
                                  chat.otherUserFullName ?? '',
                                ),
                            errorWidget: (context, url, error) =>
                                ChatHelper.buildPlaceholder(
                                  chat.otherUserFullName ?? '',
                                ),
                          ),
                        ),
                        title: Text(
                          chat.otherUserFullName ?? AppStrings.na,
                          style: AppStyles.semiBold16manrope.copyWith(
                            color: AppColors.textColorPrimary,
                          ),
                        ),
                        subtitle: Text(
                          chat.lastMessage ?? AppStrings.na,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppStyles.medium14manrope.copyWith(
                            color: AppColors.textColorSecondary,
                          ),
                        ),
                        trailing: _buildTrailing(chat),
                        onTap: () {
                          context.pushNamed(
                            AppRouting.messagesName,
                            pathParameters: {
                              'id': chats[index].chatId.toString(),
                            },
                          );
                        },
                      ),
                      if (index != chats.length - 1)
                        Divider(
                          height: 1,
                          indent: 70.w,
                          endIndent: 16.w,
                          color: Colors.grey[200],
                        ),
                    ],
                  );
                }, childCount: chats.length),
              ),
            ],
          );
        }

        if (state is ChatFailure) {
          return Center(child: Text(state.errMessage));
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildTrailing(dynamic chat) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          chat.lastMessageTime != null
              ? ChatHelper.formatChatTime(chat.lastMessageTime)
              : "",
          style: AppStyles.regular12manrope.copyWith(
            color: AppColors.textColorSecondary,
          ),
        ),
        SizedBox(height: 5.h),
        if ((chat.unreadCount ?? 0) > 0)
          Container(
            padding: EdgeInsets.all(6.r),
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: Text(
              "${chat.unreadCount}",
              style: AppStyles.bold10manrope.copyWith(
                color: AppColors.textColorWhite,
              ),
            ),
          ),
      ],
    );
  }
}