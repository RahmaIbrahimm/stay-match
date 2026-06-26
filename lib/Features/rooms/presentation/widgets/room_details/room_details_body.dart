import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stay_match/Features/rooms/data/models/room_details_response.dart';
import 'package:stay_match/Features/rooms/presentation/widgets/room_details/price_breakdown.dart';
import 'package:stay_match/Features/rooms/presentation/widgets/room_details/room_features_grid.dart';
import 'package:stay_match/Features/rooms/presentation/widgets/room_details/tenants_requirments_grid.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_styles.dart';

import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/routing/app_routing.dart';
import '../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../apartments/presentation/widgets/apartment_details/apartment_details_helper.dart';
import '../../../../apartments/presentation/widgets/apartment_details/duration_selector.dart';
import 'bottom_buttons.dart';
import 'image_carousel.dart';
import 'info_grid.dart';

class RoomDetailsBody extends StatefulWidget {
  final RoomDetailsResponseData data;
  final int propertyId;

  const RoomDetailsBody(
      {super.key, required this.data, required this.propertyId});

  @override
  State<RoomDetailsBody> createState() => _RoomDetailsBodyState();
}

class _RoomDetailsBodyState extends State<RoomDetailsBody> {
  final _picNotifier = ValueNotifier<int>(1);
  DateTime? moveInDate;
  int? duration;

