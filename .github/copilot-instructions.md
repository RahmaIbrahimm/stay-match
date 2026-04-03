# Flutter Project Architecture Rules - Stay Match

## Project Information
- App Name: stay_match
- Package: stay_match
- State Management: Cubit only (no full BLoC with events)
- Equality: Equatable package
- Responsive: screenutil (already initialized in main.dart)
- Navigation: go_router with StatefulShellRoute (bottom nav bar)
- Dependency Injection: get_it (service_locator.dart)
- Networking: Dio with custom interceptors
- Secure Storage: flutter_secure_storage via SecureStorageHelper
- Error Handling: Custom Failure class with ServerFailure

## Core Folder (lib/core/)

### Constants (lib/core/constants/)
- app_colors.dart - All color constants. Use AppColors.primary, AppColors.textColorSecondary, etc.
- app_icons.dart - Icon constants/custom icon data
- app_images.dart - Asset image paths
- app_strings.dart - All text strings, labels, error messages, includes dateFormat
- app_styles.dart - Text styles (e.g., AppStyles.medium10poppins)

RULE: NEVER hardcode strings, colors, images, or styles. Always use constants.

### Widgets (lib/core/widgets/) - REUSE THESE FIRST

- BuildFeature (build_feature.dart) - Displays an icon + text pair for apartment features
- CustomBottomNavButton (custom_bottom_nav_button.dart) - Bottom navigation button
- CustomDateSelector (custom_date_selector.dart) - Date picker widget
- CustomDropDownMenu (custom_drop_down_menu.dart) - Dropdown selection
- CustomElevatedButton (custom_elevated_button.dart) - Primary filled button
- CustomTextButton (custom_text_button.dart) - Text-only button
- CustomTextFormField (custom_text_form_field.dart) - Form input with validation
- CustomToggleSwitch (custom_toggle_switch.dart) - Boolean toggle/switch
- FormSection (form_section.dart) - Form section with title and children
- LayoutScaffold (layout_scaffold.dart) - Main app scaffold with bottom nav bar (takes navigationShell)
- LocationRow (location_row.dart) - Location display row
- NavBar (nav_bar.dart) - Navigation bar component

### Networking (lib/core/networking/)
- ApiService (abstract class) - Defines get, post, patch, delete methods
- DioConsumer - Implements ApiService with Dio, handles base URL, timeouts, interceptors
- ApiInterceptors - Adds auth token to requests, handles 401 token refresh
- Endpoints - API endpoint URL constants (baseUrl, webClientId, etc.)

Repository pattern example:
- Repository uses DioConsumer via ApiService
- Try-catch with DioException, throw ServerFailure.fromDioError(e)

### Routing (lib/core/routing/)
- AppRouting - GoRouter configuration with StatefulShellRoute for bottom nav
- Uses GlobalKey<NavigatorState> rootNavKey
- Auth routes (no shell): /, /signup, /forget-password, /verify-email, /reset-password
- Protected routes (inside StatefulShellRoute): /home, /profile
- Nested routes: find-apartment, apartment-details/:id, find-room, room-details/:roomId

Navigation methods in UI:
- context.push('/route-name') - Push new screen
- context.go('/route-name') - Replace current screen
- context.pop() - Go back

### Theme (lib/core/theme/)
- app_theme.dart - ThemeData configuration

### Utils (lib/core/utils/)
- service_locator.dart - get_it setup for dependency injection
- secure_storage_helper.dart - Secure storage operations (tokenKey, refreshTokenKey)

### Errors (lib/core/errors/)
- failures.dart - Failure abstract class with errMessage
- ServerFailure - Factory methods: ServerFailure.fromDioError(DioException), ServerFailure.fromResponse(statusCode, response)

Error handling pattern in Cubits:
response.fold(
(failure) => emit(MyStateError(failure.errMessage)),
(data) => emit(MyStateSuccess(data)),
);

## Features Structure

