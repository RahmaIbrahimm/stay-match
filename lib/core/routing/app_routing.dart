// import 'package:flutter/cupertino.dart';
// import 'package:go_router/go_router.dart';
// import 'package:stay_match/core/widgets/layout_scaffold.dart';
// import 'package:stay_match/Features/auth/presentation/reset_password/presentation/views/reset_password_view.dart';
// import 'package:stay_match/Features/home/presentation/views/home_view.dart';
// import 'package:stay_match/Features/profile/presentation/views/profile_view.dart';
// import 'package:stay_match/Features/shared/rooms/presentation/find_room/views/find_room_view.dart';
// import 'package:stay_match/Features/shared/rooms/presentation/room_details/views/room_details_view.dart';
//
// import '../../Features/auth/presentation/forget_password/presentation/views/forget_password_view.dart';
// import '../../Features/auth/presentation/login/presentation/views/login_view.dart';
// import '../../Features/auth/presentation/signup/presentation/views/signup_view.dart';
// import '../../Features/auth/presentation/verify_email/presentation/views/verify_email_view.dart';
//
// class AppRouting {
//   static final GlobalKey<NavigatorState> rootNavKey =
//       GlobalKey<NavigatorState>();
//
//   // ===========auth routes============
//   static const loginView = '/';
//   static const signupView = '/signupView';
//   static const forgetPasswordView = '/forgetPasswordView';
//   static const verifyEmailView = '/verifyEmailView';
//   static const resetPasswordView = '/resetPasswordView';
//   static const findRoomView = 'findRoomView';
//
//   // auth names
//   static const loginViewName = 'login';
//   static const signupViewName = 'signup';
//   static const forgetPasswordViewName = 'forgetPasswordViewName';
//   static const verifyEmailViewName = 'verifyEmailViewName';
//   static const resetPasswordViewName = 'resetPasswordViewName';
//
//   // =========== main app routes ==============
//   static const homeView = '/homeView';
//   static const findRoomViewName = 'findRoomViewName';
//   static const roomDetailsView = 'roomDetailsView/:id';
//   static const profileView = '/profileView';
//
//   //main app names
//   static const roomDetailsViewName = 'roomDetailsView';
//   static const homeViewName = 'homeView';
//   static const profileViewName = 'profileViewName';
//
//   static final router = GoRouter(
//     navigatorKey: rootNavKey,
//     initialLocation: loginView,
//     routes: [
//       // auth routes
//       GoRoute(
//         path: loginView,
//         name: loginViewName,
//         builder: (context, state) => const LoginView(),
//       ),
//       GoRoute(
//         path: signupView,
//         name: signupViewName,
//         builder: (context, state) => const SignUpView(),
//       ),
//       GoRoute(
//         path: forgetPasswordView,
//         name: forgetPasswordViewName,
//
//         builder: (context, state) => const ForgetPasswordView(),
//       ),
//       GoRoute(
//         path: verifyEmailView,
//         name: verifyEmailViewName,
//         builder: (context, _) => const VerifyEmailView(),
//       ),
//       GoRoute(
//         path: resetPasswordView,
//         name: resetPasswordViewName,
//         builder: (context, state) => const ResetPasswordView(),
//       ),
//       StatefulShellRoute.indexedStack(
//         builder: (context, state, navigationShell) {
//           return LayoutScaffold(navigationShell: navigationShell);
//         },
//         branches: [
//           StatefulShellBranch(
//             routes: [
//               GoRoute(
//                 path: homeView,
//                 name: homeViewName,
//                 builder: (context, _) => const HomeView(),
//                 routes: [
//                   GoRoute(
//                     path: findRoomView,
//                     name: findRoomViewName,
//                     builder: (context, state) => const FindRoomView(),
//                     routes: [
//                       GoRoute(
//                         path: roomDetailsView,
//                         name: roomDetailsViewName,
//                         builder: (context, state) {
//                           String? stringId = state.pathParameters['id'];
//                           int id = stringId != null
//                               ? int.tryParse(stringId) ?? -1
//                               : -1;
//                           return RoomDetailsView(id: id);
//                         },
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           StatefulShellBranch(
//             routes: [
//               GoRoute(
//                 path: profileView,
//                 name: profileViewName,
//                 builder: (context, state) => ProfileView(),
//               ),
//             ],
//           ),
//         ],
//       ),
//
//     ],
//   );
//   // static final router = GoRouter(
//   //   initialLocation: loginView,
//   //   routes: [
//   //     StatefulShellRoute.indexedStack(builder: (context, state, navigationShell){}, branches: [],),
//   //     GoRoute(
//   //       path: loginView,
//   //       name: loginViewName,
//   //       builder: (context, state) => const LoginView(),
//   //     ),
//   //     GoRoute(
//   //       path: signupView,
//   //       name: signupViewName,
//   //       builder: (context, state) => const SignUpView(),
//   //     ),
//   //     GoRoute(
//   //       path: forgetPasswordView,
//   //       name: forgetPasswordViewName,
//   //
//   //       builder: (context, state) => const ForgetPasswordView(),
//   //     ),
//   //     GoRoute(
//   //       path: verifyEmailView,
//   //       name: verifyEmailViewName,
//   //       builder: (context, _) => const VerifyEmailView(),
//   //     ),
//   //     GoRoute(
//   //       path: resetPasswordView,
//   //       name: resetPasswordViewName,
//   //       builder: (context, state) => const ResetPasswordView(),
//   //     ),
//   //     GoRoute(
//   //       path: homeView,
//   //       name: homeViewName,
//   //       builder: (context, _) => const HomeView(),
//   //     ),
//   //     GoRoute(
//   //       path: findRoomView,
//   //       name: findRoomViewName,
//   //       builder: (context, state) => const FindRoomView(),
//   //     ),
//   //   ],
//   // );
// }
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stay_match/Features/auth/presentation/reset_password/presentation/views/reset_password_view.dart';
import 'package:stay_match/Features/google_maps/presentation/views/google_maps_view.dart';
import 'package:stay_match/Features/home/presentation/views/home_view.dart';
import 'package:stay_match/Features/profile/presentation/views/profile_view.dart';
import 'package:stay_match/core/widgets/layout_scaffold.dart';

import '../../Features/apartments/presentation/views/apartment_details_view.dart';
import '../../Features/apartments/presentation/views/find_apartment_view.dart';
import '../../Features/auth/presentation/forget_password/presentation/views/forget_password_view.dart';
import '../../Features/auth/presentation/login/presentation/views/login_view.dart';
import '../../Features/auth/presentation/signup/presentation/views/signup_view.dart';
import '../../Features/auth/presentation/verify_email/presentation/views/verify_email_view.dart';
import '../../Features/rooms/presentation/views/find_room_view.dart';
import '../../Features/rooms/presentation/views/room_details_view.dart';

class AppRouting {
  static final GlobalKey<NavigatorState> rootNavKey = GlobalKey<NavigatorState>();
  // ===========auth routes============
  static const loginView = '/';
  static const signupView = '/signup';
  static const forgetPasswordView = '/forget-password';
  static const verifyEmailView = '/verify-email';
  static const resetPasswordView = '/reset-password';

  // auth names
  static const loginViewName = 'login';
  static const signupViewName = 'signup';
  static const forgetPasswordViewName = 'forgetPassword';
  static const verifyEmailViewName = 'verifyEmail';
  static const resetPasswordViewName = 'resetPassword';

  // google maps
  static const googleMapsView = '/google-maps';
  // =========== main app routes ==============
  static const homeView = '/home';
  static const profileView = '/profile';

  // Nested routes (no leading slash)
  static const findRoomView = 'find-room';
  static const roomDetailsView = 'room-details/:id';
  static const findApartmentView = 'find-apartment';
  static const apartmentDetailsView = 'apartment-details/:id';
  static const mapBody = '/mapBody';

  //main app names
  static const homeViewName = 'home';
  static const profileViewName = 'profile';
  static const findRoomViewName = 'findRoom';
  static const roomDetailsViewName = 'roomDetails';
  static const findApartmentViewName = 'findApartment';
  static const apartmentDetailsViewName = 'apartmentDetails';
  static const googleMapsViewName = 'googleMaps';
  static const mapName = 'map';
  static final router = GoRouter(
    navigatorKey: rootNavKey,
    initialLocation: loginView,
    routes: [
      // AUTH ROUTES
      GoRoute(
        path: loginView,
        name: loginViewName,
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: signupView,
        name: signupViewName,
        builder: (context, state) => const SignUpView(),
      ),
      GoRoute(
        path: forgetPasswordView,
        name: forgetPasswordViewName,
        builder: (context, state) => const ForgetPasswordView(),
      ),
      GoRoute(
        path: verifyEmailView,
        name: verifyEmailViewName,
        builder: (context, _) => const VerifyEmailView(),
      ),
      GoRoute(
        path: resetPasswordView,
        name: resetPasswordViewName,
        builder: (context, state) => const ResetPasswordView(),
      ),
      // google maps
      GoRoute(
        path: googleMapsView,
        name: googleMapsViewName,
        builder: (context, state) =>  GoogleMapsView(),),
      GoRoute(
        path: mapBody,
        builder: (context, state) {
          final latitudeStr = state.uri.queryParameters['latitude'];
          final longitudeStr = state.uri.queryParameters['longitude'];

          final latitude = latitudeStr != null ? double.tryParse(latitudeStr) : null;
          final longitude = longitudeStr != null ? double.tryParse(longitudeStr) : null;

          // Get onLocationSelected callback from extra (optional)
          final onLocationSelected = state.extra as void Function(LatLng)?;

          return GoogleMapsView(
            initialLatitude: latitude,
            initialLongitude: longitude,
            onLocationSelected: onLocationSelected,
          );
        },
      ),
      // MAIN APP SHELL - protected routes
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return LayoutScaffold(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: homeView,
                name: homeViewName,
                builder: (context, _) => const HomeView(),
                routes: [
                  // Nested route: /home/find-apartment/apartment-details/123
                  GoRoute(
                    path: findApartmentView,
                    name: findApartmentViewName,
                    builder: (context, state) => const FindApartmentView(),
                    routes: [
                      GoRoute(
                        path: apartmentDetailsView,
                        name: apartmentDetailsViewName,
                        builder: (context, state) {
                          final id = int.tryParse(state.pathParameters['id'] ?? '-1') ?? -1;
                          return ApartmentDetailsView(id: id);
                        },
                      ),
                    ],
                  ),
                  // Nested route: /home/find-room/room-details/123
                  GoRoute(
                    path: findRoomView,
                    name: findRoomViewName,
                    builder: (context, state) => const FindRoomView(),
                    routes: [
                      // Nested route: /home/find-room/room-details/123
                      GoRoute(
                        path: roomDetailsView,
                        name: roomDetailsViewName,
                        builder: (context, state) {
                          final roomId = int.tryParse(state.pathParameters['roomId'] ?? '-1') ?? -1;
                          final propertyId = int.tryParse(state.pathParameters['propertyId'] ?? '-1') ?? -1;
                          return RoomDetailsView(roomId: roomId,propertyId:propertyId);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),

          StatefulShellBranch(
            routes: [
              GoRoute(
                path: profileView,
                name: profileViewName,
                builder: (context, state) => const ProfileView(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}