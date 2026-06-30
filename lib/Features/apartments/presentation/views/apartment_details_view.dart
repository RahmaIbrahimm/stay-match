// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:go_router/go_router.dart';
// import 'package:stay_match/core/constants/app_colors.dart';
// import 'package:stay_match/core/constants/app_strings.dart';
// import 'package:stay_match/core/utils/service_locator.dart';
// import 'package:stay_match/core/widgets/app_drawer/main_app_drawer.dart';
//
// import '../../../../core/constants/app_styles.dart';
// import '../../../../core/widgets/draggable_chatbot_fab.dart';
// import '../../data/repos/apartment_repo_impl.dart';
// import '../manager/apartment_details_cubit.dart';
// import '../widgets/apartment_details/apartment_details_view_body.dart';
//
// class ApartmentDetailsView extends StatelessWidget {
//   const ApartmentDetailsView({super.key, required this.id});
//
//   final int id;
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) =>
//           ApartmentDetailsCubit(getIt.get<ApartmentRepoImpl>(), id)
//             ..getPropertyDetails(id: id),
//       child: SafeArea(
//         child: Scaffold(
//           backgroundColor: AppColors.darkerGrey,
//           extendBody: true,
//           endDrawer: MainAppDrawer(),
//           appBar: AppBar(
//             surfaceTintColor: Colors.transparent,
//             leading: IconButton(
//               onPressed: () async {
//                 if (context.canPop()) context.pop(true);
//               },
//               icon: Icon(Icons.arrow_back, color: AppColors.primary),
//             ),
//             title: Text(
//               AppStrings.apartmentDetails,
//               style: AppStyles.bold18poppins.copyWith(
//                 color: AppColors.textColorPrimary,
//                 letterSpacing: -0.45.r,
//               ),
//             ),
//             centerTitle: true,
//             backgroundColor: Colors.transparent,
//             // flexibleSpace: ClipRect(
//             //   child: BackdropFilter(
//             //     filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
//             //     child: Container(color: Colors.white.withValues(alpha: 0.8)),
//             //   ),
//             // ),
//             flexibleSpace: Container(color: Colors.white),
//
//             elevation: 0,
//           ),
//           body: DraggableChatbotFab(hasBottomNav: false,
//               child: ApartmentDetailsViewBody(id: id)),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_strings.dart';
import 'package:stay_match/core/utils/service_locator.dart';
import 'package:stay_match/core/widgets/app_drawer/main_app_drawer.dart';

import '../../../../core/constants/app_styles.dart';
import '../../../../core/widgets/draggable_chatbot_fab.dart';
import '../../../shared/widgets/details_view_app_bar.dart';
import '../../data/repos/apartment_repo_impl.dart';
import '../manager/apartment_details_cubit.dart';
import '../widgets/apartment_details/apartment_details_view_body.dart';

class ApartmentDetailsView extends StatelessWidget {
  const ApartmentDetailsView({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      ApartmentDetailsCubit(getIt.get<ApartmentRepoImpl>(), id)
        ..getPropertyDetails(id: id),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.darkerGrey,
          extendBody: true,
          endDrawer: const MainAppDrawer(),
          appBar: AppBar(
            surfaceTintColor: Colors.transparent,
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              onPressed: () async {
                if (context.canPop()) context.pop(true);
              },
              icon: Icon(Icons.arrow_back, color: AppColors.primary),
            ),
            title: Text(
              AppStrings.apartmentDetails,
              style: AppStyles.bold18poppins.copyWith(
                color: AppColors.textColorPrimary,
                letterSpacing: -0.45.r,
              ),
            ),
            centerTitle: true,
          ),
          body: DraggableChatbotFab(
            hasBottomNav: false,
            child: ApartmentDetailsViewBody(id: id),
          ),
        ),
      ),
    );
  }
}