lib/features/[feature_name]/
├── data/
│   ├── models/         (data models with Equatable)
│   └── repos/          (repositories + implementations)
│       ├── [feature]_repo.dart      (abstract)
│       └── [feature]_repo_impl.dart (concrete, uses ApiService)
├── presentation/
│   ├── manager/        (Cubit + State)
│   │   ├── [feature]_cubit.dart
│   │   └── [feature]_state.dart
│   └── views/          (UI screens)
│       └── [feature]_view.dart

### Current Features
- auth - Authentication (login, signup, forget password, verify email, reset password, Google sign-in)
- apartments - Apartment listings and details
- filter - Filtering system (Cubit pattern reference)
- home - Home screen (main dashboard)
- profile - User profile
- rooms - Room listings and details
- shared - Widgets shared between rooms and apartments only (not core)

### Filter Feature Structure (REFERENCE FOR ALL FEATURES)

lib/features/filter/
├── data/
│   ├── models/
│   │   ├── apartment_filter_params.dart
│   │   ├── location_model.dart
│   │   └── rooms_filter_params.dart
│   └── repos/
│       ├── location_repo.dart (abstract)
│       └── location_repo_impl.dart (concrete)
└── presentation/
├── manager/
│   ├── filter_cubit.dart
│   ├── filter_state.dart
│   ├── location_cubit.dart
│   └── location_state.dart
└── widgets/ (feature-specific widgets)

## Cubit Pattern (MUST FOLLOW EXACTLY)

### State File Pattern ([feature]_state.dart)

part of '[feature]_cubit.dart';

abstract class FeatureState extends Equatable {
const FeatureState();
@override List<Object?> get props => [];
}

class FeatureInitial extends FeatureState { const FeatureInitial(); }
class FeatureLoading extends FeatureState { const FeatureLoading(); }
class FeatureSuccess extends FeatureState {
final SomeData data;
const FeatureSuccess(this.data);
@override List<Object?> get props => [data];
}
class FeatureFailure extends FeatureState {
final String errMessage;
const FeatureFailure(this.errMessage);
@override List<Object?> get props => [errMessage];
}

### Cubit File Pattern ([feature]_cubit.dart)

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stay_match/core/networking/api_service.dart';
import 'package:stay_match/core/errors/failures.dart';
import 'package:stay_match/features/[feature]/data/repos/[feature]_repo.dart';

part '[feature]_state.dart';

class FeatureCubit extends Cubit<FeatureState> {
final FeatureRepo featureRepo;
FeatureCubit(this.featureRepo) : super(const FeatureInitial());

Future<void> doSomething() async {
emit(const FeatureLoading());
final result = await featureRepo.getData();
result.fold(
(failure) => emit(FeatureFailure(failure.errMessage)),
(data) => emit(FeatureSuccess(data)),
);
}
}

### Form Validation Pattern (from AuthCubit)

Common validators:
- emailValidator({String? email})
- passwordValidator({String? password})
- passwordMatchValidator({String? password, String? confirmPassword})
- nullFieldValidator({String? text})

Form submission pattern:
Future<void> formValidationAndInvokeMethod({
required GlobalKey<FormState> key,
required Future<void> authMethod,
bool hasConfirmPassword = false,
String? pass,
String? confirmPass
}) async {
final formState = key.currentState;
if (formState is FormState && formState.validate() == true &&
(hasConfirmPassword ? pass == confirmPass : true)) {
await authMethod;
}
}

## Repository Pattern

### Abstract Repository

import 'package:dartz/dartz.dart';
import 'package:stay_match/core/errors/failures.dart';

abstract class FeatureRepo {
Future<Either<Failure, SomeResponse>> getData();
}

### Concrete Implementation

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:stay_match/core/networking/api_service.dart';
import 'package:stay_match/core/errors/failures.dart';

class FeatureRepoImpl implements FeatureRepo {
final ApiService apiService;
FeatureRepoImpl(this.apiService);

@override
Future<Either<Failure, SomeResponse>> getData() async {
try {
final response = await apiService.get('/endpoint');
return Right(SomeResponse.fromJson(response));
} on DioException catch (e) {
return Left(ServerFailure.fromDioError(e));
} catch (e) {
return Left(ServerFailure(e.toString()));
}
}
}

