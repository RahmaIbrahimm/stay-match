import 'package:flutter/foundation.dart';
import 'package:stay_match/Features/add_property/data/models/add_room_request.dart';
import '../../../data/models/add_apartment_request.dart';

class ValidationHelper {
  // --- Text Field Validators (Return String for UI red text) ---

  /// Validates the property name (Required & Min 10 chars)
  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) return 'Property name is required';
    if (value.trim().length < 10) return 'Name must be at least 10 characters';
    return null;
  }

  /// Validates the property description (Required & Min 10 chars)
  static String? validateDescription(String? value) {
    if (value == null || value.trim().isEmpty) return 'Description is required';
    if (value.trim().length < 10) return 'Description must be at least 10 characters';
    return null;
  }

  /// General required field validator
  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) return '$fieldName is required';
    return null;
  }

  /// Validates numbers like Rent or Size
  static String? validateNumeric(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) return '$fieldName is required';
    final n = num.tryParse(value);
    if (n == null || n <= 0) return '$fieldName must be greater than 0';
    return null;
  }

  // --- Step Logic Checkers (With Debug Logs) ---

  /// Step 1: Basic Information Logic
  static bool isBasicInfoApartmentValid(AddApartmentRequest req) {
    debugPrint('--- 📝 VALIDATING STEP 1: BASIC INFO ---');
    final t = req.allowedTenants;

    // Rule: At least one human category must be selected (Pets alone is invalid)
    final bool hasHumanTenant = t != null &&
        (t.allowsFamilies == true ||
            t.allowsChildren == true ||
            t.allowsStudents == true ||
            t.allowsWorkers == true);

    final bool nameValid = (req.name?.trim().length ?? 0) >= 10;
    final bool descValid = (req.description?.trim().length ?? 0) >= 10;
    final bool rentValid = (req.monthlyRent ?? 0) > 0;
    final bool hasDate = req.availableFrom != null;

    // Genders for specialized categories
    final bool gendersValid = t?.workerGender != null && t?.studentGender != null;

    if (!nameValid) debugPrint('❌ Fail: Name length is ${req.name?.length ?? 0} (Min 10)');
    if (!descValid) debugPrint('❌ Fail: Description length is ${req.description?.length ?? 0} (Min 10)');
    if (!rentValid) debugPrint('❌ Fail: Monthly Rent is ${req.monthlyRent}');
    if (!hasHumanTenant) debugPrint('❌ Fail: No human tenant selected (Pets only or empty)');
    if (!gendersValid) debugPrint('❌ Fail: Worker or Student Genders are NULL');
    if (!hasDate) debugPrint('❌ Fail: Available Date is NULL');

    final bool overall = nameValid && descValid && rentValid && gendersValid && hasDate && hasHumanTenant;

    if (overall) debugPrint('✅ STEP 1 VALID');
    return overall;
  }
  static bool isBasicInfoSharedApartmentValid(AddRoomRequest req) {
    debugPrint('--- 📝 VALIDATING SHARED APARTMENT STEP 1 ---');

    final bool nameValid = (req.name?.trim().length ?? 0) >= 10;
    final bool descValid = (req.description?.trim().length ?? 0) >= 10;
    final bool roomsValid = (req.totalRooms ?? 0) > 0;

    // Basic Location check (Since it's on the same screen in your UI)
    final bool locationValid = (req.government?.isNotEmpty ?? false) &&
        (req.city?.isNotEmpty ?? false) &&
        (req.latitude != null && req.latitude != 0);

    if (!nameValid) debugPrint('❌ Fail: Name too short');
    if (!descValid) debugPrint('❌ Fail: Description too short');
    if (!roomsValid) debugPrint('❌ Fail: Total rooms must be > 0');
    if (!locationValid) debugPrint('❌ Fail: Location/Map not selected');

    return nameValid && descValid && roomsValid && locationValid;
  }
  /// Step 3: Map Location and Image Gallery Logic
  static bool isLocationAndGalleryValid(AddApartmentRequest req) {
    debugPrint('--- 📍 VALIDATING STEP 3: LOCATION & GALLERY ---');

    final bool hasCoords =
        req.latitude != null && req.longitude != null && req.latitude != 0;

    final bool hasAddress =
        (req.government?.isNotEmpty ?? false) &&
            (req.city?.isNotEmpty ?? false);

    final bool hasImages =
        req.propertyImages != null && req.propertyImages!.isNotEmpty;

    if (!hasCoords) debugPrint('❌ Fail: Map Coordinates missing or (0,0)');
    if (!hasAddress) debugPrint('❌ Fail: Government/City address missing');
    if (!hasImages) debugPrint('❌ Fail: Gallery is empty (Min 1 image)');

    final bool overall = hasCoords && hasAddress && hasImages;

    if (overall) debugPrint('✅ STEP 3 VALID');
    return overall;
  }
}