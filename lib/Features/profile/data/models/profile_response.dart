/// success : true
/// message : "User profile retrieved successfully"
/// data : {"fullName":"Rahma Ibrahim","firstName":"Rahma","lastName":"Ibrahim","email":"rahmaibrahim315@gmail.com","phoneNumber":null,"gender":null,"birthDate":"0001-01-01T00:00:00","city":null,"governorate":null,"university":null,"fieldOfStudy":null,"jobTitle":null,"profilePicture":null,"isVerified":null,"isProfileComplete":false}

class ProfileResponse {
  ProfileResponse({
      this.success, 
      this.message, 
      this.data,});

  ProfileResponse.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? ProfileRespData.fromJson(json['data']) : null;
  }
  bool? success;
  String? message;
  ProfileRespData? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
  ProfileResponse copyWith({
    bool? success,
    String? message,
    ProfileRespData? data,
  }) {
    return ProfileResponse(
      success: success ?? this.success,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }
}

/// fullName : "Rahma Ibrahim"
/// firstName : "Rahma"
/// lastName : "Ibrahim"
/// email : "rahmaibrahim315@gmail.com"
/// phoneNumber : null
/// gender : null
/// birthDate : "0001-01-01T00:00:00"
/// city : null
/// governorate : null
/// university : null
/// fieldOfStudy : null
/// jobTitle : null
/// profilePicture : null
/// isVerified : null
/// isProfileComplete : false

class ProfileRespData {
  ProfileRespData({
      this.fullName, 
      this.firstName, 
      this.lastName, 
      this.email, 
      this.phoneNumber, 
      this.gender, 
      this.birthDate, 
      this.city, 
      this.governorate, 
      this.university, 
      this.fieldOfStudy, 
      this.jobTitle, 
      this.aboutMe,
      this.status,
      this.profilePicture,
      this.idImage,
      this.isProfileComplete,
  });

  ProfileRespData.fromJson(dynamic json) {
    fullName = json['fullName'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    gender = json['gender'];
    birthDate = json['birthDate'];
    city = json['city'];
    governorate = json['governorate'];
    university = json['university'];
    fieldOfStudy = json['fieldOfStudy'];
    jobTitle = json['jobTitle'];
    aboutMe = json['aboutMe'];
    status = json['status'];
    profilePicture = json['profilePicture'];
    idImage = json['idImage'];
    isVerified = json['isVerified'];
    isProfileComplete = json['isProfileComplete'];
  }
  String? fullName;
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  String? gender;
  String? birthDate;
  String? city;
  String? governorate;
  String? university;
  String? fieldOfStudy;
  String? jobTitle;
  String? aboutMe;
  String? status;
  String? profilePicture;
  String? idImage;
  bool? isVerified;
  bool? isProfileComplete;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['fullName'] = fullName;
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['email'] = email;
    map['phoneNumber'] = phoneNumber;
    map['gender'] = gender;
    map['birthDate'] = birthDate;
    map['city'] = city;
    map['governorate'] = governorate;
    map['university'] = university;
    map['fieldOfStudy'] = fieldOfStudy;
    map['jobTitle'] = jobTitle;
    map['aboutMe'] = aboutMe;
    map['status'] = status;
    map['profilePicture'] = profilePicture;
    map['idImage'] = idImage;
    map['isVerified'] = isVerified;
    map['isProfileComplete'] = isProfileComplete;
    return map;
  }
  ProfileRespData copyWith({
    String? fullName,
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? gender,
    String? birthDate,
    String? city,
    String? governorate,
    String? university,
    String? fieldOfStudy,
    String? jobTitle,
    String? aboutMe,
    String? status,
    String? profilePicture,
    String? idImage,
    bool? isVerified,
    bool? isProfileComplete,
  }) {
    return ProfileRespData(
      fullName: fullName ?? this.fullName,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      gender: gender ?? this.gender,
      birthDate: birthDate ?? this.birthDate,
      city: city ?? this.city,
      governorate: governorate ?? this.governorate,
      university: university ?? this.university,
      fieldOfStudy: fieldOfStudy ?? this.fieldOfStudy,
      jobTitle: jobTitle ?? this.jobTitle,
      aboutMe: aboutMe ?? this.aboutMe,
      status: status ?? this.status,
      profilePicture: profilePicture ?? this.profilePicture,
      idImage: idImage ?? this.idImage,
      isProfileComplete: isProfileComplete ?? this.isProfileComplete,
    );
  }
}