import 'package:dartz/dartz.dart';
import 'package:stay_match/Features/saved/data/models/my_saved_response.dart';
import 'package:stay_match/Features/saved/data/models/room_toggle_saved_response.dart';
import 'package:stay_match/Features/saved/data/models/saved_count_response.dart';
import 'package:stay_match/core/errors/failures.dart';

import '../models/recommended_properties_response.dart';
import '../models/toggle_saved_response.dart';

abstract class SavedPropertiesRepo{

  Future<Either<Failure,ToggleSavedResponse>> toggleSavedApartment({required int propertyId});
  Future<Either<Failure,RoomToggleSavedResponse>> toggleSavedRoom({required int propertyId,required int roomId});
  Future<Either<Failure,MySavedResponse>> getSavedProperties({String? type,int page = 1,int pageSize = 10,String? search});
  Future<Either<Failure,SavedCountResponse>> getSavedPropertiesCount();
  Future<Either<Failure, RecommendedPropertiesResponse>> getRecommendedProperties({int limit = 2});

}