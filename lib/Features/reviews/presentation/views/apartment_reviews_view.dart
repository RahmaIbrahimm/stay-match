import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stay_match/Features/reviews/data/repos/reviews_repo_impl.dart';
import 'package:stay_match/Features/reviews/presentation/manager/reviews_cubit.dart';
import 'package:stay_match/core/utils/service_locator.dart';

import '../widgets/apartment_reviews_widgets/apartment_reviews_body.dart';

// ══════════════════════════════════════════════════════════════════════════════
// ENTRY POINT
// ══════════════════════════════════════════════════════════════════════════════
class ApartmentReviewsView extends StatelessWidget {
  final int propertyId;

  const ApartmentReviewsView({super.key, required this.propertyId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ReviewsCubit(reviewsRepo: getIt.get<ReviewsRepoImpl>()),
      child: ApartmentReviewsBody(propertyId: propertyId),
    );
  }
}