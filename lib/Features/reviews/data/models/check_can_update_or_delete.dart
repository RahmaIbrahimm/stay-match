/// isSuccess : true
/// message : "Request successful"
/// data : {"canUpdate":true,"canDelete":true,"message":"Allowed"}

class CheckCanUpdateOrDelete {
  CheckCanUpdateOrDelete({
      this.isSuccess, 
      this.message, 
      this.data,});

  CheckCanUpdateOrDelete.fromJson(dynamic json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? isSuccess;
  String? message;
  Data? data;
CheckCanUpdateOrDelete copyWith({  bool? isSuccess,
  String? message,
  Data? data,
}) => CheckCanUpdateOrDelete(  isSuccess: isSuccess ?? this.isSuccess,
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

/// canUpdate : true
/// canDelete : true
/// message : "Allowed"

class Data {
  Data({
      this.canUpdate, 
      this.canDelete, 
      this.message,});

  Data.fromJson(dynamic json) {
    canUpdate = json['canUpdate'];
    canDelete = json['canDelete'];
    message = json['message'];
  }
  bool? canUpdate;
  bool? canDelete;
  String? message;
Data copyWith({  bool? canUpdate,
  bool? canDelete,
  String? message,
}) => Data(  canUpdate: canUpdate ?? this.canUpdate,
  canDelete: canDelete ?? this.canDelete,
  message: message ?? this.message,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['canUpdate'] = canUpdate;
    map['canDelete'] = canDelete;
    map['message'] = message;
    return map;
  }

}