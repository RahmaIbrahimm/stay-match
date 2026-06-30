// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../../../../../core/constants/app_colors.dart';
// import '../../../../../core/constants/app_styles.dart';
// import '../../../data/models/get_apartment_reviews.dart';
// import '../shared/reviews_helpers.dart';
// class ReviewCard extends StatelessWidget {
//   final Reviews review;
//
//   const ReviewCard({super.key, required this.review});
//
//   @override
//   Widget build(BuildContext context) {
//     final hasResponse =
//         review.hostResponse != null &&
//             review.hostResponse.toString().trim().isNotEmpty;
//
//     return Container(
//       margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
//       padding: EdgeInsets.all(16.r),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16.r),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withValues(alpha: 0.05),
//             blurRadius: 10,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // ── Reviewer row ──
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               CircleAvatar(
//                 radius: 22.r,
//                 backgroundImage: review.reviewerImage != null
//                     ? NetworkImage(review.reviewerImage!)
//                     : null,
//                 backgroundColor: RColors.divider,
//                 child: review.reviewerImage == null
//                     ? Icon(Icons.person, size: 20.r, color: RColors.textSecondary)
//                     : null,
//               ),
//               SizedBox(width: 12.w),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       review.reviewerName ?? 'Guest',
//                       style: AppStyles.bold14poppins.copyWith(
//                         color: RColors.textPrimary,
//                       ),
//                     ),
//                     SizedBox(height: 2.h),
//                     Text(
//                       _formatDate(review.createdAt),
//                       style: AppStyles.regular12poppins.copyWith(
//                         color: RColors.textSecondary,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               // ── Star ★ N.N  right-aligned, dark text ──
//               Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Icon(Icons.star_rounded, size: 16.r, color: RColors.textPrimary),
//                   SizedBox(width: 3.w),
//                   Text(
//                     review.rating?.toStringAsFixed(1) ?? '0.0',
//                     style: AppStyles.bold14poppins.copyWith(
//                       color: RColors.textPrimary,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           SizedBox(height: 12.h),
//
//           // ── Comment ──
//           Text(
//             review.comment ?? '',
//             style: AppStyles.regular14poppins.copyWith(
//               color: RColors.textPrimary,
//               height: 1.55,
//             ),
//           ),
//           SizedBox(height: 12.h),
//
//           // ── VERIFIED STAY — blue checkmark + blue text ──
//           Container(
//             padding: EdgeInsets.symmetric(horizontal: 8.r, vertical: 5.h),
//             decoration: BoxDecoration(
//               color: AppColors.primary.withValues(alpha: 0.1),
//               borderRadius: BorderRadius.circular(24.r),
//             ),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Icon(Icons.verified, size: 14.r, color: AppColors.primary),
//                 SizedBox(width: 5.w),
//                 Text(
//                   'VERIFIED STAY',
//                   style: AppStyles.bold10poppins.copyWith(
//                     color: AppColors.primary,
//                     letterSpacing: 0.6,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: 14.h),
//
//           // ── Helpful / Comment ──
//           // Row(
//           //   children: [
//           //     Icon(
//           //       Icons.thumb_up_alt_outlined,
//           //       size: 16.r,
//           //       color: RColors.textSecondary,
//           //     ),
//           //     SizedBox(width: 5.w),
//           //     Text(
//           //       'Helpful',
//           //       style: AppStyles.regular12poppins.copyWith(
//           //         color: RColors.textSecondary,
//           //       ),
//           //     ),
//           //     SizedBox(width: 20.w),
//           //     Icon(
//           //       Icons.chat_bubble_outline,
//           //       size: 16.r,
//           //       color: RColors.textSecondary,
//           //     ),
//           //     SizedBox(width: 5.w),
//           //     Text(
//           //       'Comment',
//           //       style: AppStyles.regular12poppins.copyWith(
//           //         color: RColors.textSecondary,
//           //       ),
//           //     ),
//           //   ],
//           // ),
//
//           // ── HOST RESPONSE — light blue bg, left indigo border, amber label ──
//           if (hasResponse) ...[
//             SizedBox(height: 14.h),
//             Container(
//               decoration: BoxDecoration(
//                 color: RColors.hostRespBg,
//                 borderRadius: BorderRadius.circular(10.r),
//                 border: Border(
//                   left: BorderSide(color: RColors.hostRespBorder, width: 3.w),
//                 ),
//               ),
//               padding: EdgeInsets.fromLTRB(12.w, 10.h, 12.w, 12.h),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Icon(
//                         Icons.reply_rounded,
//                         size: 14.r,
//                         color: RColors.hostRespLabel,
//                       ),
//                       SizedBox(width: 5.w),
//                       Text(
//                         'HOST RESPONSE',
//                         style: AppStyles.bold10poppins.copyWith(
//                           color: RColors.hostRespLabel,
//                           letterSpacing: 0.6,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 6.h),
//                   Text(
//                     '"${review.hostResponse}"',
//                     style: AppStyles.regular14poppins.copyWith(
//                       color: RColors.textPrimary,
//                       height: 1.5,
//                       fontStyle: FontStyle.italic,
//                     ),
//                   ),
//                   if (review.responseCreatedAt != null) ...[
//                     SizedBox(height: 4.h),
//                     Text(
//                       _formatDate(review.responseCreatedAt?.toString()),
//                       style: AppStyles.regular10poppins.copyWith(
//                         color: RColors.textSecondary,
//                       ),
//                     ),
//                   ],
//                 ],
//               ),
//             ),
//           ],
//         ],
//       ),
//     );
//   }
//
//   String _formatDate(String? iso) {
//     if (iso == null) return '';
//     try {
//       final dt = DateTime.parse(iso);
//       const m = [
//         'January',
//         'February',
//         'March',
//         'April',
//         'May',
//         'June',
//         'July',
//         'August',
//         'September',
//         'October',
//         'November',
//         'December',
//       ];
//       return '${m[dt.month - 1]} ${dt.year}';
//     } catch (_) {
//       return '';
//     }
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_styles.dart';
import '../../../data/models/get_apartment_reviews.dart';
import '../../manager/reviews_cubit.dart';
import '../shared/reviews_helpers.dart';

class ReviewCard extends StatefulWidget {
  final Reviews review;
  final bool isHost;

  const ReviewCard({
    super.key,
    required this.review,
    this.isHost = false,
  });

  @override
  State<ReviewCard> createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard> {
  late dynamic _hostResponse;
  late dynamic _responseCreatedAt;

  @override
  void initState() {
    super.initState();
    _hostResponse = widget.review.hostResponse;
    _responseCreatedAt = widget.review.responseCreatedAt;
  }

  bool get _hasResponse =>
      _hostResponse != null && _hostResponse.toString().trim().isNotEmpty;

  Future<void> _openReplyDialog() async {
    final controller = TextEditingController(
      text: _hasResponse ? _hostResponse.toString() : '',
    );
    final reviewId = widget.review.reviewId ?? 0;

    // Grab the cubit from the page-level context BEFORE opening the sheet
    final reviewsCubit = context.read<ReviewsCubit>();

    final result = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (sheetContext) {
        // Re-provide it inside the sheet's own tree
        return BlocProvider.value(
          value: reviewsCubit,
          child: Padding(
            padding: EdgeInsets.only(
              left: 16.w,
              right: 16.w,
              top: 16.h,
              bottom: MediaQuery.of(sheetContext).viewInsets.bottom + 16.h,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _hasResponse ? 'Edit Response' : 'Reply to Review',
                  style: AppStyles.bold16poppins.copyWith(
                    color: RColors.textPrimary,
                  ),
                ),
                SizedBox(height: 12.h),
                TextField(
                  controller: controller,
                  maxLines: 4,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Write your response...',
                    filled: true,
                    fillColor: RColors.pageBg,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.all(12.r),
                  ),
                ),
                SizedBox(height: 16.h),
                SizedBox(
                  width: double.infinity,
                  child: BlocConsumer<ReviewsCubit, ReviewsState>(
                    listenWhen: (_, s) =>
                    (s is HostReplySuccess && s.reviewId == reviewId) ||
                        (s is HostReplyFailure && s.reviewId == reviewId),
                    listener: (context, state) {
                      if (state is HostReplySuccess && state.reviewId == reviewId) {
                        Navigator.of(sheetContext).pop(state.response);
                      } else if (state is HostReplyFailure && state.reviewId == reviewId) {
                        ScaffoldMessenger.of(sheetContext).showSnackBar(
                          SnackBar(content: Text(state.errMessage)),
                        );
                      }
                    },
                    builder: (context, state) {
                      final isLoading =
                          state is HostReplyLoading && state.reviewId == reviewId;
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        onPressed: isLoading
                            ? null
                            : () {
                          final text = controller.text.trim();
                          if (text.isEmpty) return;
                          context.read<ReviewsCubit>().hostReply(
                            reviewId: reviewId,
                            response: text,
                          );
                        },
                        child: isLoading
                            ? SizedBox(
                          height: 18.r,
                          width: 18.r,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                            : Text(
                          'Send Reply',
                          style: AppStyles.semiBold14poppins.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    if (result != null && result.isNotEmpty) {
      setState(() {
        _hostResponse = result;
        _responseCreatedAt = DateTime.now().toIso8601String();
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Reviewer row ──
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 22.r,
                backgroundImage: widget.review.reviewerImage != null
                    ? NetworkImage(widget.review.reviewerImage!)
                    : null,
                backgroundColor: RColors.divider,
                child: widget.review.reviewerImage == null
                    ? Icon(Icons.person, size: 20.r, color: RColors.textSecondary)
                    : null,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.review.reviewerName ?? 'Guest',
                      style: AppStyles.bold14poppins.copyWith(
                        color: RColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      _formatDate(widget.review.createdAt),
                      style: AppStyles.regular12poppins.copyWith(
                        color: RColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.star_rounded, size: 16.r, color: RColors.textPrimary),
                  SizedBox(width: 3.w),
                  Text(
                    widget.review.rating?.toStringAsFixed(1) ?? '0.0',
                    style: AppStyles.bold14poppins.copyWith(
                      color: RColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // ── Comment ──
          Text(
            widget.review.comment ?? '',
            style: AppStyles.regular14poppins.copyWith(
              color: RColors.textPrimary,
              height: 1.55,
            ),
          ),
          SizedBox(height: 12.h),

          // ── VERIFIED STAY ──
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.r, vertical: 5.h),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(24.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.verified, size: 14.r, color: AppColors.primary),
                SizedBox(width: 5.w),
                Text(
                  'VERIFIED STAY',
                  style: AppStyles.bold10poppins.copyWith(
                    color: AppColors.primary,
                    letterSpacing: 0.6,
                  ),
                ),
              ],
            ),
          ),

          // ── HOST RESPONSE ──
          if (_hasResponse) ...[
            SizedBox(height: 14.h),
            Container(
              decoration: BoxDecoration(
                color: RColors.hostRespBg,
                borderRadius: BorderRadius.circular(10.r),
                border: Border(
                  left: BorderSide(color: RColors.hostRespBorder, width: 3.w),
                ),
              ),
              padding: EdgeInsets.fromLTRB(12.w, 10.h, 12.w, 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.reply_rounded,
                        size: 14.r,
                        color: RColors.hostRespLabel,
                      ),
                      SizedBox(width: 5.w),
                      Text(
                        'HOST RESPONSE',
                        style: AppStyles.bold10poppins.copyWith(
                          color: RColors.hostRespLabel,
                          letterSpacing: 0.6,
                        ),
                      ),
                      const Spacer(),
                      if (widget.isHost)
                        GestureDetector(
                          onTap: _openReplyDialog,
                          child: Icon(
                            Icons.edit_outlined,
                            size: 14.r,
                            color: RColors.hostRespLabel,
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    '"$_hostResponse"',
                    style: AppStyles.regular14poppins.copyWith(
                      color: RColors.textPrimary,
                      height: 1.5,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  if (_responseCreatedAt != null) ...[
                    SizedBox(height: 4.h),
                    Text(
                      _formatDate(_responseCreatedAt?.toString()),
                      style: AppStyles.regular10poppins.copyWith(
                        color: RColors.textSecondary,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ]
          // ── REPLY BUTTON (host only, no response yet) ──
          else if (widget.isHost) ...[
            SizedBox(height: 14.h),
            GestureDetector(
              onTap: _openReplyDialog,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(color: AppColors.primary),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.reply_rounded, size: 16.r, color: AppColors.primary),
                    SizedBox(width: 6.w),
                    Text(
                      'Reply to this review',
                      style: AppStyles.semiBold12poppins.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _formatDate(String? iso) {
    if (iso == null) return '';
    try {
      final dt = DateTime.parse(iso);
      const m = [
        'January', 'February', 'March', 'April', 'May', 'June',
        'July', 'August', 'September', 'October', 'November', 'December',
      ];
      return '${m[dt.month - 1]} ${dt.year}';
    } catch (_) {
      return '';
    }
  }
}