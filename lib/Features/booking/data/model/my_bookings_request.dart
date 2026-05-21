/// status : "s"
/// location : "egypt"
/// year : 2003
/// month : 3
/// day : 2
/// page : 1
/// pageSize : 10

class MyBookingsRequest {
  MyBookingsRequest({
      this.status, 
      this.location, 
      this.year, 
      this.month, 
      this.day, 
      this.page, 
      this.pageSize,});

  MyBookingsRequest.fromJson(dynamic json) {
    status = json['status'];
    location = json['location'];
    year = json['year'];
    month = json['month'];
    day = json['day'];
    page = json['page'];
    pageSize = json['pageSize'];
  }
  String? status;
  String? location;
  int? year;
  int? month;
  int? day;
  int? page;
  int? pageSize;
MyBookingsRequest copyWith({  String? status,
  String? location,
  int? year,
  int? month,
  int? day,
  int? page,
  int? pageSize,
}) => MyBookingsRequest(  status: status ?? this.status,
  location: location ?? this.location,
  year: year ?? this.year,
  month: month ?? this.month,
  day: day ?? this.day,
  page: page ?? this.page,
  pageSize: pageSize ?? this.pageSize,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['location'] = location;
    map['year'] = year;
    map['month'] = month;
    map['day'] = day;
    map['page'] = page;
    map['pageSize'] = pageSize;
    return map;
  }

}