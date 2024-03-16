class APIKeys {
  static const String baseUrlDevelopment =
      "http://108.181.167.130:8765/CityEye_API_Test_New/api/";
  static const String baseUrlProduction =
      "https://admin.cityeye.online/CityEye_UAT_API/api/";
  static const String baseUrlGhadeerDevelopment =
      "http://108.181.167.130:8765/CityEye_API_Test_New/api/";
  static const String baseUrlGhadeerProduction =
      "https://www.connecteye.ws/CityEye_API_Prod/api/";

  //Login Endpoints
  static const String login = "Mobile/Auth/Login";
  static const String forgotPassword = "Mobile/Auth/ForgetPassword";
  static const String changePassword = "Mobile/Auth/ResetPassword";

  static const String switchLanguage = "Mobile/Auth/SwitchLanguage";

  //Register Endpoints
  static const String register = "Mobile/Auth/Register";
  static const String requestOTP = "Mobile/Auth/RequestNewOTP";
  static const String verifyOTP = "Mobile/Auth/VerifyOTP";
  static const String validateMobile = "Mobile/Auth/ValidateMobile";
  static const String editMobileNumber = "Mobile/Auth/OTPEditMobileNumber";
  static const String cityCompounds = "Mobile/Configration/GetCityCompounds";
  static const String compoundUnits = "Mobile/Configration/GetCompoundUnits";

  // Home EndPoints
  static const String getCompoundHome =
      'Mobile/Configration/GetCompoundHomeSection';
  static const String getUserUnseenNotificationsCount =
      'Mobile/Configration/UnSeenUsersNotificationCount';

  //Settings
  static const String language = "Mobile/LookupData/GetLanguages";
  static const String lookup = "Mobile/LookupData/GetLookupRows";
  static const String getPageFields =
      "Mobile/Configration/GetPageExtrafieldGeneral";
  static const String getCompoundConfigration =
      "Mobile/Configration/GetCompoundConfigration";
  static const String userUnits = "Mobile/Configration/GetUnitsList";
  static const String deleteAccount = "Mobile/Profile/DeleteAccount";

  //Profile Endpoints
  static const String galleryList = "Mobile/Configration/GalleryList";
  static const String galleryDetails = "Mobile/Configration/GalleryDetails";

  //Profile
  static const String userProfile = "Mobile/Profile/GetUserProfile";
  static const String updateUserImage = "Mobile/Profile/UpdateProfileImageUser";
  static const String updateUserInfo =
      "Mobile/Profile/UpdateUserUnitProfileInfo";
  static const String updateUserUnit = "Mobile/Profile/UpdateUserUnit";
  static const String updateUserDocuments =
      "Mobile/Profile/UpdateUserUnitDocument";
  static const String updateUserFamilyMember =
      "Mobile/Profile/UpdateUserUnitFamilyMember";
  static const String addUserFamilyMember =
      "Mobile/Profile/AddUserUnitfamilyMember";
  static const String updateUserCar = "Mobile/Profile/UpdateUserUnitCar";
  static const String addUserCar = "Mobile/Profile/AddUserUnitcar";
  static const String deleteUserFamilyMember =
      "Mobile/Profile/DeleteUserUnitFamilyMember";
  static const String deleteUserCar = "Mobile/Profile/DeleteUserUnitCar";

  // Contact US Endpoints
  static const String getCountries = "Mobile/LookupData/GetCountrys";
  static const String addContactUs = "Mobile/Configration/AddContactUs";

  // Payment
  static const String payment = "Mobile/Transaction/GetInvoices";
  static const String paymentUrl = "Mobile/Transaction/GetPaymentURL";
  static const String paymentDetails = "Mobile/Transaction/GetInvoiceDeatils";

  // Staff
  static const String getCompoundStaff =
      '/Mobile/Configration/GetCompoundStuff';

  //Configuration
  static const String getOffers = "Mobile/Configration/GetOffers";
  static const String landing = "Mobile/Configration/AppHome";
  static const String wallList = "Mobile/Configration/WallList";
  static const String wallDetails = "Mobile/Configration/WallDetails";
  static const String getEventList = "Mobile/Transaction/GetEventList";
  static const String getSurveyList = "Mobile/Configration/GetSurveyList";
  static const String submitSurvey = "Mobile/Configration/SubmitSurvey";

  // Service Details
  static const String servicePackage = "Mobile/Transaction/GetServicePackages";
  static const String submitServiceCart = "Mobile/Transaction/SubmitService";

  //Service
  static const String mySubscription = "Mobile/Transaction/ServiceHistory";

  //Events
  static const String submitEvent = "Mobile/Transaction/SubmitEventTransaction";
  static const String eventDetails = "Mobile/Transaction/GetEventdetails";

  // Support
  static const String supportDetailsDate =
      'Mobile/Transaction/GetSupportcategoryConfiguration';
  static const String submitSupportRequest =
      'Mobile/Transaction/SubmitSupportRequest';
  static const String myOrders = "Mobile/Transaction/GetSupportRequestHistory";
  static const String cancelOrder = "Mobile/Transaction/CancelSupportRequest";
  static const String getPaymentUrl =
      "Mobile/Transaction/GetSupportRequestPaymentUrl";
  static const String orderRating =
      "Mobile/Transaction/UpdateSupportRequestRating";
  static const String getSupportComments =
      "Mobile/Transaction/GetSupportComments";
  static const String sendSupportComment =
      "Mobile/Transaction/AddSupportComment";

  //Qr
  static const String qrConfigurations =
      "Mobile/Transaction/GetQRConfigratuion";
  static const String getQrCodeQuestions =
      "Mobile/Transaction/GetQRcodeQuestion";
  static const String saveQRCode = "Mobile/Transaction/SaveQRCode";
  static const String qrHistory = "Mobile/Transaction/QRCodeList";
  static const String deactivateQrHistory = "Mobile/Transaction/DeactivateQR";
  static const String qrDetailsHistory = "Mobile/Transaction/QRCodeDetails";

  //delegated
  static const String getDelegatedList = "Mobile/Transaction/DelegationHistory";
  static const String deleteDelegated = "Mobile/Transaction/DelegationDelete";
  static const String submitDelegation = "Mobile/Transaction/SubmitDelegation";

  // Notifications
  static const String notifications = "Mobile/Configration/NotificationList";
  static const String notificationDetail =
      "Mobile/Configration/NotificationDetails";
  static const String updateNotificationAsSeen =
      "Mobile/Configration/UpdateNotificationAsSeen";

  static const String enableAndDisableNotifications =
      "Mobile/Transaction/EnableAndDisapleNotifications";

  // Community Request
  static const String submitCommunityRequest =
      "Mobile/Transaction/SubmitCommunity";

  // Complain
  static const String submitComplain = "Mobile/Transaction/SubmitComplain";

  static const String deleteUnit = "Mobile/Profile/DeleteUserUnit";

  static const String invitationResetPassword =
      "Mobile/Auth/InvitationResetDefualtPassword";

  //user badge identity
  static const String getBadgeIdentity = "Mobile/Configration/GenerateBadgeQr";
}
