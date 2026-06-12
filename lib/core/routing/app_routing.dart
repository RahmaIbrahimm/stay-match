import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stay_match/Features/add_property/presentation/views/add_basic_info_view.dart';
import 'package:stay_match/Features/add_property/presentation/views/shared_apartment_info_view.dart';
import 'package:stay_match/Features/auth/presentation/reset_password/presentation/views/reset_password_view.dart';
import 'package:stay_match/Features/booking/presentation/views/host_bookings_view.dart';
import 'package:stay_match/Features/chat/presentation/views/messages_view.dart';
import 'package:stay_match/Features/filter/presentation/manager/location_cubit.dart';
import 'package:stay_match/Features/google_maps/presentation/views/google_maps_view.dart';
import 'package:stay_match/Features/home/presentation/views/home_view.dart';
import 'package:stay_match/Features/profile/presentation/manager/profile_cubit.dart';
import 'package:stay_match/Features/profile/presentation/views/profile_view.dart';
import 'package:stay_match/Features/reviews/presentation/views/add_review_view.dart';
import 'package:stay_match/core/utils/service_locator.dart';
import 'package:stay_match/core/widgets/layout_scaffold.dart';

import '../../Features/add_property/data/repos/add_property_repo_impl.dart';
import '../../Features/add_property/presentation/manager/add_property_cubit.dart';
import '../../Features/add_property/presentation/views/add_property_success_view.dart';
import '../../Features/add_property/presentation/views/add_property_view.dart';
import '../../Features/add_property/presentation/views/amenities_and_services_view.dart';
import '../../Features/add_property/presentation/views/individual_room_details_view.dart';
import '../../Features/add_property/presentation/views/location_and_gallery_view.dart';
import '../../Features/apartments/presentation/views/apartment_details_view.dart';
import '../../Features/apartments/presentation/views/find_apartment_view.dart';
import '../../Features/auth/presentation/forget_password/presentation/views/forget_password_view.dart';
import '../../Features/auth/presentation/login/presentation/views/login_view.dart';
import '../../Features/auth/presentation/signup/presentation/views/signup_view.dart';
import '../../Features/auth/presentation/verify_email/presentation/views/verify_email_view.dart';
import '../../Features/booking/presentation/views/renter_bookings_view.dart';
import '../../Features/booking/presentation/views/request_booking_view.dart';
import '../../Features/chat/presentation/views/chat_list_view.dart';
import '../../Features/google_maps/presentation/widgets/maps_helper.dart';
import '../../Features/my_properties/presentation/views/my_properties_view.dart';
import '../../Features/reviews/data/repos/reviews_repo_impl.dart';
import '../../Features/reviews/presentation/manager/write_review_cubit.dart';
import '../../Features/reviews/presentation/views/apartment_reviews_view.dart';
import '../../Features/reviews/presentation/views/review_submitted_view.dart';
import '../../Features/rooms/presentation/views/find_room_view.dart';
import '../../Features/rooms/presentation/views/room_details_view.dart';
import '../../Features/saved/presentation/views/saved_view.dart';

class AppRouting {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
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
  static const chatListPath = '/chat-list';
  static const addPropertyPath = '/add-property';
  static const profilePath = '/profile';
  // Nested routes (no leading slash)
  static const findRoomView = '/find-room';
  static const roomDetailsViewPath = 'room-details/:propertyId';
  static const findApartmentView = '/find-apartment';
  static const apartmentDetailsViewPath = 'apartment-details/:id';
  static const mapBodyPath = '/mapBody';

  //chat
  static const messagesPath = '/messages/:otherUserId';

  // add property
  static const addPropertyInfoPath = 'add-property-info';
  static const addIndividualRoomsPath = 'add-room';
  static const addSharedApartmentDetailsPath = 'add-shared-apartment-details';
  static const addAmenitiesPath = 'add-amenities';
  static const addLocationAndGalleryPath = 'add-location-and-gallery';
  static const addPropertySuccessPath = '/add-property-success/:id';
  static const myPropertiesPath = '/my-properties';
  static const listingSuccessPath = '/my-properties';

  // booking
  static const renterBookingsPath = '/renter-bookings';
  static const hostBookingsPath = '/host-bookings';
  static const bookingRequestPath = '/booking-request';

  // saved properties
  static const savedPropertiesPath = '/saved-properties';

  //reviews
  static const apartmentReviewsPath = '/apartment-reviews/:propertyId';
  static const reviewSubmittedPath = '/review-submitted';
  static const addReviewPath = '/add-review';

  //main app names
  static const homeViewName = 'home';
  static const addPropertyName = 'addProperty';
  static const profileName = 'profile';
  static const findRoomViewName = 'findRoom';
  static const roomDetailsViewName = 'roomDetails';
  static const findApartmentViewName = 'findApartment';
  static const apartmentDetailsViewName = 'apartmentDetails';
  static const googleMapsViewName = 'googleMaps';
  static const mapName = 'map';
  static const chatListName = 'chatListName';
  static const messagesName = 'messages';

