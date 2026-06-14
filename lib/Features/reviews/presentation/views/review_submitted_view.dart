import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stay_match/Features/reviews/data/repos/reviews_repo_impl.dart';
import 'package:stay_match/core/utils/service_locator.dart';

import '../manager/write_review_cubit.dart';
import '../widgets/review_submitted_widgets/review_submitted_body.dart';

class ReviewSubmittedView extends StatelessWidget {
  const ReviewSubmittedView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      WriteReviewCubit(
        reviewsRepo: getIt.get<ReviewsRepoImpl>(),
      )
        ..fetchRecommendations(),
      child: const ReviewSubmittedBody(),
    );
  }
}