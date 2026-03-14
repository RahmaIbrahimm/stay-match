import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_strings.dart';

import '../../../../../../../../../core/constants/app_styles.dart';
import '../widgets/room_details_body.dart';

class RoomDetailsView extends StatelessWidget {
  const RoomDetailsView({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            context.pop();
          },
          icon: Icon(Icons.arrow_back,color: AppColors.primary,),
        ),
        title: Text(
          AppStrings.roomDetails,
          style: AppStyles.bold18poppins.copyWith(
            color: AppColors.textColorPrimary,
            letterSpacing: -0.45,
          ),
        ),
        actions: [
          Icon(Icons.share,color: AppColors.primary,)
        ],
        centerTitle: true,
        backgroundColor: Colors.white.withValues(alpha: 0.8),
      ),
      body: RoomDetailsBody(),
    );
  }
}