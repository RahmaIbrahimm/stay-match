import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/Features/other_user_profile/presentation/manager/other_user_profile_cubit.dart';
import 'package:stay_match/Features/other_user_profile/presentation/widgets/listing_card.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_styles.dart';

import '../../../../core/utils/service_locator.dart';
import '../../data/repos/other_user_profile_repo_impl.dart';

// class UserListingsView extends StatefulWidget {
//   final String userId;
//
//   const UserListingsView({super.key, required this.userId});
//
//   @override
//   State<UserListingsView> createState() => _UserListingsViewState();
// }
//
// class _UserListingsViewState extends State<UserListingsView> {
//   @override
//   void initState() {
//     super.initState();
//     context
//         .read<OtherUserProfileCubit>()
//         .getOtherUserListings(userId: widget.userId);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.secondaryScaffBg,
//       appBar: AppBar(
//         backgroundColor: AppColors.containerColor,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(
//             Icons.arrow_back,
//             color: AppColors.textColorPrimary,
//             size: 24.r,
//           ),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         title: Text(
//           'User Listings',
//           style: AppStyles.bold18poppins.copyWith(
//             color: AppColors.textColorPrimary,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: BlocProvider(
//         create: (context) => OtherUserProfileCubit(otherUserProfileRepo: getIt.get<OtherUserProfileRepoImpl>()),
//         child: UserListngsBody(widget: widget),
//       ),
//     );
//   }
// }
//
// class UserListngsBody extends StatelessWidget {
//   const UserListngsBody({
//     super.key,
//     required this.widget,
//   });
//
//   final UserListingsView widget;
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<OtherUserProfileCubit, OtherUserProfileState>(
//       builder: (context, state) {
//         if (state is OtherUserProfileLoading) {
//           return Center(
//             child: CircularProgressIndicator(color: AppColors.primary),
//           );
//         }
//
//         if (state is OtherUserProfileFailure) {
//           return Center(
//             child: Padding(
//               padding: EdgeInsets.all(24.r),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Icon(
//                     Icons.error_outline,
//                     size: 48.r,
//                     color: AppColors.textColorError,
//                   ),
//                   SizedBox(height: 12.h),
//                   Text(
//                     state.errMessage,
//                     textAlign: TextAlign.center,
//                     style: AppStyles.regular14poppins.copyWith(
//                       color: AppColors.textColorSecondary,
//                     ),
//                   ),
//                   SizedBox(height: 16.h),
//                   TextButton(
//                     onPressed: () =>
//                         context
//                             .read<OtherUserProfileCubit>()
//                             .getOtherUserListings(userId: widget.userId),
//                     child: Text(
//                       'Try again',
//                       style: AppStyles.semiBold14poppins.copyWith(
//                         color: AppColors.primary,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         }
//
//         if (state is OtherUserProfileSuccess) {
//           final listings = state.listings?.data;
//
//           if (listings == null || listings.isEmpty) {
//             return Center(
//               child: Padding(
//                 padding: EdgeInsets.all(24.r),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Icon(
//                       Icons.home_outlined,
//                       size: 48.r,
//                       color: AppColors.textColorSecondary,
//                     ),
//                     SizedBox(height: 12.h),
//                     Text(
//                       'No listings available',
//                       style: AppStyles.regular14poppins.copyWith(
//                         color: AppColors.textColorSecondary,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           }
//
//           return ListView.separated(
//             padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
//             itemCount: listings.length,
//             separatorBuilder: (_, __) => SizedBox(height: 16.h),
//             itemBuilder: (context, index) {
//               // UserListingsResponse Data model mirrors the listing shape
//               // used by OtherUserProfile's activeListings — reuse ListingCard.
//               // If the types differ, map the fields here.
//               final item = listings[index];
//               return ListingCard(listing: item);
//             },
//           );
//         }
//
//         return const SizedBox.shrink();
//       },
//     );
//   }
// }
class UserListingsView extends StatefulWidget {
  final String userId;
  const UserListingsView({super.key, required this.userId});

  @override
  State<UserListingsView> createState() => _UserListingsViewState();
}

class _UserListingsViewState extends State<UserListingsView> {
  late final OtherUserProfileCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = OtherUserProfileCubit(
      otherUserProfileRepo: getIt.get<OtherUserProfileRepoImpl>(),
    );
    _cubit.getOtherUserListings(userId: widget.userId);
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        backgroundColor: AppColors.secondaryScaffBg,
        appBar: AppBar(
          backgroundColor: AppColors.containerColor,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: AppColors.textColorPrimary, size: 24.r),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            'Listings',
            style: AppStyles.bold18poppins.copyWith(color: AppColors.textColorPrimary),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<OtherUserProfileCubit, OtherUserProfileState>(
          builder: (context, state) {
            if (state is OtherUserProfileLoading) {
              return Center(child: CircularProgressIndicator(color: AppColors.primary));
            }

            if (state is OtherUserProfileFailure) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.all(24.r),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.error_outline, size: 48.r, color: AppColors.textColorError),
                      SizedBox(height: 12.h),
                      Text(
                        state.errMessage,
                        textAlign: TextAlign.center,
                        style: AppStyles.regular14poppins.copyWith(color: AppColors.textColorSecondary),
                      ),
                      SizedBox(height: 16.h),
                      TextButton(
                        onPressed: () => _cubit.getOtherUserListings(userId: widget.userId),
                        child: Text('Try again', style: AppStyles.semiBold14poppins.copyWith(color: AppColors.primary)),
                      ),
                    ],
                  ),
                ),
              );
            }

            if (state is OtherUserProfileSuccess) {
              final listings = state.listings?.data;
              if (listings == null || listings.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.home_outlined, size: 48.r, color: AppColors.textColorSecondary),
                      SizedBox(height: 12.h),
                      Text('No listings available',
                          style: AppStyles.regular14poppins.copyWith(color: AppColors.textColorSecondary)),
                    ],
                  ),
                );
              }
              return ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                itemCount: listings.length,
                separatorBuilder: (_, __) => SizedBox(height: 16.h),
                itemBuilder: (_, index) => ListingCard(listing: listings[index]),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}