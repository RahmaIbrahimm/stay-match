/// isSuccess : true
/// message : "Request successful"
/// data : {"rooms":1,"wholeApartments":1,"sharedHouses":0}

class SavedCountResponse {
  SavedCountResponse({
      this.isSuccess, 
      this.message, 
      this.data,});

  SavedCountResponse.fromJson(dynamic json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? isSuccess;
  String? message;
  Data? data;
SavedCountResponse copyWith({  bool? isSuccess,
  String? message,
  Data? data,
}) => SavedCountResponse(  isSuccess: isSuccess ?? this.isSuccess,
  message: message ?? this.message,
  data: data ?? this.data,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['isSuccess'] = isSuccess;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

/// rooms : 1
/// wholeApartments : 1
/// sharedHouses : 0

class Data {
  Data({
      this.rooms, 
      this.wholeApartments, 
      this.sharedHouses,});

  Data.fromJson(dynamic json) {
    rooms = json['rooms'];
    wholeApartments = json['wholeApartments'];
    sharedHouses = json['sharedHouses'];
  }
  int? rooms;
  int? wholeApartments;
  int? sharedHouses;
Data copyWith({  int? rooms,
  int? wholeApartments,
  int? sharedHouses,
}) => Data(  rooms: rooms ?? this.rooms,
  wholeApartments: wholeApartments ?? this.wholeApartments,
  sharedHouses: sharedHouses ?? this.sharedHouses,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['rooms'] = rooms;
    map['wholeApartments'] = wholeApartments;
    map['sharedHouses'] = sharedHouses;
    return map;
  }

}