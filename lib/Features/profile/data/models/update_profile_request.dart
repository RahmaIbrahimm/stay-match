/// firstName : "string"
/// lastName : "string"
/// fullName : "string"
/// email : "user@example.com"
/// phoneNumber : "string"
/// gender : "Male"
/// birthDate : "2026-04-20T11:14:43.716Z"
/// city : "string"
/// governorate : "string"
/// university : "string"
/// fieldOfStudy : "string"
/// jobTitle : "string"
/// password : "string"
/// passwordConfirmation : "string"

class UpdateProfileRequest {
  UpdateProfileRequest({
      this.firstName, 
      this.lastName, 
      this.fullName, 
      this.email, 
      this.phoneNumber, 
      this.gender, 
      this.birthDate, 
      this.city, 
      this.governorate, 
      this.university, 
      this.fieldOfStudy, 
      this.jobTitle, 
      this.password, 
      this.passwordConfirmation,});

  UpdateProfileRequest.fromJson(dynamic json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    fullName = json['fullName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    gender = json['gender'];
    birthDate = json['birthDate'];
    city = json['city'];
    governorate = json['governorate'];
    university = json['university'];
    fieldOfStudy = json['fieldOfStudy'];
    jobTitle = json['jobTitle'];
    password = json['password'];
    passwordConfirmation = json['passwordConfirmation'];
  }
  String? firstName;
  String? lastName;
  String? fullName;
  String? email;
  String? phoneNumber;
  String? gender;
  String? birthDate;
  String? city;
  String? governorate;
  String? university;
  String? fieldOfStudy;
  String? jobTitle;
  String? password;
  String? passwordConfirmation;
UpdateProfileRequest copyWith({  String? firstName,
  String? lastName,
  String? fullName,
  String? email,
  String? phoneNumber,
  String? gender,
  String? birthDate,
  String? city,
  String? governorate,
  String? university,
  String? fieldOfStudy,
  String? jobTitle,
  String? password,
  String? passwordConfirmation,
}) => UpdateProfileRequest(  firstName: firstName ?? this.firstName,
  lastName: lastName ?? this.lastName,
  fullName: fullName ?? this.fullName,
  email: email ?? this.email,
  phoneNumber: phoneNumber ?? this.phoneNumber,
  gender: gender ?? this.gender,
  birthDate: birthDate ?? this.birthDate,
  city: city ?? this.city,
  governorate: governorate ?? this.governorate,
  university: university ?? this.university,
  fieldOfStudy: fieldOfStudy ?? this.fieldOfStudy,
  jobTitle: jobTitle ?? this.jobTitle,
  password: password ?? this.password,
  passwordConfirmation: passwordConfirmation ?? this.passwordConfirmation,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['fullName'] = fullName;
    map['email'] = email;
    map['phoneNumber'] = phoneNumber;
    map['gender'] = gender;
    map['birthDate'] = birthDate;
    map['city'] = city;
    map['governorate'] = governorate;
    map['university'] = university;
    map['fieldOfStudy'] = fieldOfStudy;
    map['jobTitle'] = jobTitle;
    map['password'] = password;
    map['passwordConfirmation'] = passwordConfirmation;
    return map;
  }

}