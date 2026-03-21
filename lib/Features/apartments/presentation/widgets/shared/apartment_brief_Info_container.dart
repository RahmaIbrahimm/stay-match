import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:stay_match/core/routing/app_routing.dart';
import 'package:stay_match/features/home/presentation/widget/small_custom_button.dart';

import '../../../../../../../../core/constants/app_colors.dart';
import '../../../../../../../../core/constants/app_strings.dart';
import '../../../../../../../../core/constants/app_styles.dart';
import '../../../data/models/all_apartments.dart';

class ApartmentBriefInfoContainer extends StatelessWidget {
  const ApartmentBriefInfoContainer({
    super.key,
    required this.name,
    required this.city,
    required this.streetName,
    required this.monthlyRent,
    required this.isFurnished,
    this.property,
    required this.id,
    this.scaleUp = false,
  });

  final String? name;
  final String? city;
  final String? streetName;
  final num? monthlyRent;
  final bool isFurnished;
  final AllApartmentsItems? property;
  final int? id;
  final bool scaleUp;

  @override
  Widget build(BuildContext context) {
    log(property?.name ?? 'wth no name sent for some reason',name: 'apartment brief name');
    return Container(
      decoration: BoxDecoration(
        color: AppColors.containerColor,
        border: Border(
          left: BorderSide(color: AppColors.primary),
          right: BorderSide(color: AppColors.primary),
          bottom: BorderSide(color: AppColors.primary),
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(8.r),
          bottomRight: Radius.circular(8.r),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 4.h),
            Text(
              name ?? 'No name' ,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style:
                  (scaleUp
                          ? AppStyles.semiBold18poppins
                          : AppStyles.semiBold12poppins)
                      .copyWith(color: AppColors.textColorPrimary),
            ),
            SizedBox(height: 4.h),
            _buildLocation(),
            SizedBox(height: 6.h),
            _buildFeatures(),
            _buildPrice(monthlyRent: monthlyRent?.toInt()),
            if (scaleUp) SizedBox(height: 8.h),
            _buildViewDetailsButton(context),
          ],
        ),
      ),
    );
  }

  Padding _buildViewDetailsButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.0.r),
      child: SizedBox(
        width: double.infinity,
        height: scaleUp ? 40.h : null,
        child: SmallCustomButton(
          text: AppStrings.viewDetails,
          textStyle: AppStyles.semiBold16poppins,
          onPressed: () => _viewDetails(context),
        ),
      ),
    );
  }

  Widget _buildPrice({required int? monthlyRent}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'EGP ${monthlyRent ?? 0}',
                style:
                    (scaleUp
                            ? AppStyles.bold20poppins
                            : AppStyles.bold15poppins)
                        .copyWith(color: AppColors.primary),
              ),
              TextSpan(
                text: ' / month',
                style:
                    (scaleUp
                            ? AppStyles.medium12poppins
                            : AppStyles.medium10poppins)
                        .copyWith(color: AppColors.textColorSecondary),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
            width: scaleUp ? 40.w : 30.w,
            height: scaleUp ? 40.h : 30.h,
            alignment: Alignment.center,
            child: Icon(
              FontAwesome.heart,
              size: scaleUp ? 20.sp : 14.sp,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFeature({required Widget icon, required String text}) {
    return Column(
      children: [
        icon,
        Text(
          text,
          style: scaleUp
              ? AppStyles.medium15poppins
              : AppStyles.medium10poppins,
        ),
      ],
    );
  }

  Widget _buildFeatures() {
    int numBeds = property?.numberOfBedrooms?.toInt() ?? 0;
    double size = property?.size?.toDouble() ?? 0;
    int numBathrooms =
        (property?.numberOfGuestBathrooms?.toInt() ?? 0) +
        (property?.numberOfEnSuiteBathrooms?.toInt() ?? 0);
    return Container(
      padding: EdgeInsets.all(6.r),
      margin: EdgeInsets.symmetric(horizontal: 2.r),
      decoration: BoxDecoration(
        color: AppColors.bgGrey,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildFeature(
            icon: Icon(
              Icons.king_bed,
              color: Colors.black,
              size: scaleUp ? 20.sp : 12.sp,
            ),
            text: '$numBeds ${numBeds > 1 ? 'Beds' : 'Bed'}',
          ),
          _buildFeature(
            icon: FaIcon(FontAwesomeIcons.bath, size: scaleUp ? 20.sp : 12.sp),
            text:
                '$numBathrooms ${numBathrooms > 1 ? 'Bathrooms' : 'Bathroom'}',
          ),
          _buildFeature(
            icon: FaIcon(FontAwesomeIcons.expand, size: scaleUp ? 20.r : 12.r),
            text: '$size m',
          ),
        ],
      ),
    );
  }

  Widget _buildLocation() {
    return Row(
      children: [
        Icon(
          Icons.location_on,
          color: AppColors.textColorSecondary,
          size: scaleUp ? 15.r : 10.r,
        ),
        SizedBox(width: 2.r),
        Expanded(
          child: Text(
            '${streetName ?? 'No street'}, ${city ?? 'No city'}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style:
                (scaleUp
                        ? AppStyles.medium15poppins
                        : AppStyles.medium10poppins)
                    .copyWith(color: AppColors.textColorSecondary),
          ),
        ),
      ],
    );
  }

  VoidCallback? _viewDetails(BuildContext context) {
    if (id != null) {
      // todo: this doesn't exist in this screen
      context.pushNamed(
        AppRouting.apartmentDetailsViewName,
        pathParameters: {'id': id!.toInt().toString()},
      );
    } else {
      // Handle missing ID - maybe show a snackbar or log error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Cannot view details: Invalid property ID'),
        ),
      );
    }
  }
}