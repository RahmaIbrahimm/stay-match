abstract class Endpoints {
  static const String baseUrl = 'https://graduationproject1.runasp.net/';
  // auth
  static const String login = 'login';
  static const String forgetPassword = 'api/Account/forgot-password';
  static const String verifyCode = 'api/Account/verify-code';
  static const String resetPassword = 'api/Account/reset-password';
  static const String googleLogin = 'api/Account/google-login';
  static const String register = 'register';
  // home
  static const String getAllRooms = 'api/Property/GetAllWithRooms';
  static const String getAllApartments = 'api/Property';

  // client ids uses for google login
  static const String webClientId= '936135595361-tkjd357n4h18pd6pc4pfoch6rto0vlh5.apps.googleusercontent.com';
  static const String androidClientId= '936135595361-h3462ve7821dq8hcqamq5f3i632qruf9.apps.googleusercontent.com';
}