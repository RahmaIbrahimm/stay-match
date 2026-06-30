// rooms_filter_params.dart
class RoomsFilterParams {
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

  const RoomsFilterParams({
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

  bool hasChanges(RoomsFilterParams? other) {
    if (other == null) return true;
    return start != other.start ||
        monthsCount != other.monthsCount ||
        government != other.government ||
        allowsFamilies != other.allowsFamilies ||
        allowsChildren != other.allowsChildren ||
        allowsStudents != other.allowsStudents ||
        allowsWorkers != other.allowsWorkers ||
        workerGender != other.workerGender ||
        userLat != other.userLat ||
        userLng != other.userLng ||
        orderByOldest != other.orderByOldest ||
        onlyAvailable != other.onlyAvailable ||
        page != other.page ||
        pageSize != other.pageSize;
  }
  static const _clear = Object();

  RoomsFilterParams copyWith({
    Object? government = _clear,
    Object? userLat = _clear,
    Object? userLng = _clear,
    String? start,
    int? monthsCount,
    // String? government,
    bool? allowsFamilies,
    bool? allowsChildren,
    bool? allowsStudents,
    bool? allowsWorkers,
    String? workerGender,
    String? studentGender,
    // double? userLat,
    // double? userLng,
    bool? orderByOldest,
    bool? onlyAvailable,
    num? page,
    num? pageSize,
  }) {
    return RoomsFilterParams(
      government: government == _clear ? this.government : government as String?,
      userLat: userLat == _clear ? this.userLat : userLat as double?,
      userLng: userLng == _clear ? this.userLng : userLng as double?,
      start: start ?? this.start,
      monthsCount: monthsCount ?? this.monthsCount,
      // government: government ?? this.government,
      allowsFamilies: allowsFamilies ?? this.allowsFamilies,
      allowsChildren: allowsChildren ?? this.allowsChildren,
      allowsStudents: allowsStudents ?? this.allowsStudents,
      allowsWorkers: allowsWorkers ?? this.allowsWorkers,
      workerGender: workerGender ?? this.workerGender,
      studentGender: studentGender ?? this.studentGender,
      // userLat: userLat ?? this.userLat,
      // userLng: userLng ?? this.userLng,
      orderByOldest: orderByOldest ?? this.orderByOldest,
      onlyAvailable: onlyAvailable ?? this.onlyAvailable,
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
    );
  }
}