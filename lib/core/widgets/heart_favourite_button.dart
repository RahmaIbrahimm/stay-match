import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../Features/saved/presentation/manager/saved_properties_cubit.dart';
import '../constants/app_colors.dart';

class HeartFavoriteButton extends StatefulWidget {
  final int? id;
  final bool initialSavedStatus;
  final bool scaleUp;

  const HeartFavoriteButton({
    super.key,
    required this.id,
    required this.initialSavedStatus,
    required this.scaleUp,
  });

  @override
  State<HeartFavoriteButton> createState() => _HeartFavoriteButtonState();
}

class _HeartFavoriteButtonState extends State<HeartFavoriteButton> {
  late bool isSaved;
  bool isToggling = false;

  @override
  void initState() {
    super.initState();
    isSaved = widget.initialSavedStatus;
  }

  @override
  void didUpdateWidget(covariant HeartFavoriteButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialSavedStatus != widget.initialSavedStatus) {
      isSaved = widget.initialSavedStatus;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SavedPropertiesCubit, SavedPropertiesState>(
      // 1. Only listen if THIS card is the one waiting for a response
      listenWhen: (previous, current) => isToggling,
      listener: (context, state) {
        if (state is ToggleSuccess) {
          // Flip the local visual state smoothly now that server operation confirmed success
          setState(() {
            isSaved = !isSaved;
            isToggling = false;
          });
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColors.primary,
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 2),
              content: Text(
                isSaved ? 'Saved successfully!' : 'Removed from saved!',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        }

        if (state is ToggleFailure) {
          setState(() => isToggling = false);
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.redAccent,
              behavior: SnackBarBehavior.floating,
              content: Text(state.errMessage),
            ),
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<SavedPropertiesCubit>();

        return GestureDetector(
          onTap: isToggling
              ? null
              : () {
            // Put the card into loading mode locally
            setState(() => isToggling = true);

            cubit.toggleSaved(
              itemType: SavedItemType.wholeApartment,
              propertyId: widget.id,
            );
          },
          child: Container(
            width: widget.scaleUp ? 40.w : 30.w,
            height: widget.scaleUp ? 40.h : 30.h,
            alignment: Alignment.center,
            child: isToggling
                ? SizedBox(
              width: widget.scaleUp ? 20.sp : 14.sp,
              height: widget.scaleUp ? 20.sp : 14.sp,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
            )
                : Icon(
              isSaved ? FontAwesome.heart_solid : FontAwesome.heart,
              size: widget.scaleUp ? 20.sp : 14.sp,
              color: isSaved ? AppColors.primary : Colors.grey,
            ),
          ),
        );
      },
    );
  }
}