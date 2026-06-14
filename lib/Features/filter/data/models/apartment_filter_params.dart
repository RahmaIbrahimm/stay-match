// Create a dedicated filter model
import 'dart:developer';

import '../../../apartments/data/models/all_apartments_response.dart';
import '../../../rooms/data/repos/rooms_repo.dart';
import '../../presentation/manager/filter_cubit.dart';

class ApartmentFilterParams {
  final String? start;
  final int? monthsCount;
  final String? government;
  final bool? allowsFamilies;
  final bool? allowsChildren;
  final bool? allowsStudents;
  final bool? allowsWorkers;
  final String? workerGender;
  final String? studentGender;
  final double? userLat;
  final double? userLng;
  final bool orderByOldest;
  final bool onlyAvailable;
  final num? page;
  final num? pageSize;

  const ApartmentFilterParams({
    this.start,
    this.monthsCount,
    this.government,
    this.allowsFamilies,
    this.allowsChildren,
    this.allowsStudents,
    this.allowsWorkers,
    this.workerGender,
    this.studentGender,
    this.userLat,
    this.userLng,
    this.orderByOldest = false,
    this.onlyAvailable = false,
    this.page = 1,
    this.pageSize = 10,
  });

  // Helper to check if any filter changed
  bool hasChanges(ApartmentFilterParams? other) {
    if (other == null) return true;
    return start != other.start ||
        monthsCount != other.monthsCount ||
        government != other.government ||
        allowsFamilies != other.allowsFamilies ||
        allowsChildren != other.allowsChildren ||
        allowsStudents != other.allowsStudents ||
        allowsWorkers != other.allowsWorkers ||
        workerGender != other.workerGender ||
        studentGender != other.studentGender ||
        userLat != other.userLat ||
        userLng != other.userLng ||
        orderByOldest != other.orderByOldest ||
        onlyAvailable != other.onlyAvailable ||
        page != other.page ||
        pageSize != other.pageSize;
  }

  // Create a copy with updated values
  ApartmentFilterParams copyWith({
    String? start,
    int? monthsCount,
    String? government,
    bool? allowsFamilies,
    bool? allowsChildren,
    bool? allowsStudents,
    bool? allowsWorkers,
    String? workerGender,
    String? studentGender,
    double? userLat,
    double? userLng,
    bool? orderByOldest,
    bool? onlyAvailable,
    num? page,
    num? pageSize,
  }) {
    return ApartmentFilterParams(
      start: start ?? this.start,
      monthsCount: monthsCount ?? this.monthsCount,
      government: government ?? this.government,
      allowsFamilies: allowsFamilies ?? this.allowsFamilies,
      allowsChildren: allowsChildren ?? this.allowsChildren,
      allowsStudents: allowsStudents ?? this.allowsStudents,
      allowsWorkers: allowsWorkers ?? this.allowsWorkers,
      workerGender: workerGender ?? this.workerGender,
      studentGender: studentGender ?? this.studentGender,
      userLat: userLat ?? this.userLat,
      userLng: userLng ?? this.userLng,
      orderByOldest: orderByOldest ?? this.orderByOldest,
      onlyAvailable: onlyAvailable ?? this.onlyAvailable,
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
    );
  }
}