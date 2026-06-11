abstract class Endpoints {
  static const String baseUrl = 'https://graduationproject1.runasp.net';
  // auth
  static const String login = '/login';
  static const String forgetPassword = '/api/Account/forgot-password';
  static const String verifyCode = '/api/Account/verify-code';
  static const String resetPassword = '/api/Account/reset-password';
  static const String googleLogin = '/api/Account/google-login';
  static const String register = '/register';
  // home
  static const String getAllRooms = '/api/Property/GetAllWithRooms';
  static const String getAllApartments = '/api/Property';
  static const String getPropertyDetails = '/api/Property/';
  static const String refreshToken = '/api/Account/refresh-token';
  static const String logout = '/api/Account/logout-all';
  // chat
  static const String chatHubPath = 'https://graduationproject1.runasp.net/chatHub';
  static const String myChats = '/api/Chat/mychats';
  static const String startChat = '/api/Chat/start';
  static const String markRead = '/api/Chat/mark-as-read';
  static const String sendMessage = '/api/Chat/send';
  static const String searchChats = '/api/Chat/search';
  // add Property
  static const String addApartment = '/api/Property/AddEntireProperty';
  static const String addRoom = '/api/Property/AddSharedProperty';
  static const String uploadImage = '/api/Property/upload-image';
  static const String myProperties = '/api/Property/MyProperty';
  // profile
  static const String profileData = '/api/UserProfile';
  static const String updateProfile = '/api/UserProfile';
  static const String updateProfilePic = '/api/UserProfile/UpdateProfilePicture';
  static const String uploadProfilePic = '/api/UserProfile/UploadProfilePicture';
  static const String deleteAccount = '/api/UserProfile/delete-account';
  static const String deleteProfilePic = '/api/UserProfile/DeleteProfilePicture';
  // booking
  static const String  requestApartmentBooking= '/api/Booking/entire-apartment';
  static const String  requestRoomBooking= '/api/Booking/room';
  static const String  recommendedProperties= '/api/Saved/recommended';
  static const String  mySavedProperties= '/api/Saved/my-saved';
  static const String  savedPropertiesCount= '/api/Saved/count';
  static const String  toggleSavedApartment= '/api/Saved/toggle';
  static const String  toggleSavedRoom= '/api/Saved/save-room';
  static const String renterBookingRequests = '/api/Booking/my-bookings';
  static const String hostBookingRequests = '/api/Booking/host-requests';
  static String Function(int) approveBookingRequests = (int id) {
    return "/api/Booking/$id/approve";
  };
  static String Function(int) declineBookingRequests = (int id) {
    return "/api/Booking/$id/decline";
  };
  static String Function(int) renterCancelBookingRequests = (int id) {
    return "/api/Booking/$id/cancel";
  };
  static String Function(int) deleteBookingRequests = (int id) {
    return "/api/Booking/$id";
  };
  static String Function(int) updateEntireProperty = (int id) {
    return "/api/Property/UpdateEntireProperty/$id";
  };
  static String Function(int) updateSharedProperty = (int id) {
    return "/api/Property/UpdateSharedProperty/$id";
  };
  static String Function(int) deleteProperty = (int id) {
    return "/api/Property/properties/$id";
  };
  // home search
  static const String homeSearch = '/api/Property/search';
  // reviews
  static String Function(int) getApartmentReviews = (int id) {
    return "/api/Review/property/$id";
  };
  static String addReview = '/api/Review/AddReview';
  // client ids uses for google login
  static const String webClientId =
      '936135595361-tkjd357n4h18pd6pc4pfoch6rto0vlh5.apps.googleusercontent.com';
  static const String androidClientId =
      '936135595361-h3462ve7821dq8hcqamq5f3i632qruf9.apps.googleusercontent.com';
  static const String chatApiKey = '3dumrx9thsgm';
  static const String mapsApiKey = 'AIzaSyBwB2ppYr6L3eXhGoRaql8iNdxIjTzvT3g';
  static const String placesApiKey = 'AIzaSyD3WRKYi-q6lImsJKkUcZ5uU07vfYEWq2M';
}