import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_strings.dart';
import 'package:stay_match/core/constants/app_styles.dart';
import 'package:stay_match/core/widgets/custom_text_form_field.dart';
import 'package:stay_match/core/widgets/menu_icon_button.dart';

import '../../manager/chat_list_cubit.dart';
import 'chat_tile.dart';

class ChatListBody extends StatelessWidget {
  const ChatListBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatListCubit, ChatListState>(
      builder: (context, state) {
        if (state is ChatlLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ChatSuccess) {
          // Accessing your data list from the full response you wanted to keep
          final chats = state.response.data ?? [];
          final chatCubit = BlocProvider.of<ChatListCubit>(context);
          if (chats.isEmpty) {
            return const Center(child: Text("No conversations yet."));
          }

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: AppColors.containerColor,
                title: Text(
                  AppStrings.chats,
                  style: AppStyles.bold24poppins.copyWith(
                    color: AppColors.textColorPrimary,
                  ),
                ),
                centerTitle: true,
                pinned: true,
                // todo : Implement menu button
                leading: MenuIconButton(),
              ),
              SliverToBoxAdapter(
                child: RPadding(
                  padding: EdgeInsets.symmetric(horizontal: 16.r),
                  child: CustomTextFormField(
                    hintText: AppStrings.searchConvo,
                    validator: (val) => null,
                    hasShadow: false,
                    prefixIcon: Icon(
                      Icons.search,
                      color: AppColors.textColorSecondary,
                    ),
                    fillColor: AppColors.fieldFillColor,
                    stroke: false,
                    borderRadius: 12,
                    hintStyle: AppStyles.regular14poppins.copyWith(color: AppColors.textColorSecondary),
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(vertical: 8.r),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      final chat = chats[index];
                      return Column(
                        key: ValueKey(chat.otherUserId),
                        children: [
                          ChatTile(chatData: chat),
                          if (index != chats.length - 1)
                            const Divider(height: 1, indent: 85, color: AppColors.stroke),
                        ],
                      );
                    },
                    childCount: chats.length,
                  ),
                ),
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
}