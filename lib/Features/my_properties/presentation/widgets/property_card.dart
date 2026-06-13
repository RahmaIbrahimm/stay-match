import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:stay_match/Features/my_properties/data/models/my_properties_response.dart';
import 'package:stay_match/Features/shared/widgets/card_cover_photo.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/routing/app_routing.dart';
import 'package:stay_match/core/widgets/custom_elevated_button.dart';

import '../../../../core/constants/app_styles.dart';
import '../manager/my_properties_cubit.dart';


class PropertyCard extends StatelessWidget {
  final Properties property;

  const PropertyCard({super.key, required this.property});

  // تحديد لون الـ Status بناءً على الـ TextColor المخصص
  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'active':
        return AppColors.textColorSuccess; // textColorSuccess
      case 'rejected':
        return AppColors.textColorError; // textColorError
      case 'pending_approval':
        return Colors.deepOrangeAccent; // Orange
      case 'under_review':
        return AppColors.textColorSecondary; // textColorSecondary
      default:
        return AppColors.primary; // primary
    }
  }

  String _formatDate(String? dateStr) {
    if (dateStr == null || dateStr == "string") return "RECENTLY";
    try {
      final DateTime date = DateTime.parse(dateStr);
      final DateTime now = DateTime.now();
      final Duration difference = now.difference(date);

      if (difference.inHours < 24 && difference.inHours >= 1) {
        return '${difference.inHours}H AGO';
      } else if (difference.inMinutes < 60 && difference.inHours < 1) {
        return 'JUST NOW';
      }

      final DateTime yesterday = DateTime(now.year, now.month, now.day - 1);
      if (date.year == yesterday.year &&
          date.month == yesterday.month &&
          date.day == yesterday.day) {
        return 'YESTERDAY';
      }

      if (difference.inDays < 7 && difference.inDays > 1) {
        return DateFormat('EEEE').format(date).toUpperCase();
      }

      return DateFormat('d/M/yyyy').format(date);
    } catch (e) {
      return "RECENTLY";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      foregroundDecoration :  property.status == 'Rejected' ? BoxDecoration(
          color: Colors.white.withAlpha(80)
      ):null,
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: Colors.white, // containerColor
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0x33000000), // shadowColor
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              // Property Image
              SizedBox(
                height: 200.h,
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(12.r),
                  ),
                  child: CardCoverPhoto(
                    imageUrl: property.coverImageUrl,
                    showCompatibility: false,
                    showRating: false,
                  ),
                ),
              ),
              // Status Badge (Top Left)
              Positioned(
                top: 12.h,
                left: 12.w,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    property.status?.replaceAll('_', ' ') ?? 'STATUS',
                    style: AppStyles.bold10manrope.copyWith(
                      color: _getStatusColor(property.status),
                    ),
                  ),
                ),
              ),
              // Type Badge (Top Right)
              Positioned(
                top: 12.h,
                right: 12.w,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    (property.type ?? 'APARTMENT').toUpperCase(),
                    style: AppStyles.bold10manrope.copyWith(
                      color: AppColors.primary, // primary
                    ),
                  ),
                ),
              ),

            ],
          ),
          Container(
            padding: EdgeInsets.all(12.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        property.name ?? 'Property Name',
                        style: AppStyles.bold16poppins.copyWith(
                          color: AppColors.primary, // primary
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '\$${property.monthlyRent ?? "0"}/month',
                      style: AppStyles.bold14poppins.copyWith(
                        color: AppColors.primary, // primary
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 14.sp,
                      color: const Color(0xff565B66),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      '${property.city}, ${property.government}',
                      style: AppStyles.regular12manrope.copyWith(
                        color:
                        AppColors.textColorSecondary, // textColorSecondary
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                const Divider(color: AppColors.stroke, thickness: 1), // stroke
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Expanded(
                      child: RichText(
                        softWrap: false,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'SUBMITTED',
                              style: AppStyles.bold10poppins.copyWith(
                                color: AppColors
                                    .textColorSecondary, // textColorSecondary
                              ),

                            ),
                            TextSpan(text: '\n'),
                            TextSpan(
                              text: _formatDate(property.createdAt),
                              style: AppStyles.bold10poppins.copyWith(
                                color: AppColors
                                    .textColorSecondary, // textColorSecondary
                              ),

                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    // Trash Icon
                    if(property.status?.toLowerCase() !=
                        'rejected') GestureDetector(
                      onTap: () {
                        // todo : implement deleting it ?? is it implemented in back ?
                        _showDeleteConfirmationDialog(context);
                      },
                      child: Padding(
                        padding: EdgeInsets.all(4.r), // Padding makes it easier to tap on mobile
                        child: Icon(
                          MdiIcons.trashCanOutline,
                          color: const Color(0xff565B66),
                          size: 20.sp,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    // Edit Button
                    if(property.status?.toLowerCase() !=
                        'rejected') _buildActionButton(
                      label: 'Edit',
                      icon: Icons.edit_outlined,
                      onPressed: () {},
                      color: Colors.black,
                    ),
                    SizedBox(width: 8.w),
                    // Details Button
                    _buildActionButton(
                      label:
                      property.status?.toLowerCase() == 'pending_approval'
                          ? 'Preview'
                          : 'Details',
                      onPressed: () {
                        // todo: implement for room too
                        if (property.type?.toLowerCase() != null &&
                            property.type!.isNotEmpty) {
                          property.type?.toLowerCase() == 'shared'
                              ? context.pushNamed(
                            AppRouting.roomDetailsViewName,
                            pathParameters: {
                              'roomId': property.id.toString(),
                              'propertyId': property.id.toString()
                            },
                          )
                              : context.pushNamed(
                            AppRouting.apartmentDetailsViewName,
                            pathParameters: {'id': property.id.toString()},
                          );
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 24,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.r), // The main outer boundary
        ),
        contentPadding: EdgeInsets.zero,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. Premium Minimal Header
            Padding(
              padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Remove Listing',
                    style: AppStyles.bold16poppins.copyWith(
                      color: AppColors.primary,
                      letterSpacing: -0.3,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(dialogContext),
                    child: Container(
                      padding: EdgeInsets.all(6.r),
                      decoration: const BoxDecoration(
                        color: Color(0xFFF5F6F7),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.close, size: 16.sp, color: const Color(0xff565B66)),
                    ),
                  ),
                ],
              ),
            ),

            // 2. Focused Context Message
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              child: Text(
                'Are you sure you want to permanently delete this listing from your dashboard?',
                style: AppStyles.regular12manrope.copyWith(
                  color: AppColors.textColorSecondary,
                  height: 1.4,
                ),
              ),
            ),

            // 3. Mini Property Summary Card
            Container(
              margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F9FA),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: AppColors.stroke, width: 1),
              ),
              child: Row(
                children: [
                  // Mini Thumbnail
                  Container(
                    width: 50.r,
                    height: 50.r,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      image: DecorationImage(
                        image: NetworkImage(property.coverImageUrl ?? ''),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  // Text Context
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          property.name ?? 'Property Name',
                          style: AppStyles.bold12poppins.copyWith(
                            color: AppColors.primary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          '${property.city}, ${property.government}',
                          style: AppStyles.regular12manrope.copyWith(
                            color: AppColors.textColorSecondary,
                          ).copyWith(fontSize: 10.sp),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16.h),
            const Divider(color: AppColors.stroke, height: 1),

            // 4. Clean, Fully Rounded Action Strip
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFFAFAFA),
                // FIX: This rounds the bottom corners to match the main card perfectly!
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(24.r),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              child: Row(
                children: [
                  // Dismiss Action
                  Expanded(
                    child: SizedBox(
                      height: 38.h,
                      child: TextButton(
                        onPressed: () => Navigator.pop(dialogContext),
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Text(
                          'Cancel',
                          style: AppStyles.bold12poppins.copyWith(
                            color: AppColors.textColorSecondary,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  // Destructive Action
                  Expanded(
                    child: SizedBox(
                      height: 38.h,
                      child: CustomElevatedButton(
                        text: 'Delete Listing',
                        onPressed: () {
                          Navigator.pop(dialogContext);
                          if (property.id != null) {
                            context.read<MyPropertiesCubit>().deleteProperty(property.id!);
                          }
                        },
                        backgroundColor: AppColors.textColorError,
                        textColor: Colors.white,
                        borderRadius: 12,
                        textStyle: AppStyles.bold12poppins,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }  Widget _buildActionButton({
    required String label,
    IconData? icon,
    required VoidCallback onPressed,
    Color color = AppColors.primary,
  }) {
    return SizedBox(
      height: 30.h,
      child: CustomElevatedButton(
        text: label,
        onPressed: onPressed,
        verticalPadding: 8,
        backgroundColor: AppColors.containerColor,
        suffixIcon: icon != null ? Icon(icon, size: 12.sp, color: color) : null,
        borderColor: color,
        textColor: color,
        textStyle: AppStyles.bold10poppins,
        borderRadius: 12,
      ),
    );
  }
}