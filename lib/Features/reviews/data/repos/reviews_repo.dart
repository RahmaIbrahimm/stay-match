import 'package:dartz/dartz.dart';
import 'package:stay_match/Features/reviews/data/models/get_apartment_reviews.dart';
import 'package:stay_match/Features/reviews/data/models/host_reply_response.dart';
import 'package:stay_match/Features/reviews/data/models/review_recommendations.dart';
import 'package:stay_match/Features/reviews/data/models/write_review_response.dart';
import 'package:stay_match/core/errors/failures.dart';

import '../models/write_review_request.dart';

abstract class ReviewsRepo {
  Future<Either<Failure, GetPropertyReviews>> getApartmentReviews({
    required int propertyId,
    int? page,
    int? pageSize,
    String? sortBy= 'All',
    String? search,
  });
  Future<Either<Failure, GetPropertyReviews>> getRoomReviews({
    required int roomId,
    int? page,
    int? pageSize,
    String? sortBy= 'All',
    String? search,
  });

  Future<Either<Failure, WriteReviewResponse>> writeReview({required WriteReviewRequest request});
  Future<Either<Failure, ReviewRecommendations>> getRecommendations();
  Future<Either<Failure, HostReplyResponse>> hostReplyToReview({required int reviewId, required String response});

}