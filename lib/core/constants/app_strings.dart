abstract class AppStrings {
  // ==========================================
  // AUTHENTICATION & FORMS
  // ==========================================
  static const email = 'Email';
  static const emailAddress = 'Email Address';
  static const confirmEmail = 'Confirm Email';
  static const enterYourEmail = 'Enter your Email';

  static const password = 'Password';
  static const newPassword = 'New Password';
  static const confirmPassword = 'Confirm Password';
  static const enterYourPassword = 'Enter your password';
  static const pleaseWriteNewPass = 'Please write your new password';
  static const enterYourNewPass = 'Enter your new password';

  static const name = 'Name';
  static const firstName = 'First Name';
  static const lastName = 'Last Name';
  static const enterYourName = 'Enter your name';
  static const enterYourFirstName = 'Enter your first name';
  static const enterYourLastName = 'Enter your last name';

  static const birthDate = 'Birth Date';
  static const dateFormat = 'YYYY-MM-DD';
  static const enterYourBirthDate = 'Enter your birth date';

  static const gender = 'Gender';
  static const enterYourGender = 'Enter your gender';
  static const male = 'Male';
  static const female = 'Female';
  static const List<String> authGenderMenuItems = ['Female', 'Male'];
  static const List<String> genderMenuItems = ['any','Female', 'Male'];

  // ==========================================
  // AUTH SCREENS (GREETINGS & NAVIGATION)
  // ==========================================
  static const login = 'Login';
  static const loginGreeting = 'Welcome Back To StayMatch';
  static const loginWithGoogle = 'Login with Google';

  static const signUp = 'Sign Up !';
  static const signUpTitle = 'Sign Up';
  static const signUpGreeting = 'Welcome To StayMatch';

  static const forgetPassword = 'Forget Password';
  static const forgetPasswordQuestion = 'Forget Password ?';
  static const forgetPasswordInstructions = 'Please Write your Email to receive a\nconfirmation code. ';

  static const verifyEmailAddress = 'Verify Email Address';
  static const verificationCodeSentTo = 'Verification code sent to :';
  static const resendConfirmation = 'Resend Confirmation code';
  static const confirmCode = 'Confirm code';

  static const alreadyHaveAnAccount = 'Already Have an Account?';
  static const dontHaveAnAccount = 'Don\'t Have an Account?';
  static const or = 'OR';
  static const submit = 'Submit';
  static const phone = 'Phone';
  static const fullName = 'Full Name';

  // ==========================================
  // HOME PAGE & CORE NAVIGATION
  // ==========================================
  static const stayMatch = 'StayMatch';
  static const homeHeader = 'helps you find the perfect home and the most compatible roommate.';
  static const home = 'Home';
  static const apartments = 'Apartments';
  static const matches = 'Matches';
  static const chats = 'Chats';
  static const profile = 'Profile';

  static const myProperties = 'My Properties';
  static const addProperty = 'Add Property';
  static const addYourProperty = '"Add your property with ease"';
  static const shareApartmentDetails = 'Share your property details and reach the right people instantly';
  static const viewAllProperties = 'View All Properties';

  // ==========================================
  // BROWSE / SEARCH / FILTER
  // ==========================================
  static const search = 'Search';
  static const searchHome = 'Search by Area / Person';
  static const searchConvo = 'Search conversations';
  static const where = 'Where';
  static const when = 'When';
  static const who = 'Who';
  static const selectCity = 'Select City';
  static const selectGovernorate = 'Select Governorate';
  static const city = 'City';
  static const chooseYourCity = 'Choose your city';
  static const governorate = 'Governorate';

  static const newest = 'Newest';
  static const oldest = 'oldest';
  static const sortedBy = 'Sorted by:';
  static const apply = 'Apply';
  static const confirm = 'Confirm';
  static const available = 'Available';

  static const checkOut = 'Checkout';
  static const addMonths = 'add Months';
  static const theCheckInDateCantBeEmpty = 'the Check in date can\'t be empty';
  static const List<String> weekDayLabels = ['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT'];

  // ==========================================
  // APARTMENTS & ROOMS (GENERAL)
  // ==========================================
  static const rentWholeApartment = 'Rent A Whole Apartment';
  static const rentRoom = 'Rent A Room';
  static const findYourApartment = 'Find Your Apartment';
  static const findYourRoom = 'Find Your Room';
  static const discoverApartments = 'Discover Apartments';
  static const discoverRooms = 'Discover Rooms';
  static const viewAllApartments = 'View All Apartments';
  static const viewAllRooms = 'View All Rooms';
  static const handPickedApartments = 'Handpicked Apartments with high compatibility score';
  static const handPickedRooms = 'Handpicked Rooms with high compatibility score';

  static const browseApartment = 'Browse Apartments in your preferred location, Filter by Location And date';
  static const browseRoom = 'Browse Apartments with available rooms in your preferred location, Filter by Location And date';
  static const noRoomsAvailable = 'No Rooms Available';
  static const noApartmentsAvailable = 'No Apartments Available';

  // ==========================================
  // PROPERTY DETAILS & ACTIONS
  // ==========================================
  static const viewDetails = 'View Details';
  static const roomDetails = 'Room Details';
  static const apartmentDetails = 'Apartment Details';
  static const propertyName = 'Property name';
  static const message = 'Message';
  static const bookNow = 'Book Now';
  static const viewReviews = 'View Reviews';
  static const securityDeposit = 'SECURITY DEPOSIT';
  static const minimumStay = 'MINIMUM STAY';
  static const month = 'month';

  // ==========================================
  // PROPERTY LISTING FLOW (ADD PROPERTY)
  // ==========================================
  static const step1Of4 = 'STEP 1 OF 4';
  static const stepProgressPercent = '25% Complete';
  static const whatTypeOfProperty = 'What type of property are you listing?';
  static const selectOptionThatDescribes = 'Select the option that best describes your available space.';

  static const wholeApartment = 'Whole Apartment';
  static const wholeApartmentDesc = 'Entire property for one\nguest/group';
  static const dividedIntoRooms = 'Divided into Rooms';
  static const dividedIntoRoomsDesc = 'Individual rooms within a shared\nproperty';

  static const basicDetails = 'Basic Details';
  static const propertyNameHint = 'e.g. Sunset Villa Apartment';
  static const description = 'Description';
  static const descriptionHint = 'Describe the key features, neighborhood, and amenities...';
  static const monthlyRent = 'Monthly Rent';
  static const sqft = 'sqft';
  static const sqftHint = 'e.g. 1200';
  static const furnished = 'Furnished';
  static const availableFrom = 'Available From';

  static const capacityAndRooms = 'Capacity & Rooms';
  static const bedrooms = 'Bedrooms';
  static const livingRooms = 'Living Rooms';
  static const enSuiteBathrooms = 'En-suite Bathrooms';
  static const guestBathrooms = 'Guest Bathrooms';

  static const allowedTenants = 'Allowed Tenants';
  static const pets = 'Pets';
  static const children = 'Children';
  static const workersProfessionals = 'Workers / Professionals';
  static const preferredGender = 'Preferred Gender';
  static const anyGender = 'Any Gender';
  static const families = 'Families';
  static const students = 'Students';

  static const addressDetails = 'Address Details';
  static const streetAddress = 'Street Address';
  static const streetAddressHint = 'Building name, street, apartment number';
  static const latitude = 'Latitude';
  static const longitude = 'Longitude';
  static const mapPicker = 'Map Picker';

  static const amenities = 'Amenities';
  static const nearbyServices = 'Nearby Services';
  static const propertyGallery = 'Property Gallery';
  static const coverPhoto = 'Cover Photo';
  static const listingDetails = 'Listing Details';
  static const jobTitle = "Job Title";
  static const smoker =  "Smoker";
  static const nightOwl=  "Night Owl";
  static const hasPets=  "Has Pets";
  static const housingPref=  "Housing Preferences";



  // ==========================================
  // BUTTONS & SHARED UI
  // ==========================================
  static const back = 'Back';
  static const next = 'Next';
  static const nextStep = 'Next Step';
  static const continueToStep2 = 'Continue to Step 2';
  static const backToDashboard = 'Back to Dashboard';
  static const complete = 'Complete';
  static const buyNow = 'BUY NOW';
  static const yes = 'Yes';
  static const no = 'No';
  static const selected = 'SELECTED';
  static const tapToRetry = 'Tap to retry';
  static const tryAgain = 'Try Again';
  static const na = 'N/A';
  static const isRequired = 'is required';
  static const editProfile = 'Edit Profile';
  static const saveChanges= 'Save Changes';
  static const deleteAccount= 'Delete Account';
  static const accountSecurity= "Account Security";
  static const aboutMe= 'About Me';
  static const education= "Education";
  static const culturalImportance= "Cultural Importance";
  static const myProfile= "My Profile";
  static const personalInfo= "personalInfo";
  static const typeMessage= "Type a message...";

  // ==========================================
  // DATA LISTS
  // ==========================================
  static const egyptCities = <String>[
    'Alexandria', 'Aswan', 'Asyut', 'Beheira', 'Beni Suef', 'Cairo',
    'Dakahlia', 'Damietta', 'Faiyum', 'Gharbia', 'Giza', 'Ismailia',
    'Kafr El Sheikh', 'Luxor', 'Matrouh', 'Minya', 'Monufia', 'New Valley',
    'North Sinai', 'Port Said', 'Qalyubia', 'Qena', 'Red Sea', 'Sharqia',
    'Sohag', 'South Sinai', 'Suez',
  ];
  static const culturalImportanceSliderOptions = <String>["Low", "Medium", "High", "Essential"];
}