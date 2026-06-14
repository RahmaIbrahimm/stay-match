import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:stay_match/Features/filter/data/models/location_model.dart';
import 'package:stay_match/core/errors/failures.dart';

import 'location_repo.dart';

class LocationRepoImpl extends LocationRepo {
  @override
  Future<Either<Failure, List<Governorate>>> getGovernorates() async {
    try {
      final String jsonString = await rootBundle.loadString(
        'assets/json/locations.json',
      );
      final List<dynamic> jsonList = json.decode(jsonString);
      return right(jsonList.map((gov) => Governorate.fromJson(gov)).toList());
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }
}