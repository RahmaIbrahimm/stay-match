/// isSuccess : true
/// message : "Request successful"
/// data : {"saved":true,"message":"apartment saved successfully","type":"property"}

class ToggleSavedResponse {
  ToggleSavedResponse({
      this.isSuccess, 
      this.message, 
      this.data,});

  ToggleSavedResponse.fromJson(dynamic json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? isSuccess;
  String? message;
  Data? data;
ToggleSavedResponse copyWith({  bool? isSuccess,
  String? message,
  Data? data,
}) => ToggleSavedResponse(  isSuccess: isSuccess ?? this.isSuccess,
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

/// saved : true
/// message : "apartment saved successfully"
/// type : "property"

class Data {
  Data({
      this.saved, 
      this.message, 
      this.type,});

  Data.fromJson(dynamic json) {
    saved = json['saved'];
    message = json['message'];
    type = json['type'];
  }
  bool? saved;
  String? message;
  String? type;
Data copyWith({  bool? saved,
  String? message,
  String? type,
}) => Data(  saved: saved ?? this.saved,
  message: message ?? this.message,
  type: type ?? this.type,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['saved'] = saved;
    map['message'] = message;
    map['type'] = type;
    return map;
  }

}