import 'package:dartz/dartz.dart';
import 'package:stay_match/Features/reviews/data/models/get_apartment_reviews.dart';
import 'package:stay_match/Features/reviews/data/models/write_review_response.dart';
import 'package:stay_match/core/errors/failures.dart';

import '../models/write_review_request.dart';

abstract class ReviewsRepo {
  Future<Either<Failure, GetApartmentReviews>> getApartmentReviews({
    required int propertyId,
    int? page,
    int? pageSize,
    String? sortBy= 'All',
    String? search,
  });

  Future<Either<Failure, WriteReviewResponse>> writeReview({required WriteReviewRequest request});
}