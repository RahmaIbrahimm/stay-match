import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stay_match/Features/apartments/presentation/widgets/apartment_details/apartment_details_helper.dart';
import 'package:stay_match/Features/rooms/presentation/manager/room_details_cubit.dart';
import 'package:stay_match/Features/rooms/presentation/manager/room_details_state.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_strings.dart';
import 'package:stay_match/core/constants/app_styles.dart';
import 'package:stay_match/core/routing/app_routing.dart';
import 'package:stay_match/core/widgets/custom_elevated_button.dart';
import 'package:stay_match/core/widgets/location_row.dart';

import '../../../../apartments/presentation/widgets/apartment_details/apartment_about_sliver.dart';
import '../../../../shared/widgets/basic_features_sliver.dart';
import '../../../../shared/widgets/host_name_sliver.dart';
import '../../../../shared/widgets/property_name_sliver.dart';
import '../../../../shared/widgets/failure_state_widget.dart';
import '../../../../google_maps/presentation/views/google_maps_view.dart';
import '../../../../google_maps/presentation/widgets/maps_helper.dart';
import '../../../../shared/widgets/amenities_widget.dart';
import '../../../../shared/models/property_details_response.dart';

class RoomDetailsViewBody extends StatefulWidget {
  const RoomDetailsViewBody({super.key, required this.id});

  final int id;

  @override
  State<RoomDetailsViewBody> createState() => _RoomDetailsViewBodyState();
}

class _RoomDetailsViewBodyState extends State<RoomDetailsViewBody> {
  String? allowedStudentTenantGender;
  late final ValueNotifier<int> currentPic;
  GoogleMapController? controller;

  @override
  void initState() {
    super.initState();
    currentPic = ValueNotifier<int>(1);
  }

