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
import 'package:stay_match/Features/other_user_profile/presentation/views/other_user_profile_view.dart';
import 'package:stay_match/Features/payment/presentation/views/pay_credit_view.dart';
import 'package:stay_match/Features/profile/presentation/manager/profile_cubit.dart';
import 'package:stay_match/Features/profile/presentation/views/profile_view.dart';
import 'package:stay_match/Features/questions/presentation/manager/questions_cubit.dart';
import 'package:stay_match/Features/questions/presentation/views/questions_%20view.dart';
import 'package:stay_match/Features/questions/presentation/views/questions_finish_pic.dart';
import 'package:stay_match/Features/questions/presentation/views/questions_start_view.dart';
import 'package:stay_match/Features/reviews/presentation/views/add_review_view.dart';
import 'package:stay_match/Features/rooms/presentation/views/shared_property_view.dart';
import 'package:stay_match/core/utils/service_locator.dart';
import 'package:stay_match/core/widgets/layout_scaffold.dart';
import 'package:stay_match/core/widgets/secondary_splash.dart';

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
import '../../Features/chatbot/presentation/views/chatbot_view.dart';
import '../../Features/google_maps/presentation/widgets/maps_helper.dart';
import '../../Features/my_properties/presentation/views/my_properties_view.dart';
import '../../Features/questions/data/repos/questions_repo_impl.dart';
import '../../Features/reviews/data/repos/reviews_repo_impl.dart';
import '../../Features/reviews/presentation/manager/write_review_cubit.dart';
import '../../Features/reviews/presentation/views/apartment_reviews_view.dart';
import '../../Features/reviews/presentation/views/review_submitted_view.dart';
import '../../Features/rooms/presentation/views/find_room_view.dart';
import '../../Features/rooms/presentation/views/room_details_view.dart';
import '../../Features/saved/presentation/views/saved_view.dart';
import '../widgets/onboarding.dart';

class AppRouting {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // =========== Auth Routes ============
  static const loginView = '/';
  static const signupView = '/signup';
  static const forgetPasswordView = '/forget-password';
  static const verifyEmailView = '/verify-email';
  static const resetPasswordView = '/reset-password';

  static const loginViewName = 'login';
  static const signupViewName = 'signup';
  static const forgetPasswordViewName = 'forgetPassword';
  static const verifyEmailViewName = 'verifyEmail';
  static const resetPasswordViewName = 'resetPassword';

  // =========== Google Maps ============
  static const googleMapsView = '/google-maps';
  static const googleMapsViewName = 'googleMaps';

  // =========== Main App Routes ============
  static const homeView = '/home';
  static const homeViewName = 'home';

  static const chatListPath = '/chat-list';
  static const chatListName = 'chatListName';

  static const profilePath = '/profile';
  static const profileName = 'profile';

  // =========== Properties & Rooms ============
  static const findRoomView = '/find-room';
  static const findRoomViewName = 'findRoom';

  static const sharedPropertyViewPath = 'shared-property/:propertyId';
  static const sharedPropertyViewName = 'sharedProperty';

  static const roomDetailsViewPath = 'room-details/:roomId'; // Removed leading slash for nesting
  static const roomDetailsViewName = 'roomDetails';

  static const findApartmentView = '/find-apartment';
  static const findApartmentViewName = 'findApartment';

  static const apartmentDetailsViewPath = 'apartment-details/:id';
  static const apartmentDetailsViewName = 'apartmentDetails';

  // =========== Chat Messages ============
  static const messagesPath = '/messages/:otherUserId';
  static const messagesName = 'messages';

  // =========== Add Property Flow ============
  static const addPropertyPath = '/add-property';
  static const addPropertyName = 'addProperty';

  static const addPropertyInfoPath = 'add-property-info';
  static const addPropertyInfoName = 'addPropertyInfo';

  static const addIndividualRoomsPath = 'add-room';
  static const addIndividualRoomsName = 'addRoom';

  static const addSharedApartmentDetailsPath = 'add-shared-apartment-details';
  static const addSharedApartmentDetailsName = 'addSharedApartmentDetails';

  static const addAmenitiesPath = 'add-amenities';
  static const addAmenitiesName = 'addAmenities';

  static const addLocationAndGalleryPath = 'add-location-and-gallery';
  static const addLocationAndGalleryName = 'addLocationAndGallery';

  static const addPropertySuccessPath = '/add-property-success/:id';
  static const addPropertySuccessName = 'addPropertySuccess';

  static const myPropertiesPath = '/my-properties';
  static const myPropertiesName = 'myProperties';

  // =========== Bookings ============
  static const renterBookingsPath = '/renter-bookings';
  static const renterBookingsName = 'renterBookings';

  static const hostBookingsPath = '/host-bookings';
  static const hostBookingsName = 'hostBookings';

  static const bookingRequestPath = '/booking-request';
  static const bookingRequestName = 'bookingRequest';

  // =========== Saved Properties ============
  static const savedPropertiesPath = '/saved-properties';
  static const savedPropertiesName = 'savedProperties';

