/// isSuccess : true
/// message : "Login successful"
/// data : {"token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI5YjFkOGY0Ny0zMTI5LTQ3NTMtYWM2MS03YmQ3YWI0YzYwMGUiLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6IjliMWQ4ZjQ3LTMxMjktNDc1My1hYzYxLTdiZDdhYjRjNjAwZSIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL25hbWUiOiJSYWhtYSBJYnJhaGltIiwiZW1haWwiOiJyYWhtYWlicmFoaW0zMTVAZ21haWwuY29tIiwianRpIjoiNzhhNzhkNWYtYjdhYy00NjE1LTk2MWItMDBiMmRmNmEzYjBjIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjoiVXNlciIsImV4cCI6MTc4MjIxMzYzNSwiaXNzIjoiQVBJU2VjdXJlSXNzdXJlIiwiYXVkIjoiQVBJU2VjdXJlQXVkaWVuY2UifQ.XCipM_DrgcRkCKBCRGACuJVDaOQJvNx7Xf_GNkkNHTQ","refreshToken":"ZU7/BdQEDYfySbTTPpD9ETrTSRPmLRs2+2NFXPHw+Udlhlpprmq0RC3ZK2Capve2UfEUqoSiMR8TDZBYorTETQ==","expiration":"2026-06-23T11:20:37.820723Z","email":"rahmaibrahim315@gmail.com","displayName":"Rahma Ibrahim","otherUserProfileImageUrl":"https://graduationproject1.runasp.net/images/87fc98bc-09fa-4dc7-abe4-a60753c14308.png","userId":"9b1d8f47-3129-4753-ac61-7bd7ab4c600e","questionsCompleted":true,"profileComplete":true}

class LoginWithGoogleResponse {
  LoginWithGoogleResponse({
      this.isSuccess, 
      this.message, 
      this.data,});

  LoginWithGoogleResponse.fromJson(dynamic json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    data = json['data'] != null ? LoginWithGoogleRespData.fromJson(json['data']) : null;
  }
  bool? isSuccess;
  String? message;
  LoginWithGoogleRespData? data;
LoginWithGoogleResponse copyWith({  bool? isSuccess,
  String? message,
  LoginWithGoogleRespData? data,
}) => LoginWithGoogleResponse(  isSuccess: isSuccess ?? this.isSuccess,
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

/// token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI5YjFkOGY0Ny0zMTI5LTQ3NTMtYWM2MS03YmQ3YWI0YzYwMGUiLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6IjliMWQ4ZjQ3LTMxMjktNDc1My1hYzYxLTdiZDdhYjRjNjAwZSIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL25hbWUiOiJSYWhtYSBJYnJhaGltIiwiZW1haWwiOiJyYWhtYWlicmFoaW0zMTVAZ21haWwuY29tIiwianRpIjoiNzhhNzhkNWYtYjdhYy00NjE1LTk2MWItMDBiMmRmNmEzYjBjIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjoiVXNlciIsImV4cCI6MTc4MjIxMzYzNSwiaXNzIjoiQVBJU2VjdXJlSXNzdXJlIiwiYXVkIjoiQVBJU2VjdXJlQXVkaWVuY2UifQ.XCipM_DrgcRkCKBCRGACuJVDaOQJvNx7Xf_GNkkNHTQ"
/// refreshToken : "ZU7/BdQEDYfySbTTPpD9ETrTSRPmLRs2+2NFXPHw+Udlhlpprmq0RC3ZK2Capve2UfEUqoSiMR8TDZBYorTETQ=="
/// expiration : "2026-06-23T11:20:37.820723Z"
/// email : "rahmaibrahim315@gmail.com"
/// displayName : "Rahma Ibrahim"
/// otherUserProfileImageUrl : "https://graduationproject1.runasp.net/images/87fc98bc-09fa-4dc7-abe4-a60753c14308.png"
/// userId : "9b1d8f47-3129-4753-ac61-7bd7ab4c600e"
/// questionsCompleted : true
/// profileComplete : true

class LoginWithGoogleRespData {
  LoginWithGoogleRespData({
      this.token, 
      this.refreshToken, 
      this.expiration, 
      this.email, 
      this.displayName, 
      this.otherUserProfileImageUrl, 
      this.userId, 
      this.questionsCompleted, 
      this.profileComplete,});

  LoginWithGoogleRespData.fromJson(dynamic json) {
    token = json['token'];
    refreshToken = json['refreshToken'];
    expiration = json['expiration'];
    email = json['email'];
    displayName = json['displayName'];
    otherUserProfileImageUrl = json['otherUserProfileImageUrl'];
    userId = json['userId'];
    questionsCompleted = json['questionsCompleted'];
    profileComplete = json['profileComplete'];
  }
  String? token;
  String? refreshToken;
  String? expiration;
  String? email;
  String? displayName;
  String? otherUserProfileImageUrl;
  String? userId;
  bool? questionsCompleted;
  bool? profileComplete;
LoginWithGoogleRespData copyWith({  String? token,
  String? refreshToken,
  String? expiration,
  String? email,
  String? displayName,
  String? otherUserProfileImageUrl,
  String? userId,
  bool? questionsCompleted,
  bool? profileComplete,
}) => LoginWithGoogleRespData(  token: token ?? this.token,
  refreshToken: refreshToken ?? this.refreshToken,
  expiration: expiration ?? this.expiration,
  email: email ?? this.email,
  displayName: displayName ?? this.displayName,
  otherUserProfileImageUrl: otherUserProfileImageUrl ?? this.otherUserProfileImageUrl,
  userId: userId ?? this.userId,
  questionsCompleted: questionsCompleted ?? this.questionsCompleted,
  profileComplete: profileComplete ?? this.profileComplete,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token'] = token;
    map['refreshToken'] = refreshToken;
    map['expiration'] = expiration;
    map['email'] = email;
    map['displayName'] = displayName;
    map['otherUserProfileImageUrl'] = otherUserProfileImageUrl;
    map['userId'] = userId;
    map['questionsCompleted'] = questionsCompleted;
    map['profileComplete'] = profileComplete;
    return map;
  }

}