  // add property
  static const addPropertyInfoName = 'addPropertyInfo';
  static const addSharedApartmentDetailsName = 'addSharedApartmentDetails';
  static const addIndividualRoomsName = 'addRoom';
  static const addAmenitiesName = 'addAmenities';
  static const addLocationAndGalleryName = 'addLocationAndGallery';
  static const addPropertySuccessName = 'addPropertySuccess';
  static const myPropertiesName = 'myProperties';
  static const listingSuccessName = 'listingSuccess';

  // saved properties
  static const savedPropertiesName = 'savedProperties';

  // booking
  static const renterBookingsName = 'renterBookings';
  static const hostBookingsName = 'hostBookings';
  static const bookingRequestName = 'bookingRequest';

  //reviews
  static const apartmentReviewsName = 'apartmentReviews';
  static const reviewSubmittedName = 'reviewSubmitted';
  static const addReviewName = 'addReview';

  static final router = GoRouter(
    navigatorKey: navigatorKey,
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

      // maps
      GoRoute(
        path: googleMapsView,
        name: googleMapsViewName,
        builder: (context, state) {
          // 1. Extract the strings
          final latitudeStr = state.uri.queryParameters['latitude'];
          final longitudeStr = state.uri.queryParameters['longitude'];
          final isStaticStr = state.uri.queryParameters['isStatic'];

          // 2. Parse the numbers
          final latitude = double.tryParse(latitudeStr ?? '');
          final longitude = double.tryParse(longitudeStr ?? '');

          // 3. Convert "true" string to our MapContext enum
          // If 'isStatic' is 'true' in the URL, use staticView, otherwise picker
          final contextMode = (isStaticStr == 'true')
              ? MapContext.staticView
              : MapContext.picker;

          final onLocationSelected = state.extra as void Function(LatLng)?;

          return GoogleMapsView(
            initialLatitude: latitude,
            initialLongitude: longitude,
            onLocationSelected: onLocationSelected,
            mapContext: contextMode, // Passing the result here
          );
        },
      ),
      // property related routes
      // Nested route: /home/find-apartment/apartment-details/123
      GoRoute(
        parentNavigatorKey: navigatorKey,
        path: findApartmentView,
        name: findApartmentViewName,
        builder: (context, state) => const FindApartmentView(),
        routes: [
          GoRoute(
            path: apartmentDetailsViewPath,
            name: apartmentDetailsViewName,
            builder: (context, state) {
              final id =
                  int.tryParse(
                    state.pathParameters['id'] ?? '-1',
                  ) ??
                      -1;
              return ApartmentDetailsView(id: id);
            },
          ),
        ],
      ),
      // Nested route: /home/find-room/room-details/123
      GoRoute(
        parentNavigatorKey: navigatorKey,
        path: findRoomView,
        name: findRoomViewName,
        builder: (context, state) => const FindRoomView(),
        routes: [
          // Nested route: /home/find-room/room-details/123
          GoRoute(
            parentNavigatorKey: navigatorKey,
            path: roomDetailsViewPath,
            name: roomDetailsViewName,
            builder: (context, state) {
              final roomId =
                  int.tryParse(
                    state.pathParameters['roomId'] ?? '-1',
                  ) ??
                      -1;
              final propertyId =
                  int.tryParse(
                    state.pathParameters['propertyId'] ?? '-1',
                  ) ??
                      -1;
              return RoomDetailsView(
                roomId: roomId,
                propertyId: propertyId,
              );
            },
          ),
        ],
      ),
      // my properties
      GoRoute(
        path: myPropertiesPath,
        name: myPropertiesName,
        builder: (context, state) => const MyPropertiesView(),
        routes: [],
      ),
      // chat
      GoRoute(
        path: messagesPath,
        name: messagesName,
        builder: (context, state) {
          final otherUserId =
              state.pathParameters['otherUserId'] ?? '-1';

          return MessagesView(otherUserId: otherUserId);
        },
        routes: [],
      ),
      // booking
      GoRoute(
        path: bookingRequestPath,
        name: bookingRequestName,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>? ?? {};

          final propertyId = extra['propertyId'] as int? ?? 0;
          final startDate = extra['startDate'] as String? ??
              ''; // Keep as String
          final duration = extra['duration'] as int? ?? -1;
          // final joinYear = extra['joinYear'] as int? ?? -1;
          final monthlyRent = extra['monthlyRent'] as double? ?? -1;
          final city = extra['city'] as String? ?? ''; // Keep as String
          final street = extra['street'] as String? ?? ''; // Keep as String
          final hostName = extra['hostName'] as String? ?? ''; // Keep as String
          final propertyName = extra['propertyName'] as String? ?? '';
          final propertyImg = extra['propertyImg'] as String? ?? '';
          // final hostImg = extra['hostImg'] as String? ?? ''; // Keep as String

          return RequestBookingView(
            propertyId: propertyId,
            startDate: startDate,
            duration: duration,
            hostName: hostName,
            street: street,
            city: city,
            propertyName: propertyName,
            propertyImg: propertyImg, monthlyRent: monthlyRent,
            // hostImg: hostImg,
            // joinYear: joinYear,
          );
        },),
      // host booking
      GoRoute(
        path: hostBookingsPath,
        name: hostBookingsName,
        builder: (context, _) => const HostBookingsView(),
        routes: [
        ],
      ),
      // saved properties
      GoRoute(
        path: savedPropertiesPath,
        name: savedPropertiesName,
        builder: (context, state) => const SavedView(),
      ),
      // reviews
      GoRoute(
        path: apartmentReviewsPath,
        name: apartmentReviewsName,
        builder: (context, state) {
          var propertyId  =
              int.tryParse(state.pathParameters['propertyId'] ?? '-1');
          return ApartmentReviewsView(propertyId : propertyId ?? -1 );
        },
        routes: [],
      ),
      // add reviews
      GoRoute(
        path: addReviewPath,
        name: addReviewName,
        builder: (context, state) {
          var args = state.extra as AddReviewArgs;
          return BlocProvider(
            create: (context) =>
                WriteReviewCubit(reviewsRepo: getIt.get<ReviewsRepoImpl>()),
            child: AddReviewView(args: args,),
          );
        },
        routes: [],
      ),
      // review success
      GoRoute(
        path: reviewSubmittedPath,
        name: reviewSubmittedName,
        builder: (context, state) =>
            ReviewSubmittedView(),
        routes: [],
      ),

      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return LayoutScaffold(navigationShell: navigationShell);
        },
        branches: [
          // home
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: homeView,
                name: homeViewName,
                builder: (context, _) => const HomeView(),
                routes: [
                ],
              ),
            ],
          ),
          // my bookings
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: renterBookingsPath,
                name: renterBookingsName,
                builder: (context, _) => const RenterBookingsView(),
                routes: [
                ],
              ),
            ],
          ),
          // add property
          StatefulShellBranch(
            routes: [
              ShellRoute(
                builder: (context, state, child) {
                  return BlocProvider(
                    create: (context) => AddPropertyCubit(
                      addPropertyRepo: getIt.get<AddPropertyRepoImpl>(),
                    ),
                    child: child,
                  );
                },
                routes: [
                  // Step 1: Main Entry (Parent)
                  GoRoute(
                    path: addPropertyPath, // '/add-property'
                    name: addPropertyName,
                    // builder: (context, state) => const IndividualRoomDetailsView(),
                    builder: (context, state) => const AddPropertyView(),
                    routes: [
                      GoRoute(
                        path: addPropertyInfoPath, // 'add-property-info'
                        name: addPropertyInfoName,
                        builder: (context,
                            state) => const AddBasicInfoView(),
                      ),
                      GoRoute(
                        path: addAmenitiesPath, // 'add-amenities'
                        name: addAmenitiesName,
                        builder: (context, state) =>
                            const AmenitiesAndServicesView(),
                      ),
                      GoRoute(
                        path: addLocationAndGalleryPath, // 'add-amenities'
                        name: addLocationAndGalleryName,
                        builder: (context, state) =>
                            const LocationAndGalleryView(),
                      ),
                      GoRoute(
                        path: addPropertySuccessPath,
                        name: addPropertySuccessName,
                        builder: (context, state) {
                          String pathId = state.pathParameters['id'] ?? '';
                          int id = int.tryParse(pathId) ?? -1;
                          return AddPropertySuccessView(id: id,);
                        },
                      ),
                      GoRoute(
                        path: addIndividualRoomsPath,
                        name: addIndividualRoomsName,
                        builder: (context, state) =>
                        const IndividualRoomDetailsView(),
                      ),
                      GoRoute(
                        path: addSharedApartmentDetailsPath,
                        name: addSharedApartmentDetailsName,
                        builder: (context, state) =>
                        const SharedApartmentInfoView(),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          // chat
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: chatListPath,
                name: chatListName,
                builder: (context, _) => const ChatListView(),
                routes: [
                ],
              ),
            ],
          ),
          // profile
          StatefulShellBranch(
            routes: [
              ShellRoute(
                builder: (context, state, child) {
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (context) => getIt.get<ProfileCubit>(),
                      ),
                      BlocProvider(
                        create: (context) => getIt.get<LocationCubit>(),
                      ),
                    ],
                    child: child,
                  );
                },
                routes: [
                  // Step 1: Main Entry (Parent)
                  GoRoute(
                    path: profilePath,
                    name: profileName,
                    builder: (context, state) => const ProfileView(),
                    routes: [
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}