  // =========== Reviews ============
  static const apartmentReviewsPath = '/apartment-reviews/:propertyId';
  static const apartmentReviewsName = 'apartmentReviews';

  static const addReviewPath = '/add-review';
  static const addReviewName = 'addReview';

  static const reviewSubmittedPath = '/review-submitted';
  static const reviewSubmittedName = 'reviewSubmitted';

  // =========== Other Profiles & Utilities ============
  static const otherUserProfilePath = '/other-user-profile';
  static const otherUserProfileName = 'otherUserProfile';

  static const payCardPath = '/pay-card';
  static const payCardName = 'payCard';

  static const chatbotPath = '/chatbot';
  static const chatbotName = 'chatbot';

  static const questionsName = 'questions';
  static const questionsPath = '/questions';

  static const questionsStartName = 'questionsStart';
  static const questionsStartPath = '/questions-start';

  static const questionsFinishName = 'questionsFinish';
  static const questionsFinishPath = '/questions-finish';

  static const secondarySplashPath = '/secondary-splash';
  static const secondarySplashName = 'secondarySplash';

  static const onboardingPath = '/onboarding';
  static const onboardingName = 'onboarding';

  static final router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: onboardingPath,
    routes: [
      // ---------------- AUTH ROUTES ----------------
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

      // ---------------- GOOGLE MAPS ----------------
      GoRoute(
        path: googleMapsView,
        name: googleMapsViewName,
        builder: (context, state) {
          final latitudeStr = state.uri.queryParameters['latitude'];
          final longitudeStr = state.uri.queryParameters['longitude'];
          final isStaticStr = state.uri.queryParameters['isStatic'];

          final latitude = double.tryParse(latitudeStr ?? '');
          final longitude = double.tryParse(longitudeStr ?? '');
          final contextMode = (isStaticStr == 'true') ? MapContext.staticView : MapContext.picker;
          final onLocationSelected = state.extra as void Function(LatLng)?;

          return GoogleMapsView(
            initialLatitude: latitude,
            initialLongitude: longitude,
            onLocationSelected: onLocationSelected,
            mapContext: contextMode,
          );
        },
      ),

      // ---------------- FIND APARTMENT FLOW ----------------
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
              final id = int.tryParse(state.pathParameters['id'] ?? '-1') ?? -1;
              return ApartmentDetailsView(id: id);
            },
          ),
        ],
      ),

      // ---------------- FIND ROOM FLOW & NESTED DETAILS ----------------
      GoRoute(
        parentNavigatorKey: navigatorKey,
        path: findRoomView,
        name: findRoomViewName,
        builder: (context, state) => const FindRoomView(),
        routes: [
          GoRoute(
            parentNavigatorKey: navigatorKey,
            path: sharedPropertyViewPath,
            name: sharedPropertyViewName,
            builder: (context, state) {
              final propertyId = int.tryParse(state.pathParameters['propertyId'] ?? '-1') ?? -1;
              return SharedPropertyView(propertyId: propertyId);
            },
              routes: [
                GoRoute(
                  name: roomDetailsViewName,
                  path: roomDetailsViewPath,
                  builder: (context, state) {
                    final roomId = int.tryParse(state.pathParameters['roomId'] ?? '-1') ?? -1;
                    final propertyId = int.tryParse(state.pathParameters['propertyId'] ?? '-1') ?? -1;
                    return RoomDetailsView(roomId: roomId, propertyId: propertyId);
                  },
                ),

              ]
          ),
        ],
      ),

      // ---------------- MY PROPERTIES ----------------
      GoRoute(
        path: myPropertiesPath,
        name: myPropertiesName,
        builder: (context, state) => const MyPropertiesView(),
      ),

      // ---------------- CHAT MESSAGES ----------------
      GoRoute(
        path: messagesPath,
        name: messagesName,
        builder: (context, state) {
          final otherUserId = state.pathParameters['otherUserId'] ?? '-1';
          return MessagesView(otherUserId: otherUserId);
        },
      ),

      // ---------------- BOOKING REQUESTS ----------------
      GoRoute(
        path: bookingRequestPath,
        name: bookingRequestName,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>? ?? {};
          return RequestBookingView(
            propertyId: extra['propertyId'] as int? ?? 0,
            startDate: extra['startDate'] as String? ?? '',
            duration: extra['duration'] as int? ?? -1,
            monthlyRent: extra['monthlyRent'] as double? ?? -1,
            city: extra['city'] as String? ?? '',
            street: extra['street'] as String? ?? '',
            hostName: extra['hostName'] as String? ?? '',
            propertyName: extra['propertyName'] as String? ?? '',
            propertyImg: extra['propertyImg'] as String? ?? '',
          );
        },
      ),

      // ---------------- HOST BOOKINGS ----------------
      GoRoute(
        path: hostBookingsPath,
        name: hostBookingsName,
        builder: (context, _) => const HostBookingsView(),
      ),

      // ---------------- SAVED PROPERTIES ----------------
      GoRoute(
        path: savedPropertiesPath,
        name: savedPropertiesName,
        builder: (context, state) => const SavedView(),
      ),

      // ---------------- REVIEWS SYSTEM ----------------
      GoRoute(
        path: apartmentReviewsPath,
        name: apartmentReviewsName,
        builder: (context, state) {
          final propertyId = int.tryParse(state.pathParameters['propertyId'] ?? '-1') ?? -1;
          return ApartmentReviewsView(propertyId: propertyId);
        },
      ),
      GoRoute(
        path: addReviewPath,
        name: addReviewName,
        builder: (context, state) {
          final args = state.extra as AddReviewArgs;
          return BlocProvider(
            create: (context) => WriteReviewCubit(reviewsRepo: getIt.get<ReviewsRepoImpl>()),
            child: AddReviewView(args: args),
          );
        },
      ),
      GoRoute(
        path: reviewSubmittedPath,
        name: reviewSubmittedName,
        builder: (context, state) => const ReviewSubmittedView(),
      ),

      // ---------------- OTHER UTILITIES ----------------
      // user profile
      GoRoute(
        path: otherUserProfilePath,
        name: otherUserProfileName,
        builder: (context, state) {
          final userId = state.extra as String;
          return OtherUserProfileView(userId: userId);
        },
      ),
      // payment
      GoRoute(
        path: payCardPath,
        name: payCardName,
        builder: (context, state) {
          final bookingId = state.extra as int;
          return PayCreditView(bookingId: bookingId);
        },
      ),
      // chatbot
      GoRoute(
        path: chatbotPath,
        name: chatbotName,
        builder: (context, state) => const ChatbotView(),
      ),
      // ---------------- QUESTIONS ----------------
      GoRoute(
        path: questionsPath,
        name: questionsName,
        builder: (context, state) => BlocProvider(create:(context) => QuestionsCubit(questionsRepo: getIt.get<QuestionsRepoImpl>()),child: const QuestionsView()),
      ),
      GoRoute(
        name: questionsStartName,
        path: questionsStartPath,
        builder: (context, state) => const SecondarySplashView()
      ),
      // onboarding
      GoRoute(
        name: onboardingName,
        path: onboardingPath,
        builder: (context, state) => const OnboardingPage(),
      ),

      // ---------------- STATEFUL NAVIGATION SHELL (BOTTOM NAV BAR) ----------------
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return LayoutScaffold(navigationShell: navigationShell);
        },
        branches: [
          // BRANCH 1: HOME
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: homeView,
                name: homeViewName,
                builder: (context, _) => const HomeView(),
              ),
            ],
          ),
          // BRANCH 2: MY BOOKINGS
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: renterBookingsPath,
                name: renterBookingsName,
                builder: (context, _) => const RenterBookingsView(),
              ),
            ],
          ),
          // BRANCH 3: ADD PROPERTY MULTI-STEP WIZARD
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
                  GoRoute(
                    path: addPropertyPath,
                    name: addPropertyName,
                    builder: (context, state) => const AddPropertyView(),
                    routes: [
                      GoRoute(
                        path: addPropertyInfoPath,
                        name: addPropertyInfoName,
                        builder: (context, state) => const AddBasicInfoView(),
                      ),
                      GoRoute(
                        path: addAmenitiesPath,
                        name: addAmenitiesName,
                        builder: (context, state) => const AmenitiesAndServicesView(),
                      ),
                      GoRoute(
                        path: addLocationAndGalleryPath,
                        name: addLocationAndGalleryName,
                        builder: (context, state) => const LocationAndGalleryView(),
                      ),
                      GoRoute(
                        path: addPropertySuccessPath,
                        name: addPropertySuccessName,
                        builder: (context, state) {
                          final pathId = state.pathParameters['id'] ?? '';
                          final id = int.tryParse(pathId) ?? -1;
                          return AddPropertySuccessView(id: id);
                        },
                      ),
                      GoRoute(
                        path: addIndividualRoomsPath,
                        name: addIndividualRoomsName,
                        builder: (context, state) => const IndividualRoomDetailsView(),
                      ),
                      GoRoute(
                        path: addSharedApartmentDetailsPath,
                        name: addSharedApartmentDetailsName,
                        builder: (context, state) => const SharedApartmentInfoView(),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          // BRANCH 4: CHATS
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: chatListPath,
                name: chatListName,
                builder: (context, _) => const ChatListView(),
              ),
            ],
          ),
          // BRANCH 5: PROFILE
          StatefulShellBranch(
            routes: [
              ShellRoute(
                builder: (context, state, child) {
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider(create: (context) => getIt.get<ProfileCubit>()),
                      BlocProvider(create: (context) => getIt.get<LocationCubit>()),
                    ],
                    child: child,
                  );
                },
                routes: [
                  GoRoute(
                    path: profilePath,
                    name: profileName,
                    builder: (context, state) => const ProfileView(),
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