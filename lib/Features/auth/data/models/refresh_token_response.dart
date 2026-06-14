/// isSuccess : false
/// message : "Invalid refresh token"
/// token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6IjExMjFjMzQyLWRkN2EtNGEyOS1iYzY2LWM5NGY2YWE0MzIxMiIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL25hbWUiOiJhYmFub3ViIHlvdXNyeSIsImVtYWlsIjoidXNlckBleGFtcGxlLmNvbSIsImp0aSI6ImE2YTU0Y2Y3LTNmOWQtNGE5Ny04M2U2LWZjNTVkNjgzNTMyYSIsImh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vd3MvMjAwOC8wNi9pZGVudGl0eS9jbGFpbXMvcm9sZSI6IlVzZXIiLCJleHAiOjE3NzM5NzQ5NjUsImlzcyI6IkFQSVNlY3VyZUlzc3VyZSIsImF1ZCI6IkFQSVNlY3VyZUF1ZGllbmNlIn0.2mkUNTfyn5gLJgC1pgwZkPScFt40IJYbAhYpENYKcMM"
/// refreshToken : "WihssXYSgbEEZFf/Mu9gDSbNJj6AyHs7dcvQ2hc+aWkkeSAqS3adb/Qdvs1jH4yUySCOcF0kvyVbwN2mPgbjTQ=="

class RefreshTokenResponse {
  RefreshTokenResponse({
    this.isSuccess,
    this.message,
    this.token,
    this.refreshToken,
  });

  RefreshTokenResponse.fromJson(dynamic json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    token = json['token'];
    refreshToken = json['refreshToken'];
  }
  bool? isSuccess;
  String? message;
  String? token;
  String? refreshToken;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['isSuccess'] = isSuccess;
    map['message'] = message;
    map['token'] = token;
    map['refreshToken'] = refreshToken;
    return map;
  }
}