  @override
  void dispose() {
    _picNotifier.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final d = widget.data;
    final images = d.propertyImages ?? [];
    final numImages = images.isEmpty ? 1 : images.length;

    final location = [d.city, d.government]
        .where((e) => e != null && e.isNotEmpty)
        .join(', ');

    final isAvailableNow = d.availableFrom != null &&
        !DateTime.parse(d.availableFrom!)
            .isAfter(DateTime.now().add(const Duration(days: 1)));

    final monthlyRent = (d.monthRent ?? 0).toDouble();
    final deposit = (d.deposit ?? 0).toDouble();
    final serviceFee = monthlyRent * 0.03;
    var availableDate = d.availableFrom != null
        ? DateTime.parse(d.availableFrom!)
        : DateTime.now();
    return Column(
      children: [
        Expanded(
          child: CustomScrollView(
            slivers: [
              // ── 1. Image carousel ─────────────────────────────────────
              SliverToBoxAdapter(
                child: ImageCarousel(
                  images: images,
                  numImages: numImages,
                  picNotifier: _picNotifier,
                  roomName: d.roomName,
                  isSaved: d.isSaved ?? false,
                  roomId: d.id?.toInt() ?? 0,
                  propertyId: widget.propertyId,
                ),
              ),

              // ── 2. Content ────────────────────────────────────────────
              SliverPadding(
                padding:
                EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    // Title row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(d.roomName ?? 'Room',
                                  style: AppStyles.semiBold24inter
                                      .copyWith(color: AppColors.primary)),
                              SizedBox(height: 4.h),
                              Row(children: [
                                Icon(Icons.location_on_outlined,
                                    size: 14.sp,
                                    color: AppColors.textColorSecondary),
                                SizedBox(width: 4.w),
                                Expanded(
                                  child: Text(location,
                                      style: AppStyles.regular14poppins
                                          .copyWith(
                                          color: AppColors
                                              .textColorSecondary)),
                                ),
                              ]),
                            ],
                          ),
                        ),
                        SizedBox(width: 8.w),
                        SizedBox(
                          width: 150.w,
                          height: 36,
                          child: CustomElevatedButton(
                            verticalPadding: 4.r,
                            horizontalPadding: 16.r,
                            text: AppStrings.viewReviews,
                            onPressed: () {
                              if (context.mounted) {
                                context.pushNamed(
                                    AppRouting.showReviewsName,
                                    pathParameters: {
                                      "propertyId": d.id.toString(),
                                    },
                                    queryParameters: { "isRoom": true.toString()
                                    });
                              }
                            },
                            backgroundColor: AppColors.bgGrey,
                            borderColor: AppColors.primary,
                            borderRadius: 10.r,
                            textColor: AppColors.textColorPrimary,
                            textStyle: AppStyles.medium15poppins,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),

                    // Info grid (Deposit / Availability / Min Stay)
                    InfoGrid(data: d),
                    SizedBox(height: 20.h),
                    Container(
                      padding: EdgeInsets.all(16.r),
                      decoration: BoxDecoration(
                        color: AppColors.containerColor,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Wrap(
                            alignment: WrapAlignment.spaceBetween,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            runAlignment: WrapAlignment.start,
                            runSpacing: 6.h,
                            direction: Axis.horizontal,
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '${d.monthRent?.toDouble()}',
                                      style: AppStyles.bold20poppins.copyWith(
                                        color: AppColors.primary,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' EGP',
                                      style: AppStyles.bold20poppins.copyWith(
                                        color: AppColors.primary,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' /month',
                                      style: AppStyles.regular14poppins
                                          .copyWith(
                                        color: AppColors.textColorSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16.r,
                                  vertical: 4.r,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withValues(
                                      alpha: 0.1),
                                  borderRadius: BorderRadius.circular(15.r),
                                ),
                                child: RichText(
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: AppStrings.available,
                                        style: AppStyles.bold14poppins.copyWith(
                                          color: AppColors.primary,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                        '\n${Apartmentdetailshelper.getMonth(
                                            availableDate
                                                .month)} ${availableDate.day}',
                                        style: AppStyles.bold14poppins.copyWith(
                                          color: AppColors.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          Divider(
                            color: AppColors.textColorSecondary.withValues(
                              alpha: 0.3,
                            ),
                            thickness: 0.5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [_deposit(d), _minimumStay(d)],
                          ),

                          if(!(d.isMyProperty ?? false) )...[SizedBox(height: 12.h),
                            DurationSelector(
                              isRoom: true,
                              minimumStay: d.minimumStay?.toInt() ?? 1,
                              selectedDate: moveInDate,
                              selectedMonths: duration,
                              onDateChanged: (date) =>
                                  setState(() => moveInDate = date),
                              onDurationChanged: (months) =>
                                  setState(() => duration = months),
                            ),
                          ]
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    // Room Features
                    Text('Room Features',
                        style: AppStyles.bold16poppins
                            .copyWith(color: AppColors.textColorPrimary)),
                    SizedBox(height: 12.h),
                    RoomFeaturesGrid(data: d),
                    SizedBox(height: 20.h),

                    // Tenant Requirements
                    Text('Tenant Requirements',
                        style: AppStyles.bold16poppins
                            .copyWith(color: AppColors.textColorPrimary)),
                    SizedBox(height: 12.h),
                    TenantRequirementsGrid(data: d),
                    SizedBox(height: 20.h),

                    // Price breakdown
                    PriceBreakdown(
                      monthlyRent: monthlyRent,
                      deposit: deposit,
                      serviceFee: serviceFee,
                    ),
                    SizedBox(height: 24.h),
                  ]),
                ),
              ),
              // ── 3. Bottom buttons ─────────────────────────────────────────────
              SliverToBoxAdapter(child: BottomButtons(data: d,
                moveInDate: moveInDate,
                duration: duration,
                propertyId: widget.propertyId,
              ),)
            ],
          ),
        ),


      ],
    );
  }

  RichText _deposit(RoomDetailsResponseData details) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: AppStrings.securityDeposit,
            style: AppStyles.bold12poppins.copyWith(
              color: AppColors.textColorSecondary,
            ),
          ),
          TextSpan(
            text: '\n${details.deposit ?? ''}',
            style: AppStyles.bold16poppins.copyWith(
              color: AppColors.textColorPrimary,
            ),
          ),
        ],
      ),
    );
  }

  RichText _minimumStay(RoomDetailsResponseData details) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: AppStrings.minimumStay,
            style: AppStyles.bold12poppins.copyWith(
              color: AppColors.textColorSecondary,
            ),
          ),
          TextSpan(
            text: '\n${details.minimumStay ?? ''}',
            style: AppStyles.bold16poppins.copyWith(
              color: AppColors.textColorPrimary,
            ),
          ),
          TextSpan(
            text: ' Months',
            style: AppStyles.bold16poppins.copyWith(
              color: AppColors.textColorPrimary,
            ),
          ),
        ],
      ),
    );
  }
}