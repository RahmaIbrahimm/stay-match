import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_strings.dart';
import 'package:stay_match/core/constants/app_styles.dart';
import 'package:stay_match/core/widgets/custom_elevated_button.dart';
import 'package:stay_match/core/widgets/custom_text_form_field.dart';

import '../../manager/chat_list_cubit.dart';
import 'chat_tile.dart';

class ChatListBody extends StatelessWidget {
  ChatListBody({super.key});

  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatListCubit, ChatListState>(
      builder: (context, state) {
        if (state is ChatLoading) {
          return const Center(
              child: CircularProgressIndicator(color: AppColors.primary,));
        }

        if (state is ChatSuccess) {
          final List<dynamic> chats = state.isSearchMode
              ? (state.searchResponse?.data ?? [])
              : (state.response?.data ?? []);

          void onSearchChanged(String query) {
            if (_debounce?.isActive ?? false) _debounce?.cancel();
            _debounce = Timer(const Duration(milliseconds: 500), () {
              context.read<ChatListCubit>().getInbox(query: query);
            });
          }

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: AppColors.containerColor,
                title: Text(
                  AppStrings.chats,
                  style: AppStyles.bold24poppins.copyWith(color: AppColors.textColorPrimary),
                ),
                centerTitle: true,
                pinned: true,
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    RPadding(
                      padding: EdgeInsets.symmetric(horizontal: 16.r),
                      child: CustomTextFormField(
                        controller: _searchController,
                        hintText: AppStrings.searchConvo,
                        validator: (val) => null,
                        hasShadow: false,
                        prefixIcon: const Icon(Icons.search, color: AppColors.textColorSecondary),
                        onChanged: onSearchChanged,
                        fillColor: AppColors.fieldFillColor,
                        stroke: false,
                        borderRadius: 12,
                        hintStyle: AppStyles.regular14poppins.copyWith(color: AppColors.textColorSecondary),
                      ),
                    ),

                    // 🌟 Smooth WhatsApp Inline Loader:
                    if (state.isSearching)
                      Padding(
                        padding: EdgeInsets.only(top: 8.h),
                        child: const LinearProgressIndicator(
                          backgroundColor: Colors.transparent,
                          color: AppColors.primary,
                        ),
                      )
                    else
                      SizedBox(height: 8.h),
                  ],
                ),
              ),

              // Keep your exact same Chat list / Empty dynamic rendering state blocks underneath
              if (chats.isNotEmpty)
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
              if (chats.isEmpty)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _searchController.text.isEmpty
                              ? Icons.chat_bubble_outline_rounded
                              : Icons.search_off_rounded,
                          size: 80.r,
                          color: AppColors.textColorSecondary.withOpacity(0.4),
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          _searchController.text.isEmpty ? "No Conversations Yet" : "No Results Found",
                          style: AppStyles.bold18poppins.copyWith(color: AppColors.textColorPrimary),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          _searchController.text.isEmpty
                              ? "Start a chat with your matches to see them here."
                              : "We couldn't find any chats matching '${_searchController.text}'.",
                          textAlign: TextAlign.center,
                          style: AppStyles.regular14poppins.copyWith(color: AppColors.textColorSecondary),
                        ),
                        if (_searchController.text.isNotEmpty) ...[
                          SizedBox(height: 32.h),
                          SizedBox(
                            width: double.infinity,
                            height: 50.h,
                            child: CustomElevatedButton(
                              text: "Clear Search Results",
                              onPressed: () {
                                _searchController.clear();
                                context.read<ChatListCubit>().getInbox();
                              },
                              textStyle: AppStyles.semiBold16manrope,
                              textColor: Colors.white,
                              borderRadius: 12,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                )
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