import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stay_match/Features/booking/data/model/host_requests_response.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_styles.dart';
import 'package:stay_match/core/widgets/custom_text_button.dart';

import '../../../../../core/routing/app_routing.dart';
import '../../../../../core/widgets/custom_elevated_button.dart';
import '../../manager/booking_request_cubit.dart';
import '../../manager/booking_request_state.dart';

class RequestCard extends StatelessWidget {
  final Requests request;

  const RequestCard({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: (){
                  context.pushNamed(AppRouting.otherUserProfileName,extra: request.renter?.id);
                },
                child: CircleAvatar(
                  radius: 32.r,
                  backgroundImage: CachedNetworkImageProvider(
                    request.renter?.profileImage ?? '',
                    errorListener: (e) {
                      Container(
                        color: Color(0xFFF1F4FF),
                        // Matches your dropdown/secondary background tint
                        child: Center(
                          child: Icon(
                            Icons.image_not_supported_outlined,
                            color: Colors.grey,
                            size: 28.sp,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      request.renter?.name ?? '',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.sp,
                        color: const Color(0xFF101828),
                      ),
                    ),
                    Text(
                      request.renter?.jobTitle ?? '',
                      style: TextStyle(
                        color: const Color(0xFF667085),
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF2E3791),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  request.status?.toUpperCase() ?? 'Unknown',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            "LIFE STYLE & HABITS",
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF98A2B3),
            ),
          ),
          SizedBox(height: 8.h),
          SizedBox(
            height: 28.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                // todo : from matching ai for profile
                var lst = ["Early Bird", "Social", "Non-smoker"];
                return Container(
                  // Use padding for breathing room around the text
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 4.h,
                  ),
                  // Remove fixed width/constraints to let it wrap content
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24.r),
                    color: AppColors.blue.withValues(alpha: 0.5),
                  ),
                  // Use Center to keep text aligned if the container height is taller than text
                  child: Center(
                    child: Text(
                      lst[index],
                      style: AppStyles.semiBold12poppins.copyWith(
                        color: AppColors.textColorPrimary,
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(width: 8.w);
              },
              itemCount: 3, //todo : use the length of your list
            ),
          ),
          SizedBox(height: 16.h),
          Container(
            width: double.infinity,
            constraints: BoxConstraints(minHeight: 100.h),
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: const Color(0xFFF9FAFB),
              borderRadius: BorderRadius.circular(16.r),
              border: Border(
                left: BorderSide(color: AppColors.blueGrey, width: 4.w),
              ),
            ),
            child: Text(
              (request.renter?.bio == null || request.renter!.bio!.isEmpty)
                  ? "\"No bio provided.\""
                  : "\"${request.renter!.bio!}\"",
              style: AppStyles.regular14poppins.copyWith(
                color: AppColors.textColorSecondary,
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: const Color(0xFFF9FAFB),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Row(
              children: [
                //todo: property image
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: CachedNetworkImage(
                    imageUrl: request.property?.coverImage ?? '',
                    fit: BoxFit.cover,
                    height: 70.h,
                    width: 70.h,
                    // Shown while the image is downloading
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                        strokeWidth: 2, // Keeps it clean and thin inside a card
                      ),
                    ),
                    // Shown if the URL is broken, empty, or fails to load
                    errorWidget: (context, url, error) => Container(
                      color: Color(0xFFF1F4FF),
                      // Matches your dropdown/secondary background tint
                      child: Center(
                        child: Icon(
                          Icons.image_not_supported_outlined,
                          color: Colors.grey,
                          size: 28.sp,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        request.property?.name ?? '',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                      ),
                      Text(
                        request.dateRange?.full ?? '',
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: const Color(0xFF667085),
                        ),
                      ),
                      Text(
                        request.totalPrice ?? '',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF2E3791),
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              if(request.status?.toLowerCase() == 'pending')...[
              Expanded(
                child: CustomElevatedButton(
                  text: "Decline",
                  // Make it look like an OutlinedButton
                  backgroundColor: AppColors.textColorError.withAlpha(30),
                  textColor: AppColors.textColorError,
                  textStyle: AppStyles.bold14manrope,
                  borderColor: AppColors.textColorError.withAlpha(10),
                  // Add the border
                  verticalPadding: 14.h,
                  borderRadius: 12.r,

                  // Handle the loading state specifically for this decline action
                  isLoading:
                      context.watch<BookingRequestCubit>().state
                          is BookingRequestLoading,
                  onPressed: () async {
                    await context.read<BookingRequestCubit>().declineBooking(
                      request.id!,
                    );
                  },
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: CustomElevatedButton(
                  text: "Approve",
                  backgroundColor: AppColors.primary,
                  textColor: Colors.white,
                  textStyle: AppStyles.bold14manrope,
                  verticalPadding: 14.h,
                  borderRadius: 12.r,
                  // Handle the loading state based on your cubit
                  isLoading:
                      context.watch<BookingRequestCubit>().state
                          is BookingRequestLoading,
                  onPressed: () async {
                    await context.read<BookingRequestCubit>().approveBooking(
                      request.id!,
                    );
                  },
                ),
              ),
              ]
            ],
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Icon(
          //       Icons.chat_bubble_outline_outlined,
          //       color: AppColors.primary,
          //       size: 18.sp,
          //       fontWeight: FontWeight.bold,
          //     ),
          //     SizedBox(width: 8.w),
          //     CustomTextButton(
          //       onPressed: () {
          //         if (context.mounted) {
          //           context.pushNamed(
          //               AppRouting.messagesName, pathParameters: {
          //             'otherUserId': ?request.renter?.id.toString()
          //           });
          //         }
          //       },
          //       text: 'Message ${request.renter?.name ?? 'Guest'}',
          //       isUnderlined: false,
          //       textColor: AppColors.primary,
          //       isPadded: true,
          //       textStyle: AppStyles.bold14manrope,
          //     ),
          //   ],
          // ),
         if(request.status?.toLowerCase() == 'pending')
           _buildTextButton(context, textColor: AppColors.primary, text: 'Message ${request.renter?.name ?? 'Guest'}', onPressed: () {
            if (context.mounted) {
              context.pushNamed(
                  AppRouting.messagesName, pathParameters: {
                'otherUserId': ?request.renter?.id.toString()
              });
            }
          }, icon: Icons.chat_bubble_outline_outlined,isPadded: true),
          if(request.status?.toLowerCase() == 'approved')
            _buildTextButton(context, textColor: AppColors.primary, text: 'Message ${request.renter?.name ?? 'Guest'}', onPressed: () {
              if (context.mounted) {
                context.pushNamed(
                    AppRouting.messagesName, pathParameters: {
                  'otherUserId': ?request.renter?.id.toString()
                });
              }
            }, icon: Icons.chat_bubble_outline_outlined,isPadded: true),
          // _buildTextButton(context, textColor: AppColors.textColorSuccess, text: 'This request Accepted', onPressed: (){}, icon: Icons.check_box_outlined),
          if(request.status?.toLowerCase() == 'declined') _buildTextButton(
              context, textColor: AppColors.textColorError, text: 'This request Declined', onPressed:(){}, icon: Icons.not_interested_rounded),

          SizedBox(height: 12.h,),

          if(request.status?.toLowerCase() == 'history')
            CustomElevatedButton(
              text: 'Delete', onPressed: () {
            context.read<BookingRequestCubit>().deleteBooking(request.id!);
          })
        ],
      ),
    );
  }

  Widget _buildTextButton(BuildContext context,
      {required Color textColor, required String text, required Function() onPressed, required IconData icon,bool isPadded = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: textColor,
          size: 18.sp,
          fontWeight: FontWeight.bold,
        ),
        SizedBox(width: 8.w),
        CustomTextButton(
          onPressed: onPressed!,
          text: text,
          isUnderlined: false,
          textColor: textColor,
          isPadded: isPadded,
          textStyle: AppStyles.bold14manrope,
        )
      ],
    );
  }
}