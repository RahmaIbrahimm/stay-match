/// isSuccess : false
/// message : "Some required fields are missing"
/// data : {"propertyId":140,"message":"Shared property added successfully!"}
/// errors : {"dto":["The dto field is required."],"rooms[0].allowedTenants.studentGender":["The JSON value could not be converted to System.Nullable`1[Graduation_Project.DTOs.ProbertyDto.AllowedTenantsDto+gender]. Path: $.rooms[0].allowedTenants.studentGender | LineNumber: 83 | BytePositionInLine: 33."]}

class AddRoomResponse {
  AddRoomResponse({
      this.isSuccess, 
      this.message, 
      this.data, 
      this.errors,});

  AddRoomResponse.fromJson(dynamic json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    data = json['data'] != null ? AddRoomData.fromJson(json['data']) : null;
    errors = json['errors'] != null ? Errors.fromJson(json['errors']) : null;
  }
  bool? isSuccess;
  String? message;
  AddRoomData? data;
  Errors? errors;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['isSuccess'] = isSuccess;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    if (errors != null) {
      map['errors'] = errors?.toJson();
    }
    return map;
  }

}

/// dto : ["The dto field is required."]
/// rooms[0].allowedTenants.studentGender : ["The JSON value could not be converted to System.Nullable`1[Graduation_Project.DTOs.ProbertyDto.AllowedTenantsDto+gender]. Path: $.rooms[0].allowedTenants.studentGender | LineNumber: 83 | BytePositionInLine: 33."]

class Errors {
  Errors({
      this.dto, 
      this.rooms0allowedTenantsstudentGender,});

  Errors.fromJson(dynamic json) {
    dto = json['dto'] != null ? json['dto'].cast<String>() : [];
    rooms0allowedTenantsstudentGender = json['rooms[0].allowedTenants.studentGender'] != null ? json['rooms[0].allowedTenants.studentGender'].cast<String>() : [];
  }
  List<String>? dto;
  List<String>? rooms0allowedTenantsstudentGender;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['dto'] = dto;
    map['rooms[0].allowedTenants.studentGender'] = rooms0allowedTenantsstudentGender;
    return map;
  }

}

/// propertyId : 140
/// message : "Shared property added successfully!"

class AddRoomData {
  AddRoomData({
      this.propertyId, 
      this.message,});

  AddRoomData.fromJson(dynamic json) {
    propertyId = json['propertyId'];
    message = json['message'];
  }
  int? propertyId;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['propertyId'] = propertyId;
    map['message'] = message;
    return map;
  }

}