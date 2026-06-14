import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:stay_match/Features/reviews/data/models/get_apartment_reviews.dart';
import 'package:stay_match/Features/reviews/data/models/review_recommendations.dart';
import 'package:stay_match/Features/reviews/data/models/write_review_response.dart';
import 'package:stay_match/Features/reviews/data/repos/reviews_repo.dart';
import 'package:stay_match/core/errors/failures.dart';
import 'package:stay_match/core/networking/api_service.dart';

import '../../../../core/networking/endpoints.dart';
import '../models/write_review_request.dart';

class ReviewsRepoImpl extends ReviewsRepo {
  final ApiService apiService;

  ReviewsRepoImpl({required this.apiService});

  @override
  Future<Either<Failure, GetApartmentReviews>> getApartmentReviews({
    required int propertyId,
    int? page,
    int? pageSize,
    String? sortBy, // Remove the default value 'All' here
    String? search,
  }) async {
    try {
      // 1. Initialize with required fields
      final Map<String, dynamic> queryParameters = {
        'page': page,
        'pageSize': pageSize,
      };

      // 2. Only add sortBy if it's not null and not 'All'
      // (Assuming 'All' is what you want to omit)
      if (sortBy != null && sortBy.isNotEmpty && sortBy != 'All') {
        queryParameters['sortBy'] = sortBy;
      }

      // 3. Only add search if it's not null and not empty
      if (search != null && search.isNotEmpty) {
        queryParameters['search'] = search;
      }

      final response = await apiService.get(
        Endpoints.getApartmentReviews(propertyId),
        queryParameters: queryParameters, // This map now only contains valid keys
      );

      return Right(GetApartmentReviews.fromJson(response));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    }
  }

  @override
  Future<Either<Failure, WriteReviewResponse>> writeReview({required WriteReviewRequest request})async {
    try {
      final response = await apiService.post(
        Endpoints.addReview,
        data: request.toJson(),
      );
      return Right(WriteReviewResponse.fromJson(response));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    }
  }

  @override
  Future<Either<Failure, ReviewRecommendations>> getRecommendations() async{
    try {
      final response = await apiService.get(
        Endpoints.reviewRecommendations,
      );
      return Right(ReviewRecommendations.fromJson(response));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    }
  }
}