  @override
  void dispose() {
    currentPic.dispose();
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoomDetailsCubit, RoomDetailsState>(
      builder: (context, state) {
        if (state is GetRoomDetailsLoading) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 60.w,
                  height: 60.w,
                  child: CircularProgressIndicator(
                    strokeWidth: 3.w,
                    color: AppColors.primary,
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  'Loading room details...',
                  style: AppStyles.medium16poppins.copyWith(
                    color: AppColors.textColorSecondary,
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildLoadingDot(0),
                    _buildLoadingDot(0.2),
                    _buildLoadingDot(0.4),
                  ],
                ),
              ],
            ),
          );
        }

        if (state is GetRoomDetailsSuccess) {
          final details = state.response.data;
          bool initialSavedStatus = details?.isSaved ?? false;
          log('${details?.latitude}');
          log('${details?.longitude}');

          if (details?.allowedTenants?.allowsStudents ?? false) {
            allowedStudentTenantGender =
                details?.allowedTenants?.studentGender?.trim().toLowerCase() ??
                    'any';
          }

          var availableDate = details!.availableFrom != null
              ? DateTime.parse(details.availableFrom!)
              : DateTime.now();

          var numBathrooms =
              (details.numberOfEnSuiteBathrooms ?? 0).toInt() +
                  (details.numberOfGuestBathrooms ?? 0).toInt();
          var numBeds = details.numberOfBedrooms ?? 0;

          var amenities = Apartmentdetailshelper.getAmenitiesWithIcons(
            details.amenities,
          );
          var numOfImages = details.propertyImages?.length ?? 0;

          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(
                  height: MediaQuery.of(context).padding.top - 15.h,
                ),
              ),

              // ── Images ──
              if (numOfImages != 0)
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 260.h,
                    width: double.infinity,
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        PageView.builder(
                          onPageChanged: (value) {
                            currentPic.value = value + 1;
                          },
                          itemCount: numOfImages,
                          itemBuilder: (context, index) {
                            final imageUrl =
                                details.propertyImages?[index].imageUrl;
                            return CachedNetworkImage(
                              imageUrl: imageUrl ?? '',
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(
                                color: AppColors.bgGrey,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.w,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) => Container(
                                color: AppColors.bgGrey,
                                child: Center(
                                  child: Icon(
                                    Icons.broken_image_outlined,
                                    size: 40.sp,
                                    color: AppColors.textColorSecondary,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        // photo counter
                        ValueListenableBuilder(
                          valueListenable: currentPic,
                          builder: (context, value, child) {
                            return Container(
                              margin: EdgeInsets.symmetric(
                                vertical: 20.r,
                                horizontal: 8.r,
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.r,
                                vertical: 2.r,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.9),
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                              child: Text(
                                '${currentPic.value}/$numOfImages Photos',
                                style: AppStyles.bold14poppins.copyWith(
                                  color: AppColors.primary,
                                ),
                              ),
                            );
                          },
                        ),
                        // dot indicators
                        Positioned(
                          bottom: 16.h,
                          left: 0,
                          right: 0,
                          child: ValueListenableBuilder(
                            valueListenable: currentPic,
                            builder: (context, value, child) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(numOfImages, (index) {
                                  return AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    width: (currentPic.value - 1) == index
                                        ? 16.w
                                        : 8.w,
                                    height: 8.h,
                                    margin:
                                    EdgeInsets.symmetric(horizontal: 4.w),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 0.3.r,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                          Colors.black.withValues(alpha: 0.2),
                                          blurRadius: 2,
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(4.r),
                                      color: (currentPic.value - 1) == index
                                          ? AppColors.containerColor
                                          : AppColors.grey,
                                    ),
                                  );
                                }),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              // ── Name + Fav ──
              PropertyNameAndFavButtonSliver(
                name: details.name,
                id: widget.id,
                initialSavedStatus: initialSavedStatus,
                scaleUp: true,
              ),

              // ── Location + Reviews ──
              SliverToBoxAdapter(
                child: RPadding(
                  padding: EdgeInsets.only(left: 16.r, right: 16.r),
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    alignment: WrapAlignment.spaceBetween,
                    runSpacing: 6.h,
                    children: [
                      LocationRow(
                          city: details.city, street: details.street),
                      SizedBox(
                        width: 155.w,
                        child: CustomElevatedButton(
                          verticalPadding: 4.r,
                          horizontalPadding: 16.r,
                          text: AppStrings.viewReviews,
                          onPressed: () {
                            if (context.mounted) {
                              context.pushNamed(
                                AppRouting.apartmentReviewsName,
                                pathParameters: {
                                  "propertyId": details.id.toString()
                                },
                              );
                            }
                          },
                          backgroundColor: AppColors.bgGrey,
                          borderColor: AppColors.primary,
                          borderRadius: 10.r,
                          textColor: AppColors.primary,
                          textStyle: AppStyles.medium16poppins,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ── Host ──
              HostNameSliver(details: details),

              // ── Gender badge ──
              if (allowedStudentTenantGender != null &&
                  allowedStudentTenantGender != 'any')
                SliverToBoxAdapter(
                  child: Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 2),
                          decoration: BoxDecoration(
                            color: allowedStudentTenantGender == 'female'
                                ? AppColors.pink
                                : AppColors.blue,
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          child: Text(
                            allowedStudentTenantGender == 'female'
                                ? 'Females Only'
                                : 'Males Only',
                            style: AppStyles.semiBold14poppins.copyWith(
                              color: allowedStudentTenantGender == 'female'
                                  ? const Color(0xffC01D82)
                                  : const Color(0xff1D82C0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              // ── Price card (no duration selector) ──
              SliverToBoxAdapter(
                child: Container(
                  padding: EdgeInsets.all(16.r),
                  margin: EdgeInsets.all(16.r),
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
                        runSpacing: 6.h,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                  '${details.monthlyRent?.toDouble() ?? 0}',
                                  style: AppStyles.bold20poppins.copyWith(
                                      color: AppColors.primary),
                                ),
                                TextSpan(
                                  text: ' EGP',
                                  style: AppStyles.bold20poppins.copyWith(
                                      color: AppColors.primary),
                                ),
                                TextSpan(
                                  text: ' /month',
                                  style:
                                  AppStyles.regular14poppins.copyWith(
                                      color: AppColors
                                          .textColorSecondary),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 32.r, vertical: 4.r),
                            decoration: BoxDecoration(
                              color: AppColors.primary
                                  .withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                            child: RichText(
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: AppStrings.available,
                                    style: AppStyles.bold14poppins
                                        .copyWith(color: AppColors.primary),
                                  ),
                                  TextSpan(
                                    text:
                                    '\n${Apartmentdetailshelper.getMonth(availableDate.month)} ${availableDate.day}',
                                    style: AppStyles.bold14poppins
                                        .copyWith(color: AppColors.primary),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Divider(
                        color: AppColors.textColorSecondary
                            .withValues(alpha: 0.3),
                        thickness: 0.5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _deposit(details),
                          _minimumStay(details),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // ── Basic features ──
              BasicFeaturesSliver(
                details: details,
                numBeds: numBeds,
                numBathrooms: numBathrooms,
              ),
              SliverToBoxAdapter(child: SizedBox(height: 16.h)),

              // ── About ──
              PropertyAboutSliver(details: details),
              SliverToBoxAdapter(child: SizedBox(height: 16.h)),

              // ── Amenities ──
              SliverToBoxAdapter(
                child: RPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'What this place offers',
                    style: AppStyles.bold18poppins
                        .copyWith(color: AppColors.textColorPrimary),
                  ),
                ),
              ),
              AmenitiesWidget(amenities: amenities),

              // ── Map ──
              SliverToBoxAdapter(
                child: RPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "Where you'll be",
                    style: AppStyles.bold18poppins
                        .copyWith(color: AppColors.textColorPrimary),
                  ),
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 10.h)),
              SliverToBoxAdapter(
                child: GestureDetector(
                  onDoubleTap: () {
                    if (context.mounted) {
                      context.pushNamed(
                        AppRouting.googleMapsViewName,
                        queryParameters: {
                          'latitude': details.latitude.toString(),
                          'longitude': details.longitude.toString(),
                          'isStatic': 'true',
                        },
                      );
                    }
                  },
                  child: RPadding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 16.0),
                    child: SizedBox(
                      height: 180.h,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.r),
                        child: GoogleMapsView(
                          key: ValueKey(details.id),
                          mapContext: MapContext.staticView,
                          initialLatitude: details.latitude,
                          initialLongitude: details.longitude,
                          mapView: MapViewType.partialView,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // ── Buttons ──
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(height: 24.h),
                    _buildButtons(
                      hostId: details.hostId.toString(),
                      details: details,
                    ),
                  ],
                ),
              ),
            ],
          );
        }

        if (state is GetRoomDetailsFailure) {
          return FailureState(
              errMessage: state.errMessage, id: widget.id);
        }

        return const SizedBox.shrink();
      },
    );
  }

  RPadding _buildButtons({
    required String hostId,
    required PropertyDetailsData? details,
  }) {
    return RPadding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Flexible(
            flex: 3,
            child: CustomElevatedButton(
              borderRadius: 10,
              textStyle: AppStyles.bold14poppins,
              text: AppStrings.message,
              textColor: AppColors.primary,
              suffixIcon: Icon(
                Icons.messenger_outline,
                color: AppColors.primary,
                size: 15.r,
              ),
              borderColor: AppColors.primary,
              backgroundColor: AppColors.containerColor,
              onPressed: () {
                if (mounted) {
                  context.pushNamed(
                    AppRouting.messagesName,
                    pathParameters: {'otherUserId': hostId},
                  );
                }
              },
            ),
          ),
          SizedBox(width: 16.w),
          Flexible(
            flex: 4,
            child: CustomElevatedButton(
              borderRadius: 10,
              text: AppStrings.bookNow,
              textStyle: AppStyles.bold14poppins,
              onPressed: () => _onBookNowPressed(details: details),
            ),
          ),
        ],
      ),
    );
  }

  void _onBookNowPressed({required PropertyDetailsData? details}) {
    if (mounted) {
      context.pushNamed(
        AppRouting.bookingRequestName,
        extra: {
          'propertyId': widget.id,
          'startDate': null,
          'duration': null,
          'monthlyRent': details?.monthlyRent,
          'street': details?.street ?? '',
          'city': details?.city ?? '',
          'hostName': details?.hostName,
          'propertyName': details?.name,
          'propertyImg': details?.propertyImages?[0].imageUrl,
        },
      );
    }
  }

  RichText _deposit(PropertyDetailsData details) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: AppStrings.securityDeposit,
            style: AppStyles.bold12poppins
                .copyWith(color: AppColors.textColorSecondary),
          ),
          TextSpan(
            text: '\n${details.deposite ?? 0}',
            style: AppStyles.bold16poppins
                .copyWith(color: AppColors.textColorPrimary),
          ),
        ],
      ),
    );
  }

  RichText _minimumStay(PropertyDetailsData details) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: AppStrings.minimumStay,
            style: AppStyles.bold12poppins
                .copyWith(color: AppColors.textColorSecondary),
          ),
          TextSpan(
            text: '\n${details.minimumStay ?? '1'}',
            style: AppStyles.bold16poppins
                .copyWith(color: AppColors.textColorPrimary),
          ),
          TextSpan(
            text: ' Months',
            style: AppStyles.bold16poppins
                .copyWith(color: AppColors.textColorPrimary),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingDot(double delay) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.5, end: 1.0),
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
      builder: (context, value, child) {
        return Container(
          width: 8.w,
          height: 8.w,
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primary.withValues(alpha: value),
          ),
        );
      },
    );
  }
}