## Dependency Injection (get_it)

Register in lib/core/utils/service_locator.dart:

final sl = GetIt.instance;

void setupServiceLocator() {
// Core
sl.registerLazySingleton<ApiService>(() => DioConsumer(Dio()));
// Repositories
sl.registerLazySingleton<AuthRepo>(() => AuthRepoImpl(sl<ApiService>()));
// Cubits
sl.registerFactory<AuthCubit>(() => AuthCubit(sl<AuthRepo>()));
}

Usage in widget:
final cubit = sl<AuthCubit>();

## Code Generation Rules

### 1. Import Order
- Dart SDK imports (dart:async)
- Flutter imports (package:flutter)
- Third-party imports (dartz, dio, equatable, get_it, go_router)
- Core imports (stay_match/core/*)
- Feature imports (stay_match/features/*)

### 2. Responsive Design (screenutil)
- Width: .w (example: 100.w)
- Height: .h (example: 50.h)
- Font size: .sp (example: 16.sp)
- Radius: .r (example: 12.r)
- EdgeInsets: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h)

### 3. BuildFeature Widget Usage
BuildFeature(icon: Icons.wifi, text: 'WiFi', size: 20)

### 4. State Management Rules
- Use Cubit exclusively (no events files)
- UI widgets use BlocBuilder or BlocConsumer
- Use emit(const FeatureLoading()) pattern
- Use .fold() for Either returns
- Always extend Equatable for states

### 5. Shared Feature
lib/features/shared/ contains widgets shared ONLY between rooms and apartments.
- Used by 3+ features → move to lib/core/widgets/
- Used only by rooms and apartments → keep in lib/features/shared/

## Workflow for New Features

Step 1: Create folder structure (data/models, data/repos, presentation/manager, presentation/views)
Step 2: Create state file (following filter_state.dart pattern)
Step 3: Create cubit file (following filter_cubit.dart pattern)
Step 4: Create abstract repository
Step 5: Create repository implementation (uses ApiService)
Step 6: Register in service_locator.dart
Step 7: Create UI view (uses core widgets, constants, screenutil)
Step 8: Add routes to app_routing.dart (if needed)

## What NOT To Do

1. Never hardcode strings - use AppStrings
2. Never hardcode colors - use AppColors
3. Never hardcode text styles - use AppStyles
4. Never create a widget without checking core/widgets/ first
5. Never use full BLoC with events - use Cubit only
6. Never call API directly in Cubit - always go through repository
7. Never ignore error handling - always use .fold() for repository results
8. Never use raw dimensions - always use .w, .h, .sp, .r

## Example Prompts

Create a new feature:
"Create a new 'favorites' feature following the exact pattern from filter feature. Use Cubit with states (loading, success, failure). Create repository with abstract + impl using ApiService. Register in service_locator.dart. Reuse custom_elevated_button.dart. Use AppColors, AppStyles, AppStrings."

Create a new screen:
"Add EditProfileView to profile feature. Use custom_text_form_field.dart for inputs. Use custom_elevated_button.dart for save button. Create EditProfileCubit following auth_cubit.dart pattern. Use AppStrings for labels. Make responsive with screenutil."

Reuse BuildFeature:
"Create a widget that displays apartment amenities using BuildFeature. Take a list of (icon, name) pairs. Use Wrap with spacing 8.w. Each amenity uses BuildFeature with size 20."

## AI Assistant Rules

1. NEVER create a widget without first checking lib/core/widgets/
2. NEVER hardcode anything - always use constants
3. ALWAYS use Cubit pattern exactly as in filter_cubit.dart
4. ALWAYS use screenutil for all dimensions
5. ALWAYS use .fold() for repository error handling
6. ALWAYS register new dependencies in service_locator.dart
7. ALWAYS use ServerFailure.fromDioError(e) for Dio exceptions
8. When unsure, ask clarifying questions before generating code
9. When generating a widget, state which core widgets you're reusing
10. Follow the import order exactly