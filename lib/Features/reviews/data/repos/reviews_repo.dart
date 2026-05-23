import 'package:dartz/dartz.dart';
import 'package:stay_match/Features/reviews/data/models/get_apartment_reviews.dart';
import 'package:stay_match/core/errors/failures.dart';

abstract class ReviewsRepo {
  Future<Either<Failure, GetApartmentReviews>> getApartmentReviews({
    required int propertyId,
    int? page,
    int? pageSize,
    String? sortBy= 'All',
    String? search,
  });
}