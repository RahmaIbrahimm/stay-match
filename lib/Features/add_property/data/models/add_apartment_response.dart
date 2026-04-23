/// isSuccess : false
/// message : "Some required fields are missing"
/// data : {"propertyId":139,"message":"Entire property added successfully!"}
/// errors : {"dto":["The dto field is required."],"allowedTenants.studentGender":["The JSON value could not be converted to System.Nullable`1[Graduation_Project.DTOs.ProbertyDto.AllowedTenantsDto+gender]. Path: $.allowedTenants.studentGender | LineNumber: 15 | BytePositionInLine: 29."],"Name":["Name must be at least 10 characters."]}

class AddApartmentResponse {
  AddApartmentResponse({
      this.isSuccess, 
      this.message, 
      this.data, 
      this.errors,});

  AddApartmentResponse.fromJson(dynamic json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    data = json['data'] != null ? AddApartmentData.fromJson(json['data']) : null;
    errors = json['errors'] != null ? Errors.fromJson(json['errors']) : null;
  }
  bool? isSuccess;
  String? message;
  AddApartmentData? data;
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
/// allowedTenants.studentGender : ["The JSON value could not be converted to System.Nullable`1[Graduation_Project.DTOs.ProbertyDto.AllowedTenantsDto+gender]. Path: $.allowedTenants.studentGender | LineNumber: 15 | BytePositionInLine: 29."]
/// Name : ["Name must be at least 10 characters."]

class Errors {
  Errors({
      this.dto, 
      this.allowedTenantsstudentGender, 
      this.name,});

  Errors.fromJson(dynamic json) {
    dto = json['dto'] != null ? json['dto'].cast<String>() : [];
    allowedTenantsstudentGender = json['allowedTenants.studentGender'] != null ? json['allowedTenants.studentGender'].cast<String>() : [];
    name = json['Name'] != null ? json['Name'].cast<String>() : [];
  }
  List<String>? dto;
  List<String>? allowedTenantsstudentGender;
  List<String>? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['dto'] = dto;
    map['allowedTenants.studentGender'] = allowedTenantsstudentGender;
    map['Name'] = name;
    return map;
  }

}

/// propertyId : 139
/// message : "Entire property added successfully!"

class AddApartmentData {
  AddApartmentData({
      this.propertyId, 
      this.message,});

  AddApartmentData.fromJson(dynamic json) {
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