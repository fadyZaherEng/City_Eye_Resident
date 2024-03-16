// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Maintenance`
  String get maintenance {
    return Intl.message(
      'Maintenance',
      name: 'maintenance',
      desc: '',
      args: [],
    );
  }

  /// `Wall`
  String get wall {
    return Intl.message(
      'Wall',
      name: 'wall',
      desc: '',
      args: [],
    );
  }

  /// `Services`
  String get services {
    return Intl.message(
      'Services',
      name: 'services',
      desc: '',
      args: [],
    );
  }

  /// `More`
  String get more {
    return Intl.message(
      'More',
      name: 'more',
      desc: '',
      args: [],
    );
  }

  /// `Unable to Load Photo`
  String get errorLoadingImage {
    return Intl.message(
      'Unable to Load Photo',
      name: 'errorLoadingImage',
      desc: '',
      args: [],
    );
  }

  /// `by`
  String get by {
    return Intl.message(
      'by',
      name: 'by',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get forgotPasswordQuestion {
    return Intl.message(
      'Forgot Password?',
      name: 'forgotPasswordQuestion',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email address to reset your password`
  String get pleaseEnterYourEmailSoWeCanHelpYouRecoverYourPassword {
    return Intl.message(
      'Please enter your email address to reset your password',
      name: 'pleaseEnterYourEmailSoWeCanHelpYouRecoverYourPassword',
      desc: '',
      args: [],
    );
  }

  /// `Email Address`
  String get emailAddress {
    return Intl.message(
      'Email Address',
      name: 'emailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get resetPassword {
    return Intl.message(
      'Reset Password',
      name: 'resetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Mobile Number`
  String get mobileNumber {
    return Intl.message(
      'Mobile Number',
      name: 'mobileNumber',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get signIn {
    return Intl.message(
      'Sign In',
      name: 'signIn',
      desc: '',
      args: [],
    );
  }

  /// `Remember Me`
  String get rememberMe {
    return Intl.message(
      'Remember Me',
      name: 'rememberMe',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account yet? `
  String get dontHaveAnAccount {
    return Intl.message(
      'Don\'t have an account yet? ',
      name: 'dontHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Create Account`
  String get createAccount {
    return Intl.message(
      'Create Account',
      name: 'createAccount',
      desc: '',
      args: [],
    );
  }

  /// `Upload Media`
  String get uploadMedia {
    return Intl.message(
      'Upload Media',
      name: 'uploadMedia',
      desc: '',
      args: [],
    );
  }

  /// `Gallery`
  String get gallery {
    return Intl.message(
      'Gallery',
      name: 'gallery',
      desc: '',
      args: [],
    );
  }

  /// `Camera`
  String get camera {
    return Intl.message(
      'Camera',
      name: 'camera',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Rules`
  String get rules {
    return Intl.message(
      'Rules',
      name: 'rules',
      desc: '',
      args: [],
    );
  }

  /// `Support`
  String get support {
    return Intl.message(
      'Support',
      name: 'support',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get myOrders {
    return Intl.message(
      'History',
      name: 'myOrders',
      desc: '',
      args: [],
    );
  }

  /// `Search what you need...`
  String get searchWhatYouNeed {
    return Intl.message(
      'Search what you need...',
      name: 'searchWhatYouNeed',
      desc: '',
      args: [],
    );
  }

  /// `My Services`
  String get myServices {
    return Intl.message(
      'My Services',
      name: 'myServices',
      desc: '',
      args: [],
    );
  }

  /// `My Bookings`
  String get mySubscriptions {
    return Intl.message(
      'My Bookings',
      name: 'mySubscriptions',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get ok {
    return Intl.message(
      'Ok',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `My Profile`
  String get myProfile {
    return Intl.message(
      'My Profile',
      name: 'myProfile',
      desc: '',
      args: [],
    );
  }

  /// `Gallery`
  String get moreGallery {
    return Intl.message(
      'Gallery',
      name: 'moreGallery',
      desc: '',
      args: [],
    );
  }

  /// `Community Request`
  String get communityRequest {
    return Intl.message(
      'Community Request',
      name: 'communityRequest',
      desc: '',
      args: [],
    );
  }

  /// `Community Rules`
  String get compoundRules {
    return Intl.message(
      'Community Rules',
      name: 'compoundRules',
      desc: '',
      args: [],
    );
  }

  /// `Terms & Conditions`
  String get termsAndConditions {
    return Intl.message(
      'Terms & Conditions',
      name: 'termsAndConditions',
      desc: '',
      args: [],
    );
  }

  /// `About Us`
  String get aboutUs {
    return Intl.message(
      'About Us',
      name: 'aboutUs',
      desc: '',
      args: [],
    );
  }

  /// `Staff`
  String get staff {
    return Intl.message(
      'Staff',
      name: 'staff',
      desc: '',
      args: [],
    );
  }

  /// `FAQ`
  String get faq {
    return Intl.message(
      'FAQ',
      name: 'faq',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Report Issues`
  String get reportIssues {
    return Intl.message(
      'Report Issues',
      name: 'reportIssues',
      desc: '',
      args: [],
    );
  }

  /// `Guests`
  String get visitors {
    return Intl.message(
      'Guests',
      name: 'visitors',
      desc: '',
      args: [],
    );
  }

  /// `Sign out`
  String get logout {
    return Intl.message(
      'Sign out',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `The email address field is required`
  String get emailAddressCantBeEmpty {
    return Intl.message(
      'The email address field is required',
      name: 'emailAddressCantBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `check your email`
  String get checkYourEmail {
    return Intl.message(
      'check your email',
      name: 'checkYourEmail',
      desc: '',
      args: [],
    );
  }

  /// `Select Community`
  String get selectCompound {
    return Intl.message(
      'Select Community',
      name: 'selectCompound',
      desc: '',
      args: [],
    );
  }

  /// `Unit Name`
  String get unitNo {
    return Intl.message(
      'Unit Name',
      name: 'unitNo',
      desc: '',
      args: [],
    );
  }

  /// `End `
  String get end {
    return Intl.message(
      'End ',
      name: 'end',
      desc: '',
      args: [],
    );
  }

  /// `The password field is required`
  String get passwordCantBeEmpty {
    return Intl.message(
      'The password field is required',
      name: 'passwordCantBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `The Mobile number field is required`
  String get mobileNumberCantBeEmpty {
    return Intl.message(
      'The Mobile number field is required',
      name: 'mobileNumberCantBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Attend`
  String get join {
    return Intl.message(
      'Attend',
      name: 'join',
      desc: '',
      args: [],
    );
  }

  /// `Not Attend`
  String get notJoin {
    return Intl.message(
      'Not Attend',
      name: 'notJoin',
      desc: '',
      args: [],
    );
  }

  /// `Maybe`
  String get maybe {
    return Intl.message(
      'Maybe',
      name: 'maybe',
      desc: '',
      args: [],
    );
  }

  /// `Hey there!`
  String get heyThere {
    return Intl.message(
      'Hey there!',
      name: 'heyThere',
      desc: '',
      args: [],
    );
  }

  /// `Sign In or Create Your Account Today`
  String get logInOrCreateAccount {
    return Intl.message(
      'Sign In or Create Your Account Today',
      name: 'logInOrCreateAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message(
      'Sign Up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `Our Partners`
  String get ourPartners {
    return Intl.message(
      'Our Partners',
      name: 'ourPartners',
      desc: '',
      args: [],
    );
  }

  /// `Our Features`
  String get ourFeatures {
    return Intl.message(
      'Our Features',
      name: 'ourFeatures',
      desc: '',
      args: [],
    );
  }

  /// `Need Help?`
  String get contactUs {
    return Intl.message(
      'Need Help?',
      name: 'contactUs',
      desc: '',
      args: [],
    );
  }

  /// `Request for Free Consultation`
  String get youCanRequestYourService {
    return Intl.message(
      'Request for Free Consultation',
      name: 'youCanRequestYourService',
      desc: '',
      args: [],
    );
  }

  /// `Contact Us`
  String get requestNow {
    return Intl.message(
      'Contact Us',
      name: 'requestNow',
      desc: '',
      args: [],
    );
  }

  /// `Paid`
  String get paid {
    return Intl.message(
      'Paid',
      name: 'paid',
      desc: '',
      args: [],
    );
  }

  /// `Expiry Date`
  String get expDate {
    return Intl.message(
      'Expiry Date',
      name: 'expDate',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get send {
    return Intl.message(
      'Send',
      name: 'send',
      desc: '',
      args: [],
    );
  }

  /// `OTP`
  String get otp {
    return Intl.message(
      'OTP',
      name: 'otp',
      desc: '',
      args: [],
    );
  }

  /// `Verify`
  String get verify {
    return Intl.message(
      'Verify',
      name: 'verify',
      desc: '',
      args: [],
    );
  }

  /// `We have sent the verification code to your mobile number`
  String get weHaveSentTheCodeVerificationToYourMobileNumber {
    return Intl.message(
      'We have sent the verification code to your mobile number',
      name: 'weHaveSentTheCodeVerificationToYourMobileNumber',
      desc: '',
      args: [],
    );
  }

  /// `Haven't received the code yet?`
  String get dontReceiveCode {
    return Intl.message(
      'Haven\'t received the code yet?',
      name: 'dontReceiveCode',
      desc: '',
      args: [],
    );
  }

  /// `Resend code`
  String get requestAgain {
    return Intl.message(
      'Resend code',
      name: 'requestAgain',
      desc: '',
      args: [],
    );
  }

  /// `Old Password`
  String get oldPassword {
    return Intl.message(
      'Old Password',
      name: 'oldPassword',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get newPassword {
    return Intl.message(
      'New Password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Password confirmation doesn't match password`
  String get sorryTheNewPasswordAndConfirmPasswordDoNotMatch {
    return Intl.message(
      'Password confirmation doesn\'t match password',
      name: 'sorryTheNewPasswordAndConfirmPasswordDoNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `This field is required.`
  String get thisFieldIsRequired {
    return Intl.message(
      'This field is required.',
      name: 'thisFieldIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 6 characters long`
  String get sorryTheNewPasswordMustBeAtLeast6CharactersLong {
    return Intl.message(
      'Password must be at least 6 characters long',
      name: 'sorryTheNewPasswordMustBeAtLeast6CharactersLong',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get changePassword {
    return Intl.message(
      'Change Password',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Version`
  String get version {
    return Intl.message(
      'Version',
      name: 'version',
      desc: '',
      args: [],
    );
  }

  /// `Switch Community`
  String get switchCompound {
    return Intl.message(
      'Switch Community',
      name: 'switchCompound',
      desc: '',
      args: [],
    );
  }

  /// `Owner`
  String get owner {
    return Intl.message(
      'Owner',
      name: 'owner',
      desc: '',
      args: [],
    );
  }

  /// `Tenant`
  String get tenant {
    return Intl.message(
      'Tenant',
      name: 'tenant',
      desc: '',
      args: [],
    );
  }

  /// `Invite Guest.`
  String get createYourQrCode {
    return Intl.message(
      'Invite Guest.',
      name: 'createYourQrCode',
      desc: '',
      args: [],
    );
  }

  /// `Upcoming Events`
  String get events {
    return Intl.message(
      'Upcoming Events',
      name: 'events',
      desc: '',
      args: [],
    );
  }

  /// `See All`
  String get seeAll {
    return Intl.message(
      'See All',
      name: 'seeAll',
      desc: '',
      args: [],
    );
  }

  /// `Surveys`
  String get surveys {
    return Intl.message(
      'Surveys',
      name: 'surveys',
      desc: '',
      args: [],
    );
  }

  /// `Staff`
  String get stuff {
    return Intl.message(
      'Staff',
      name: 'stuff',
      desc: '',
      args: [],
    );
  }

  /// `Error launching phone dialer`
  String get errorLaunchingPhoneDialer {
    return Intl.message(
      'Error launching phone dialer',
      name: 'errorLaunchingPhoneDialer',
      desc: '',
      args: [],
    );
  }

  /// `Please use a valid email`
  String get invalidEmail {
    return Intl.message(
      'Please use a valid email',
      name: 'invalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Stay Connected, Stay Smarter`
  String get stayConnectedStaySmarter {
    return Intl.message(
      'Stay Connected, Stay Smarter',
      name: 'stayConnectedStaySmarter',
      desc: '',
      args: [],
    );
  }

  /// `Sort`
  String get sort {
    return Intl.message(
      'Sort',
      name: 'sort',
      desc: '',
      args: [],
    );
  }

  /// `Wrong code entered`
  String get pleaseEnterAvailedCode {
    return Intl.message(
      'Wrong code entered',
      name: 'pleaseEnterAvailedCode',
      desc: '',
      args: [],
    );
  }

  /// `Sorry! No result found.`
  String get sorryImagesFound {
    return Intl.message(
      'Sorry! No result found.',
      name: 'sorryImagesFound',
      desc: '',
      args: [],
    );
  }

  /// `Search...`
  String get search {
    return Intl.message(
      'Search...',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `Hey, just checking in! Are you sure you want to log out? We love having you in our community. Come back soon!`
  String get areYouSureYouWantToLogOut {
    return Intl.message(
      'Hey, just checking in! Are you sure you want to log out? We love having you in our community. Come back soon!',
      name: 'areYouSureYouWantToLogOut',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Delegated`
  String get delegated {
    return Intl.message(
      'Delegated',
      name: 'delegated',
      desc: '',
      args: [],
    );
  }

  /// `No Internet connection`
  String get noInternetConnection {
    return Intl.message(
      'No Internet connection',
      name: 'noInternetConnection',
      desc: '',
      args: [],
    );
  }

  /// `Check your internet connection and try again.`
  String get noInternetConnectionFoundCheckYourConnectionOrTryAgain {
    return Intl.message(
      'Check your internet connection and try again.',
      name: 'noInternetConnectionFoundCheckYourConnectionOrTryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Try Again`
  String get tryAgain {
    return Intl.message(
      'Try Again',
      name: 'tryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Maintenance Request Details`
  String get supportDetails {
    return Intl.message(
      'Maintenance Request Details',
      name: 'supportDetails',
      desc: '',
      args: [],
    );
  }

  /// `Brief Description`
  String get describeYourRequest {
    return Intl.message(
      'Brief Description',
      name: 'describeYourRequest',
      desc: '',
      args: [],
    );
  }

  /// `Please select an available time.`
  String get preparedVisitTime {
    return Intl.message(
      'Please select an available time.',
      name: 'preparedVisitTime',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get sendRequest {
    return Intl.message(
      'Submit',
      name: 'sendRequest',
      desc: '',
      args: [],
    );
  }

  /// `Do you want keep the values?`
  String get doYouWantKeepTheValues {
    return Intl.message(
      'Do you want keep the values?',
      name: 'doYouWantKeepTheValues',
      desc: '',
      args: [],
    );
  }

  /// `Images:`
  String get images {
    return Intl.message(
      'Images:',
      name: 'images',
      desc: '',
      args: [],
    );
  }

  /// `Images`
  String get image {
    return Intl.message(
      'Images',
      name: 'image',
      desc: '',
      args: [],
    );
  }

  /// `Video Trimmer`
  String get videoTrimmer {
    return Intl.message(
      'Video Trimmer',
      name: 'videoTrimmer',
      desc: '',
      args: [],
    );
  }

  /// `Please ensure that your video is within the specified length limit.`
  String get pleaseEnsureThatYourVideoIsWithinTheSpecifiedLengthLimit {
    return Intl.message(
      'Please ensure that your video is within the specified length limit.',
      name: 'pleaseEnsureThatYourVideoIsWithinTheSpecifiedLengthLimit',
      desc: '',
      args: [],
    );
  }

  /// `Video`
  String get video {
    return Intl.message(
      'Video',
      name: 'video',
      desc: '',
      args: [],
    );
  }

  /// `Photo upload limit reached`
  String get youHaveReachedTheMaximumImageLimit {
    return Intl.message(
      'Photo upload limit reached',
      name: 'youHaveReachedTheMaximumImageLimit',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get today {
    return Intl.message(
      'Today',
      name: 'today',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to save the changes?`
  String get thereAreChangesAppliedToTheVideo {
    return Intl.message(
      'Do you want to save the changes?',
      name: 'thereAreChangesAppliedToTheVideo',
      desc: '',
      args: [],
    );
  }

  /// `Discard`
  String get discard {
    return Intl.message(
      'Discard',
      name: 'discard',
      desc: '',
      args: [],
    );
  }

  /// `Audio`
  String get audio {
    return Intl.message(
      'Audio',
      name: 'audio',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this audio?`
  String get areYouSureYouWantToDeleteThisAudio {
    return Intl.message(
      'Are you sure you want to delete this audio?',
      name: 'areYouSureYouWantToDeleteThisAudio',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this video?`
  String get areYouSureYouWantToDeleteThisVideo {
    return Intl.message(
      'Are you sure you want to delete this video?',
      name: 'areYouSureYouWantToDeleteThisVideo',
      desc: '',
      args: [],
    );
  }

  /// `Activate microphone permission`
  String get youShouldHaveMicroPhonePermission {
    return Intl.message(
      'Activate microphone permission',
      name: 'youShouldHaveMicroPhonePermission',
      desc: '',
      args: [],
    );
  }

  /// `Total of Service`
  String get totalOfService {
    return Intl.message(
      'Total of Service',
      name: 'totalOfService',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get total {
    return Intl.message(
      'Total',
      name: 'total',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continuee {
    return Intl.message(
      'Continue',
      name: 'continuee',
      desc: '',
      args: [],
    );
  }

  /// `KWD`
  String get kwd {
    return Intl.message(
      'KWD',
      name: 'kwd',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to leave this page?`
  String
      get returningToThePreviousScreenWillResetYourCurrentProgressAreYouSureYouWantToProceed {
    return Intl.message(
      'Are you sure you want to leave this page?',
      name:
          'returningToThePreviousScreenWillResetYourCurrentProgressAreYouSureYouWantToProceed',
      desc: '',
      args: [],
    );
  }

  /// `Pre-register Guest`
  String get createQrCode {
    return Intl.message(
      'Pre-register Guest',
      name: 'createQrCode',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get history {
    return Intl.message(
      'History',
      name: 'history',
      desc: '',
      args: [],
    );
  }

  /// `Upload Image`
  String get uploadImage {
    return Intl.message(
      'Upload Image',
      name: 'uploadImage',
      desc: '',
      args: [],
    );
  }

  /// `You approve on`
  String get youApproveOn {
    return Intl.message(
      'You approve on',
      name: 'youApproveOn',
      desc: '',
      args: [],
    );
  }

  /// `Create`
  String get create {
    return Intl.message(
      'Create',
      name: 'create',
      desc: '',
      args: [],
    );
  }

  /// `Activate camera permission`
  String get youShouldHaveCameraPermission {
    return Intl.message(
      'Activate camera permission',
      name: 'youShouldHaveCameraPermission',
      desc: '',
      args: [],
    );
  }

  /// `Create your account`
  String get createYourAccount {
    return Intl.message(
      'Create your account',
      name: 'createYourAccount',
      desc: '',
      args: [],
    );
  }

  /// `Community`
  String get compound {
    return Intl.message(
      'Community',
      name: 'compound',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Documents`
  String get documents {
    return Intl.message(
      'Documents',
      name: 'documents',
      desc: '',
      args: [],
    );
  }

  /// `Community Name`
  String get compoundName {
    return Intl.message(
      'Community Name',
      name: 'compoundName',
      desc: '',
      args: [],
    );
  }

  /// `Unit Number`
  String get unitNumber {
    return Intl.message(
      'Unit Number',
      name: 'unitNumber',
      desc: '',
      args: [],
    );
  }

  /// `Save & Continue`
  String get saveContinue {
    return Intl.message(
      'Save & Continue',
      name: 'saveContinue',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account? `
  String get alreadyHaveAnAccount {
    return Intl.message(
      'Already have an account? ',
      name: 'alreadyHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get login {
    return Intl.message(
      'Sign In',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get fullName {
    return Intl.message(
      'Full Name',
      name: 'fullName',
      desc: '',
      args: [],
    );
  }

  /// `Select Unit`
  String get selectUnit {
    return Intl.message(
      'Select Unit',
      name: 'selectUnit',
      desc: '',
      args: [],
    );
  }

  /// `Search Community`
  String get searchCompound {
    return Intl.message(
      'Search Community',
      name: 'searchCompound',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email address. For example: “Adam@gmail.com”`
  String get pleaseEnterAValidEmailAddressForExample {
    return Intl.message(
      'Please enter a valid email address. For example: “Adam@gmail.com”',
      name: 'pleaseEnterAValidEmailAddressForExample',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get all {
    return Intl.message(
      'All',
      name: 'all',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get back {
    return Intl.message(
      'Back',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Upload Photo`
  String get uploadPhoto {
    return Intl.message(
      'Upload Photo',
      name: 'uploadPhoto',
      desc: '',
      args: [],
    );
  }

  /// `Choose a PDF File to upload`
  String get chooseAPDFFileToUpload {
    return Intl.message(
      'Choose a PDF File to upload',
      name: 'chooseAPDFFileToUpload',
      desc: '',
      args: [],
    );
  }

  /// `Maximum file size is 20MB`
  String get maximusFileSize20MB {
    return Intl.message(
      'Maximum file size is 20MB',
      name: 'maximusFileSize20MB',
      desc: '',
      args: [],
    );
  }

  /// `Edit now`
  String get editNow {
    return Intl.message(
      'Edit now',
      name: 'editNow',
      desc: '',
      args: [],
    );
  }

  /// `Apply`
  String get apply {
    return Intl.message(
      'Apply',
      name: 'apply',
      desc: '',
      args: [],
    );
  }

  /// `Family Member`
  String get familyMember {
    return Intl.message(
      'Family Member',
      name: 'familyMember',
      desc: '',
      args: [],
    );
  }

  /// `Storage permission is needed to proceed`
  String get storagePermissionIsRequiredToProceed {
    return Intl.message(
      'Storage permission is needed to proceed',
      name: 'storagePermissionIsRequiredToProceed',
      desc: '',
      args: [],
    );
  }

  /// `Camera permission is needed to proceed`
  String get cameraPermissionIsRequiredToProceed {
    return Intl.message(
      'Camera permission is needed to proceed',
      name: 'cameraPermissionIsRequiredToProceed',
      desc: '',
      args: [],
    );
  }

  /// `Sorry! No result found.`
  String get noCompoundsFound {
    return Intl.message(
      'Sorry! No result found.',
      name: 'noCompoundsFound',
      desc: '',
      args: [],
    );
  }

  /// `Enter two words each word contains 2 characters.`
  String get enterTwoWordsEachWordContains2Characters {
    return Intl.message(
      'Enter two words each word contains 2 characters.',
      name: 'enterTwoWordsEachWordContains2Characters',
      desc: '',
      args: [],
    );
  }

  /// `Inviter`
  String get inviter {
    return Intl.message(
      'Inviter',
      name: 'inviter',
      desc: '',
      args: [],
    );
  }

  /// `Unit`
  String get unit {
    return Intl.message(
      'Unit',
      name: 'unit',
      desc: '',
      args: [],
    );
  }

  /// `Visitor`
  String get visitor {
    return Intl.message(
      'Visitor',
      name: 'visitor',
      desc: '',
      args: [],
    );
  }

  /// `Type`
  String get type {
    return Intl.message(
      'Type',
      name: 'type',
      desc: '',
      args: [],
    );
  }

  /// `Scan Me`
  String get scanMe {
    return Intl.message(
      'Scan Me',
      name: 'scanMe',
      desc: '',
      args: [],
    );
  }

  /// `Just share the QR code`
  String get justShareYourQrCode {
    return Intl.message(
      'Just share the QR code',
      name: 'justShareYourQrCode',
      desc: '',
      args: [],
    );
  }

  /// `Download the QR code`
  String get downloadQr {
    return Intl.message(
      'Download the QR code',
      name: 'downloadQr',
      desc: '',
      args: [],
    );
  }

  /// `Share`
  String get share {
    return Intl.message(
      'Share',
      name: 'share',
      desc: '',
      args: [],
    );
  }

  /// `City Eye`
  String get cityEye {
    return Intl.message(
      'City Eye',
      name: 'cityEye',
      desc: '',
      args: [],
    );
  }

  /// `Multiple Pass`
  String get multiplePass {
    return Intl.message(
      'Multiple Pass',
      name: 'multiplePass',
      desc: '',
      args: [],
    );
  }

  /// `Single Pass`
  String get singlePass {
    return Intl.message(
      'Single Pass',
      name: 'singlePass',
      desc: '',
      args: [],
    );
  }

  /// `Date (Newest > Oldest)`
  String get dateNewestOldest {
    return Intl.message(
      'Date (Newest > Oldest)',
      name: 'dateNewestOldest',
      desc: '',
      args: [],
    );
  }

  /// `Date (Oldest > Newest)`
  String get dateOldestNewest {
    return Intl.message(
      'Date (Oldest > Newest)',
      name: 'dateOldestNewest',
      desc: '',
      args: [],
    );
  }

  /// `Price (Low > High)`
  String get priceLowHigh {
    return Intl.message(
      'Price (Low > High)',
      name: 'priceLowHigh',
      desc: '',
      args: [],
    );
  }

  /// `Price (High > Low)`
  String get priceHighLow {
    return Intl.message(
      'Price (High > Low)',
      name: 'priceHighLow',
      desc: '',
      args: [],
    );
  }

  /// `The Mobile name field is required`
  String get nameCantBeEmpty {
    return Intl.message(
      'The Mobile name field is required',
      name: 'nameCantBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `The country field is required`
  String get countryCantBeEmpty {
    return Intl.message(
      'The country field is required',
      name: 'countryCantBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `The message field is required`
  String get messageCantBeEmpty {
    return Intl.message(
      'The message field is required',
      name: 'messageCantBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Message Should be more than 30 characters`
  String get messageShouldBeMoreThen10Characters {
    return Intl.message(
      'Message Should be more than 30 characters',
      name: 'messageShouldBeMoreThen10Characters',
      desc: '',
      args: [],
    );
  }

  /// `Please insert your full name`
  String get invalidName {
    return Intl.message(
      'Please insert your full name',
      name: 'invalidName',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email address. For example: “Adam@gmail.com”`
  String get invalidEmailAddress {
    return Intl.message(
      'Please enter a valid email address. For example: “Adam@gmail.com”',
      name: 'invalidEmailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Country`
  String get country {
    return Intl.message(
      'Country',
      name: 'country',
      desc: '',
      args: [],
    );
  }

  /// `Message`
  String get message {
    return Intl.message(
      'Message',
      name: 'message',
      desc: '',
      args: [],
    );
  }

  /// `Choose language`
  String get selectLanguage {
    return Intl.message(
      'Choose language',
      name: 'selectLanguage',
      desc: '',
      args: [],
    );
  }

  /// `By`
  String get byWithSpase {
    return Intl.message(
      'By',
      name: 'byWithSpase',
      desc: '',
      args: [],
    );
  }

  /// `Sorry! No result found.`
  String get noServiceFound {
    return Intl.message(
      'Sorry! No result found.',
      name: 'noServiceFound',
      desc: '',
      args: [],
    );
  }

  /// `Sorry! No result found.`
  String get noSupportFount {
    return Intl.message(
      'Sorry! No result found.',
      name: 'noSupportFount',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this image?`
  String get areYouSureYouWantToDeleteThisImage {
    return Intl.message(
      'Are you sure you want to delete this image?',
      name: 'areYouSureYouWantToDeleteThisImage',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this file?`
  String get areYouSureYouWantToDeleteThisFile {
    return Intl.message(
      'Are you sure you want to delete this file?',
      name: 'areYouSureYouWantToDeleteThisFile',
      desc: '',
      args: [],
    );
  }

  /// `Notification Details`
  String get notificationDetails {
    return Intl.message(
      'Notification Details',
      name: 'notificationDetails',
      desc: '',
      args: [],
    );
  }

  /// `Select Country`
  String get selectCountry {
    return Intl.message(
      'Select Country',
      name: 'selectCountry',
      desc: '',
      args: [],
    );
  }

  /// `Minimum`
  String get minimum {
    return Intl.message(
      'Minimum',
      name: 'minimum',
      desc: '',
      args: [],
    );
  }

  /// `Characters`
  String get characters {
    return Intl.message(
      'Characters',
      name: 'characters',
      desc: '',
      args: [],
    );
  }

  /// `AM`
  String get am {
    return Intl.message(
      'AM',
      name: 'am',
      desc: '',
      args: [],
    );
  }

  /// `PM`
  String get pm {
    return Intl.message(
      'PM',
      name: 'pm',
      desc: '',
      args: [],
    );
  }

  /// `Are you want to choose another video?`
  String get areYouWantToChooseAnotherVideo {
    return Intl.message(
      'Are you want to choose another video?',
      name: 'areYouWantToChooseAnotherVideo',
      desc: '',
      args: [],
    );
  }

  /// `Are you want to choose another audio?`
  String get areYouWantToChooseAnotherAudio {
    return Intl.message(
      'Are you want to choose another audio?',
      name: 'areYouWantToChooseAnotherAudio',
      desc: '',
      args: [],
    );
  }

  /// `Expire Date`
  String get expireDate {
    return Intl.message(
      'Expire Date',
      name: 'expireDate',
      desc: '',
      args: [],
    );
  }

  /// `Session No`
  String get sessionNo {
    return Intl.message(
      'Session No',
      name: 'sessionNo',
      desc: '',
      args: [],
    );
  }

  /// `Session`
  String get sessions {
    return Intl.message(
      'Session',
      name: 'sessions',
      desc: '',
      args: [],
    );
  }

  /// `Sorry! No result found.`
  String get noSupportFound {
    return Intl.message(
      'Sorry! No result found.',
      name: 'noSupportFound',
      desc: '',
      args: [],
    );
  }

  /// `Add Another Unit`
  String get addAnotherUnit {
    return Intl.message(
      'Add Another Unit',
      name: 'addAnotherUnit',
      desc: '',
      args: [],
    );
  }

  /// `Delegate`
  String get delegateName {
    return Intl.message(
      'Delegate',
      name: 'delegateName',
      desc: '',
      args: [],
    );
  }

  /// `Powered by`
  String get poweredBy {
    return Intl.message(
      'Powered by',
      name: 'poweredBy',
      desc: '',
      args: [],
    );
  }

  /// `Complain`
  String get complain {
    return Intl.message(
      'Complain',
      name: 'complain',
      desc: '',
      args: [],
    );
  }

  /// `Brief Description`
  String get describeYourProblem {
    return Intl.message(
      'Brief Description',
      name: 'describeYourProblem',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `No Image Selected`
  String get noImageSelected {
    return Intl.message(
      'No Image Selected',
      name: 'noImageSelected',
      desc: '',
      args: [],
    );
  }

  /// `Thank you. Your complaint has been submitted successfully.`
  String get successYourComplaintHasBeenSubmittedSuccessfully {
    return Intl.message(
      'Thank you. Your complaint has been submitted successfully.',
      name: 'successYourComplaintHasBeenSubmittedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Delete Account`
  String get deleteAccount {
    return Intl.message(
      'Delete Account',
      name: 'deleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to deactivate this unit`
  String get areYouSureYouWantToDeactivateThisUnit {
    return Intl.message(
      'Are you sure you want to deactivate this unit',
      name: 'areYouSureYouWantToDeactivateThisUnit',
      desc: '',
      args: [],
    );
  }

  /// `Maximum`
  String get maximum {
    return Intl.message(
      'Maximum',
      name: 'maximum',
      desc: '',
      args: [],
    );
  }

  /// `Info`
  String get info {
    return Intl.message(
      'Info',
      name: 'info',
      desc: '',
      args: [],
    );
  }

  /// `Files`
  String get files {
    return Intl.message(
      'Files',
      name: 'files',
      desc: '',
      args: [],
    );
  }

  /// `Family`
  String get family {
    return Intl.message(
      'Family',
      name: 'family',
      desc: '',
      args: [],
    );
  }

  /// `Cars`
  String get cars {
    return Intl.message(
      'Cars',
      name: 'cars',
      desc: '',
      args: [],
    );
  }

  /// `Save & Continue`
  String get saveAndContinue {
    return Intl.message(
      'Save & Continue',
      name: 'saveAndContinue',
      desc: '',
      args: [],
    );
  }

  /// `Upload your photo`
  String get uploadYourPhoto {
    return Intl.message(
      'Upload your photo',
      name: 'uploadYourPhoto',
      desc: '',
      args: [],
    );
  }

  /// `Gas No`
  String get gasNo {
    return Intl.message(
      'Gas No',
      name: 'gasNo',
      desc: '',
      args: [],
    );
  }

  /// `Telephone`
  String get telephone {
    return Intl.message(
      'Telephone',
      name: 'telephone',
      desc: '',
      args: [],
    );
  }

  /// `Add New Member`
  String get addNewMember {
    return Intl.message(
      'Add New Member',
      name: 'addNewMember',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get updateMember {
    return Intl.message(
      'Save',
      name: 'updateMember',
      desc: '',
      args: [],
    );
  }

  /// `Relationship`
  String get relationship {
    return Intl.message(
      'Relationship',
      name: 'relationship',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message(
      'Update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `Cousin`
  String get cousin {
    return Intl.message(
      'Cousin',
      name: 'cousin',
      desc: '',
      args: [],
    );
  }

  /// `Father`
  String get father {
    return Intl.message(
      'Father',
      name: 'father',
      desc: '',
      args: [],
    );
  }

  /// `My Grandfather`
  String get myGrandFather {
    return Intl.message(
      'My Grandfather',
      name: 'myGrandFather',
      desc: '',
      args: [],
    );
  }

  /// `Added Successfully`
  String get familyMemberAddedSuccessfully {
    return Intl.message(
      'Added Successfully',
      name: 'familyMemberAddedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Updated Successfully`
  String get familyMemberUpdatedSuccessfully {
    return Intl.message(
      'Updated Successfully',
      name: 'familyMemberUpdatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Deleted Successfully`
  String get familyMemberDeletedSuccessfully {
    return Intl.message(
      'Deleted Successfully',
      name: 'familyMemberDeletedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Sorry! No result found.`
  String get noFamilyFound {
    return Intl.message(
      'Sorry! No result found.',
      name: 'noFamilyFound',
      desc: '',
      args: [],
    );
  }

  /// `Add New Car`
  String get addNewCar {
    return Intl.message(
      'Add New Car',
      name: 'addNewCar',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get updateCar {
    return Intl.message(
      'Save',
      name: 'updateCar',
      desc: '',
      args: [],
    );
  }

  /// `Color`
  String get color {
    return Intl.message(
      'Color',
      name: 'color',
      desc: '',
      args: [],
    );
  }

  /// `Model`
  String get model {
    return Intl.message(
      'Model',
      name: 'model',
      desc: '',
      args: [],
    );
  }

  /// `Plate Number`
  String get plateNumber {
    return Intl.message(
      'Plate Number',
      name: 'plateNumber',
      desc: '',
      args: [],
    );
  }

  /// `Car Added Successfully`
  String get carAddedSuccessfully {
    return Intl.message(
      'Car Added Successfully',
      name: 'carAddedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Updated Successfully`
  String get carUpdatedSuccessfully {
    return Intl.message(
      'Updated Successfully',
      name: 'carUpdatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Deleted Successfully`
  String get carDeletedSuccessfully {
    return Intl.message(
      'Deleted Successfully',
      name: 'carDeletedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Sorry! No result found.`
  String get noCarsFound {
    return Intl.message(
      'Sorry! No result found.',
      name: 'noCarsFound',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this car?`
  String get areYouSureYouWantToDeleteThisCar {
    return Intl.message(
      'Are you sure you want to delete this car?',
      name: 'areYouSureYouWantToDeleteThisCar',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this family member?`
  String get areYouSureYouWantToDeleteThisFamilyMember {
    return Intl.message(
      'Are you sure you want to delete this family member?',
      name: 'areYouSureYouWantToDeleteThisFamilyMember',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to discard the changes?`
  String get areYouSureYouWantToDiscardTheChanges {
    return Intl.message(
      'Are you sure you want to discard the changes?',
      name: 'areYouSureYouWantToDiscardTheChanges',
      desc: '',
      args: [],
    );
  }

  /// `The image is required`
  String get theImageIsRequired {
    return Intl.message(
      'The image is required',
      name: 'theImageIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `The file is required`
  String get theFilIsRequired {
    return Intl.message(
      'The file is required',
      name: 'theFilIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Congratulations! Your account has been successfully created.`
  String get successYouHaveBeenRegisteredSuccessfully {
    return Intl.message(
      'Congratulations! Your account has been successfully created.',
      name: 'successYouHaveBeenRegisteredSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Payment`
  String get payment {
    return Intl.message(
      'Payment',
      name: 'payment',
      desc: '',
      args: [],
    );
  }

  /// `Pay now`
  String get payNow {
    return Intl.message(
      'Pay now',
      name: 'payNow',
      desc: '',
      args: [],
    );
  }

  /// `Expiry Date`
  String get exp {
    return Intl.message(
      'Expiry Date',
      name: 'exp',
      desc: '',
      args: [],
    );
  }

  /// `No payments found`
  String get noPaymentsFound {
    return Intl.message(
      'No payments found',
      name: 'noPaymentsFound',
      desc: '',
      args: [],
    );
  }

  /// `Rating`
  String get rating {
    return Intl.message(
      'Rating',
      name: 'rating',
      desc: '',
      args: [],
    );
  }

  /// `Write a review`
  String get typeYourReview {
    return Intl.message(
      'Write a review',
      name: 'typeYourReview',
      desc: '',
      args: [],
    );
  }

  /// `Please enable storage permission.`
  String get youShouldHaveStoragePermission {
    return Intl.message(
      'Please enable storage permission.',
      name: 'youShouldHaveStoragePermission',
      desc: '',
      args: [],
    );
  }

  /// `This field can not be empty.`
  String get gasNumberCanNotBeEmpty {
    return Intl.message(
      'This field can not be empty.',
      name: 'gasNumberCanNotBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `This field can not be empty.`
  String get telephoneCanNotBeEmpty {
    return Intl.message(
      'This field can not be empty.',
      name: 'telephoneCanNotBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Current`
  String get isCurrent {
    return Intl.message(
      'Current',
      name: 'isCurrent',
      desc: '',
      args: [],
    );
  }

  /// `Previous`
  String get previous {
    return Intl.message(
      'Previous',
      name: 'previous',
      desc: '',
      args: [],
    );
  }

  /// `deactivate`
  String get deactivate {
    return Intl.message(
      'deactivate',
      name: 'deactivate',
      desc: '',
      args: [],
    );
  }

  /// `For`
  String get whatFor {
    return Intl.message(
      'For',
      name: 'whatFor',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to deactivate the QR?`
  String get areYouSureYouWantToDeactivateTheQR {
    return Intl.message(
      'Are you sure you want to deactivate the QR?',
      name: 'areYouSureYouWantToDeactivateTheQR',
      desc: '',
      args: [],
    );
  }

  /// `Valid Date`
  String get validDate {
    return Intl.message(
      'Valid Date',
      name: 'validDate',
      desc: '',
      args: [],
    );
  }

  /// `No QR Code yet`
  String get noQrCodeYet {
    return Intl.message(
      'No QR Code yet',
      name: 'noQrCodeYet',
      desc: '',
      args: [],
    );
  }

  /// `Type Name`
  String get typeName {
    return Intl.message(
      'Type Name',
      name: 'typeName',
      desc: '',
      args: [],
    );
  }

  /// `ID`
  String get id {
    return Intl.message(
      'ID',
      name: 'id',
      desc: '',
      args: [],
    );
  }

  /// `Capture Signature`
  String get captureSignature {
    return Intl.message(
      'Capture Signature',
      name: 'captureSignature',
      desc: '',
      args: [],
    );
  }

  /// `Delegation Time`
  String get delegationTime {
    return Intl.message(
      'Delegation Time',
      name: 'delegationTime',
      desc: '',
      args: [],
    );
  }

  /// `From`
  String get from {
    return Intl.message(
      'From',
      name: 'from',
      desc: '',
      args: [],
    );
  }

  /// `To`
  String get to {
    return Intl.message(
      'To',
      name: 'to',
      desc: '',
      args: [],
    );
  }

  /// `This date should be greater than`
  String get thisDateShouldBeGreaterThan {
    return Intl.message(
      'This date should be greater than',
      name: 'thisDateShouldBeGreaterThan',
      desc: '',
      args: [],
    );
  }

  /// `Select date from first.`
  String get youShouldSelectFromDateFirst {
    return Intl.message(
      'Select date from first.',
      name: 'youShouldSelectFromDateFirst',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want delete this image?`
  String get areYouSureYouWantDeleteThisImage {
    return Intl.message(
      'Are you sure you want delete this image?',
      name: 'areYouSureYouWantDeleteThisImage',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Please allow this permission to continue`
  String get youShouldAllowThisPermissionToContinue {
    return Intl.message(
      'Please allow this permission to continue',
      name: 'youShouldAllowThisPermissionToContinue',
      desc: '',
      args: [],
    );
  }

  /// `Canceled`
  String get canceled {
    return Intl.message(
      'Canceled',
      name: 'canceled',
      desc: '',
      args: [],
    );
  }

  /// `Select date from`
  String get selectFromDate {
    return Intl.message(
      'Select date from',
      name: 'selectFromDate',
      desc: '',
      args: [],
    );
  }

  /// `Select date to`
  String get selectToDate {
    return Intl.message(
      'Select date to',
      name: 'selectToDate',
      desc: '',
      args: [],
    );
  }

  /// `Upload Your ID`
  String get uploadYourId {
    return Intl.message(
      'Upload Your ID',
      name: 'uploadYourId',
      desc: '',
      args: [],
    );
  }

  /// `Authorized`
  String get authorized {
    return Intl.message(
      'Authorized',
      name: 'authorized',
      desc: '',
      args: [],
    );
  }

  /// `Preview`
  String get preview {
    return Intl.message(
      'Preview',
      name: 'preview',
      desc: '',
      args: [],
    );
  }

  /// `This image is required`
  String get thisImageRequired {
    return Intl.message(
      'This image is required',
      name: 'thisImageRequired',
      desc: '',
      args: [],
    );
  }

  /// `Signature is required`
  String get signatureRequired {
    return Intl.message(
      'Signature is required',
      name: 'signatureRequired',
      desc: '',
      args: [],
    );
  }

  /// `Signature`
  String get signature {
    return Intl.message(
      'Signature',
      name: 'signature',
      desc: '',
      args: [],
    );
  }

  /// `Clear`
  String get clear {
    return Intl.message(
      'Clear',
      name: 'clear',
      desc: '',
      args: [],
    );
  }

  /// `Guest Type`
  String get guestType {
    return Intl.message(
      'Guest Type',
      name: 'guestType',
      desc: '',
      args: [],
    );
  }

  /// `Friend`
  String get friend {
    return Intl.message(
      'Friend',
      name: 'friend',
      desc: '',
      args: [],
    );
  }

  /// `Delivery`
  String get delivery {
    return Intl.message(
      'Delivery',
      name: 'delivery',
      desc: '',
      args: [],
    );
  }

  /// `Broker`
  String get broker {
    return Intl.message(
      'Broker',
      name: 'broker',
      desc: '',
      args: [],
    );
  }

  /// `Type your QR`
  String get typeYourQrCode {
    return Intl.message(
      'Type your QR',
      name: 'typeYourQrCode',
      desc: '',
      args: [],
    );
  }

  /// `One Time`
  String get oneTime {
    return Intl.message(
      'One Time',
      name: 'oneTime',
      desc: '',
      args: [],
    );
  }

  /// `Multiple`
  String get multiple {
    return Intl.message(
      'Multiple',
      name: 'multiple',
      desc: '',
      args: [],
    );
  }

  /// `Select Date`
  String get selectDate {
    return Intl.message(
      'Select Date',
      name: 'selectDate',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message(
      'Date',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `Select Day`
  String get selectDay {
    return Intl.message(
      'Select Day',
      name: 'selectDay',
      desc: '',
      args: [],
    );
  }

  /// `Saturday`
  String get saturday {
    return Intl.message(
      'Saturday',
      name: 'saturday',
      desc: '',
      args: [],
    );
  }

  /// `Sunday`
  String get sunday {
    return Intl.message(
      'Sunday',
      name: 'sunday',
      desc: '',
      args: [],
    );
  }

  /// `Monday`
  String get monday {
    return Intl.message(
      'Monday',
      name: 'monday',
      desc: '',
      args: [],
    );
  }

  /// `Tuesday`
  String get tuesday {
    return Intl.message(
      'Tuesday',
      name: 'tuesday',
      desc: '',
      args: [],
    );
  }

  /// `Wednesday`
  String get wednesday {
    return Intl.message(
      'Wednesday',
      name: 'wednesday',
      desc: '',
      args: [],
    );
  }

  /// `Thursday`
  String get thursday {
    return Intl.message(
      'Thursday',
      name: 'thursday',
      desc: '',
      args: [],
    );
  }

  /// `Friday`
  String get friday {
    return Intl.message(
      'Friday',
      name: 'friday',
      desc: '',
      args: [],
    );
  }

  /// `What's your name?`
  String get whatYourName {
    return Intl.message(
      'What\'s your name?',
      name: 'whatYourName',
      desc: '',
      args: [],
    );
  }

  /// `Single`
  String get single {
    return Intl.message(
      'Single',
      name: 'single',
      desc: '',
      args: [],
    );
  }

  /// `Multi`
  String get multi {
    return Intl.message(
      'Multi',
      name: 'multi',
      desc: '',
      args: [],
    );
  }

  /// `Select`
  String get select {
    return Intl.message(
      'Select',
      name: 'select',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to deactivate this delegation?`
  String get areYouSureYouWantToDeactivateThisDelegation {
    return Intl.message(
      'Are you sure you want to deactivate this delegation?',
      name: 'areYouSureYouWantToDeactivateThisDelegation',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to activate the delegation?`
  String get areYouSureYouWantToActivateTheDelegation {
    return Intl.message(
      'Are you sure you want to activate the delegation?',
      name: 'areYouSureYouWantToActivateTheDelegation',
      desc: '',
      args: [],
    );
  }

  /// `You cannot edit the delegation because it is deactivated.`
  String get youCannotEditTheDelegationBecauseItIsDeactivated {
    return Intl.message(
      'You cannot edit the delegation because it is deactivated.',
      name: 'youCannotEditTheDelegationBecauseItIsDeactivated',
      desc: '',
      args: [],
    );
  }

  /// `End date should be after the start date.`
  String get pleaseSelectAnEndDateThatIsLaterThanThe {
    return Intl.message(
      'End date should be after the start date.',
      name: 'pleaseSelectAnEndDateThatIsLaterThanThe',
      desc: '',
      args: [],
    );
  }

  /// `Details`
  String get details {
    return Intl.message(
      'Details',
      name: 'details',
      desc: '',
      args: [],
    );
  }

  /// `DownLoad`
  String get download {
    return Intl.message(
      'DownLoad',
      name: 'download',
      desc: '',
      args: [],
    );
  }

  /// `Visit Date`
  String get visitDate {
    return Intl.message(
      'Visit Date',
      name: 'visitDate',
      desc: '',
      args: [],
    );
  }

  /// `Days`
  String get days {
    return Intl.message(
      'Days',
      name: 'days',
      desc: '',
      args: [],
    );
  }

  /// `Guest /`
  String get guest {
    return Intl.message(
      'Guest /',
      name: 'guest',
      desc: '',
      args: [],
    );
  }

  /// `Expire Date`
  String get qrExpireDate {
    return Intl.message(
      'Expire Date',
      name: 'qrExpireDate',
      desc: '',
      args: [],
    );
  }

  /// `Passport`
  String get passport {
    return Intl.message(
      'Passport',
      name: 'passport',
      desc: '',
      args: [],
    );
  }

  /// `Minimum required images is`
  String get minimumRequiredImagesIs {
    return Intl.message(
      'Minimum required images is',
      name: 'minimumRequiredImagesIs',
      desc: '',
      args: [],
    );
  }

  /// `Deactivate unit`
  String get deactivateUnit {
    return Intl.message(
      'Deactivate unit',
      name: 'deactivateUnit',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to exit?`
  String get areYouSureYouWantExitCityEye {
    return Intl.message(
      'Are you sure you want to exit?',
      name: 'areYouSureYouWantExitCityEye',
      desc: '',
      args: [],
    );
  }

  /// `Comment`
  String get comment {
    return Intl.message(
      'Comment',
      name: 'comment',
      desc: '',
      args: [],
    );
  }

  /// `Time`
  String get time {
    return Intl.message(
      'Time',
      name: 'time',
      desc: '',
      args: [],
    );
  }

  /// `Sorry! No result found.`
  String get sorryNoOrdersFound {
    return Intl.message(
      'Sorry! No result found.',
      name: 'sorryNoOrdersFound',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get orderHistory {
    return Intl.message(
      'History',
      name: 'orderHistory',
      desc: '',
      args: [],
    );
  }

  /// `Rate`
  String get rate {
    return Intl.message(
      'Rate',
      name: 'rate',
      desc: '',
      args: [],
    );
  }

  /// `Type your reason`
  String get typeYourReason {
    return Intl.message(
      'Type your reason',
      name: 'typeYourReason',
      desc: '',
      args: [],
    );
  }

  /// `Support Request`
  String get supportRequest {
    return Intl.message(
      'Support Request',
      name: 'supportRequest',
      desc: '',
      args: [],
    );
  }

  /// `No Messages Yet`
  String get noMessagesYet {
    return Intl.message(
      'No Messages Yet',
      name: 'noMessagesYet',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 6 characters long`
  String get passwordMustBeAtLeast6CharactersLong {
    return Intl.message(
      'Password must be at least 6 characters long',
      name: 'passwordMustBeAtLeast6CharactersLong',
      desc: '',
      args: [],
    );
  }

  /// `Add this event to your calendar?`
  String get doYouWantToAddThisEventToYourDevice {
    return Intl.message(
      'Add this event to your calendar?',
      name: 'doYouWantToAddThisEventToYourDevice',
      desc: '',
      args: [],
    );
  }

  /// `Failed to create the event.`
  String get failedToAddEvent {
    return Intl.message(
      'Failed to create the event.',
      name: 'failedToAddEvent',
      desc: '',
      args: [],
    );
  }

  /// `Added Successfully`
  String get eventAddedSuccessfully {
    return Intl.message(
      'Added Successfully',
      name: 'eventAddedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Password Does not match.`
  String get passwordDoesNotMatch {
    return Intl.message(
      'Password Does not match.',
      name: 'passwordDoesNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Please select the community before choosing the unit.`
  String get pleaseSelectCompoundBeforeChoosingTheUnit {
    return Intl.message(
      'Please select the community before choosing the unit.',
      name: 'pleaseSelectCompoundBeforeChoosingTheUnit',
      desc: '',
      args: [],
    );
  }

  /// `Use English characters only.`
  String get pleaseEnterOnlyEnglishCharactersInThisField {
    return Intl.message(
      'Use English characters only.',
      name: 'pleaseEnterOnlyEnglishCharactersInThisField',
      desc: '',
      args: [],
    );
  }

  /// `Type visitor name`
  String get typeYourName {
    return Intl.message(
      'Type visitor name',
      name: 'typeYourName',
      desc: '',
      args: [],
    );
  }

  /// `Download`
  String get downloadQrCodeDetails {
    return Intl.message(
      'Download',
      name: 'downloadQrCodeDetails',
      desc: '',
      args: [],
    );
  }

  /// `Invalid URL`
  String get notValidUrl {
    return Intl.message(
      'Invalid URL',
      name: 'notValidUrl',
      desc: '',
      args: [],
    );
  }

  /// `The PDF is not valid.`
  String get notValidPdfUrlToDownloadIt {
    return Intl.message(
      'The PDF is not valid.',
      name: 'notValidPdfUrlToDownloadIt',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to activate the QR code?`
  String get areYouSureYouWantToActivateTheQr {
    return Intl.message(
      'Are you sure you want to activate the QR code?',
      name: 'areYouSureYouWantToActivateTheQr',
      desc: '',
      args: [],
    );
  }

  /// `Activate`
  String get activate {
    return Intl.message(
      'Activate',
      name: 'activate',
      desc: '',
      args: [],
    );
  }

  /// `Active`
  String get active {
    return Intl.message(
      'Active',
      name: 'active',
      desc: '',
      args: [],
    );
  }

  /// `Inactive`
  String get inactive {
    return Intl.message(
      'Inactive',
      name: 'inactive',
      desc: '',
      args: [],
    );
  }

  /// `Audio upload limit reached`
  String get youReachedTheMaximumAudioLimit {
    return Intl.message(
      'Audio upload limit reached',
      name: 'youReachedTheMaximumAudioLimit',
      desc: '',
      args: [],
    );
  }

  /// `Video upload limit reached`
  String get youReachedTheMaximumVideoLimit {
    return Intl.message(
      'Video upload limit reached',
      name: 'youReachedTheMaximumVideoLimit',
      desc: '',
      args: [],
    );
  }

  /// `Survey`
  String get survey {
    return Intl.message(
      'Survey',
      name: 'survey',
      desc: '',
      args: [],
    );
  }

  /// `Please choose a package to proceed further`
  String get youMustChoosePackageBeforeProceedingFurther {
    return Intl.message(
      'Please choose a package to proceed further',
      name: 'youMustChoosePackageBeforeProceedingFurther',
      desc: '',
      args: [],
    );
  }

  /// `No Events Yet`
  String get noEventsYet {
    return Intl.message(
      'No Events Yet',
      name: 'noEventsYet',
      desc: '',
      args: [],
    );
  }

  /// `Add unit`
  String get addUnit {
    return Intl.message(
      'Add unit',
      name: 'addUnit',
      desc: '',
      args: [],
    );
  }

  /// `Package Maximum limit reached.`
  String get youHaveReachedTheMaximumLimitOfYourPackage {
    return Intl.message(
      'Package Maximum limit reached.',
      name: 'youHaveReachedTheMaximumLimitOfYourPackage',
      desc: '',
      args: [],
    );
  }

  /// `Person`
  String get person {
    return Intl.message(
      'Person',
      name: 'person',
      desc: '',
      args: [],
    );
  }

  /// `People`
  String get people {
    return Intl.message(
      'People',
      name: 'people',
      desc: '',
      args: [],
    );
  }

  /// `No Events`
  String get noEvents {
    return Intl.message(
      'No Events',
      name: 'noEvents',
      desc: '',
      args: [],
    );
  }

  /// `No Surveys`
  String get noSurveys {
    return Intl.message(
      'No Surveys',
      name: 'noSurveys',
      desc: '',
      args: [],
    );
  }

  /// `Please open the bottom sheet to manage the unit`
  String get pleaseOpenTheBottomSheetToManageTheUnit {
    return Intl.message(
      'Please open the bottom sheet to manage the unit',
      name: 'pleaseOpenTheBottomSheetToManageTheUnit',
      desc: '',
      args: [],
    );
  }

  /// `Number of Users`
  String get totalNumbersOfUsers {
    return Intl.message(
      'Number of Users',
      name: 'totalNumbersOfUsers',
      desc: '',
      args: [],
    );
  }

  /// `Add New`
  String get addNew {
    return Intl.message(
      'Add New',
      name: 'addNew',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to clear signature?`
  String get areYouSureYouWantToClearSignature {
    return Intl.message(
      'Are you sure you want to clear signature?',
      name: 'areYouSureYouWantToClearSignature',
      desc: '',
      args: [],
    );
  }

  /// `Sorry! No result found.`
  String get noPostsFound {
    return Intl.message(
      'Sorry! No result found.',
      name: 'noPostsFound',
      desc: '',
      args: [],
    );
  }

  /// `Sorry! No result found.`
  String get noSubscriptionFound {
    return Intl.message(
      'Sorry! No result found.',
      name: 'noSubscriptionFound',
      desc: '',
      args: [],
    );
  }

  /// `QR Code`
  String get qrCodeTitle {
    return Intl.message(
      'QR Code',
      name: 'qrCodeTitle',
      desc: '',
      args: [],
    );
  }

  /// `Please rate your experience.`
  String get pleaseProvideRatingBeforeSubmitting {
    return Intl.message(
      'Please rate your experience.',
      name: 'pleaseProvideRatingBeforeSubmitting',
      desc: '',
      args: [],
    );
  }

  /// `No Delegated List`
  String get noDelegatedList {
    return Intl.message(
      'No Delegated List',
      name: 'noDelegatedList',
      desc: '',
      args: [],
    );
  }

  /// `Date:`
  String get eventDate {
    return Intl.message(
      'Date:',
      name: 'eventDate',
      desc: '',
      args: [],
    );
  }

  /// `Survey Date`
  String get surveyDate {
    return Intl.message(
      'Survey Date',
      name: 'surveyDate',
      desc: '',
      args: [],
    );
  }

  /// `People who attended the event`
  String get totalMembersWhoJoinedTheEvent {
    return Intl.message(
      'People who attended the event',
      name: 'totalMembersWhoJoinedTheEvent',
      desc: '',
      args: [],
    );
  }

  /// `Select Time`
  String get selectTime {
    return Intl.message(
      'Select Time',
      name: 'selectTime',
      desc: '',
      args: [],
    );
  }

  /// `You can upload a minimum of`
  String get youCanUploadAMinimumOf {
    return Intl.message(
      'You can upload a minimum of',
      name: 'youCanUploadAMinimumOf',
      desc: '',
      args: [],
    );
  }

  /// `image and a maximum of`
  String get imageAndAMaximumOf {
    return Intl.message(
      'image and a maximum of',
      name: 'imageAndAMaximumOf',
      desc: '',
      args: [],
    );
  }

  /// `Verified`
  String get verified {
    return Intl.message(
      'Verified',
      name: 'verified',
      desc: '',
      args: [],
    );
  }

  /// `Unverified`
  String get unverified {
    return Intl.message(
      'Unverified',
      name: 'unverified',
      desc: '',
      args: [],
    );
  }

  /// `Failed to download the QR code. Please try again.`
  String get failedToDownloadTheQrCodePleaseTryAgain {
    return Intl.message(
      'Failed to download the QR code. Please try again.',
      name: 'failedToDownloadTheQrCodePleaseTryAgain',
      desc: '',
      args: [],
    );
  }

  /// `The QR code has been downloaded successfully.`
  String get theQrCodeHasBeenDownloadedSuccessfully {
    return Intl.message(
      'The QR code has been downloaded successfully.',
      name: 'theQrCodeHasBeenDownloadedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `No internet connection found. Check your connection.`
  String get noInternetConnectionFoundCheckYourConnection {
    return Intl.message(
      'No internet connection found. Check your connection.',
      name: 'noInternetConnectionFoundCheckYourConnection',
      desc: '',
      args: [],
    );
  }

  /// `Oops!`
  String get oops {
    return Intl.message(
      'Oops!',
      name: 'oops',
      desc: '',
      args: [],
    );
  }

  /// `Adding to your registered number. For another number, logout and create a new account.`
  String
      get yoCanAddThisUnitToYourExistingNumberToAddNewNumberKindlyCreateNewAccount {
    return Intl.message(
      'Adding to your registered number. For another number, logout and create a new account.',
      name:
          'yoCanAddThisUnitToYourExistingNumberToAddNewNumberKindlyCreateNewAccount',
      desc: '',
      args: [],
    );
  }

  /// `At least one of the following is required: video, image, or audio recording.`
  String get atLeastOneOfTheFollowingIsRequiredVideoImageOrAudioRecording {
    return Intl.message(
      'At least one of the following is required: video, image, or audio recording.',
      name: 'atLeastOneOfTheFollowingIsRequiredVideoImageOrAudioRecording',
      desc: '',
      args: [],
    );
  }

  /// `You should have calendar permission`
  String get youShouldHaveCalendarPermission {
    return Intl.message(
      'You should have calendar permission',
      name: 'youShouldHaveCalendarPermission',
      desc: '',
      args: [],
    );
  }

  /// `Invalid Mobile Number`
  String get invalidMobileNumber {
    return Intl.message(
      'Invalid Mobile Number',
      name: 'invalidMobileNumber',
      desc: '',
      args: [],
    );
  }

  /// `Choice`
  String get choice {
    return Intl.message(
      'Choice',
      name: 'choice',
      desc: '',
      args: [],
    );
  }

  /// `Update family member`
  String get updateFamilyMember {
    return Intl.message(
      'Update family member',
      name: 'updateFamilyMember',
      desc: '',
      args: [],
    );
  }

  /// `Edit phone number`
  String get editPhoneNumber {
    return Intl.message(
      'Edit phone number',
      name: 'editPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `New mobile number`
  String get newMobileNumber {
    return Intl.message(
      'New mobile number',
      name: 'newMobileNumber',
      desc: '',
      args: [],
    );
  }

  /// `Verify your account`
  String get verifyYourAccount {
    return Intl.message(
      'Verify your account',
      name: 'verifyYourAccount',
      desc: '',
      args: [],
    );
  }

  /// `Your code will expire in `
  String get yourCodeWillExpireIn {
    return Intl.message(
      'Your code will expire in ',
      name: 'yourCodeWillExpireIn',
      desc: '',
      args: [],
    );
  }

  /// `Property`
  String get property {
    return Intl.message(
      'Property',
      name: 'property',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get createProfile {
    return Intl.message(
      'Profile',
      name: 'createProfile',
      desc: '',
      args: [],
    );
  }

  /// `Identity`
  String get identity {
    return Intl.message(
      'Identity',
      name: 'identity',
      desc: '',
      args: [],
    );
  }

  /// `Enter the email address associated with your account and we will send you a link to reset your password.`
  String get enterTheEmailAddressAssociatedWithYourAccountAndWe {
    return Intl.message(
      'Enter the email address associated with your account and we will send you a link to reset your password.',
      name: 'enterTheEmailAddressAssociatedWithYourAccountAndWe',
      desc: '',
      args: [],
    );
  }

  /// `No important news, updates or notices from community management.`
  String get noImportantNewsUpdatesOrNoticesFromCommunityManagement {
    return Intl.message(
      'No important news, updates or notices from community management.',
      name: 'noImportantNewsUpdatesOrNoticesFromCommunityManagement',
      desc: '',
      args: [],
    );
  }

  /// `Open Requests`
  String get openRequests {
    return Intl.message(
      'Open Requests',
      name: 'openRequests',
      desc: '',
      args: [],
    );
  }

  /// `All Requests`
  String get allRequests {
    return Intl.message(
      'All Requests',
      name: 'allRequests',
      desc: '',
      args: [],
    );
  }

  /// `Maintenance Request`
  String get supportScreen {
    return Intl.message(
      'Maintenance Request',
      name: 'supportScreen',
      desc: '',
      args: [],
    );
  }

  /// `Maintenance Request`
  String get supportScreenMain {
    return Intl.message(
      'Maintenance Request',
      name: 'supportScreenMain',
      desc: '',
      args: [],
    );
  }

  /// `No Requests Right Now`
  String get noRequestsRightNow {
    return Intl.message(
      'No Requests Right Now',
      name: 'noRequestsRightNow',
      desc: '',
      args: [],
    );
  }

  /// `No Bookings Right Now`
  String get noBookingsRightNow {
    return Intl.message(
      'No Bookings Right Now',
      name: 'noBookingsRightNow',
      desc: '',
      args: [],
    );
  }

  /// `No Family Members Right Now`
  String get noFamilyMembersRightNow {
    return Intl.message(
      'No Family Members Right Now',
      name: 'noFamilyMembersRightNow',
      desc: '',
      args: [],
    );
  }

  /// `No Cars Right Now`
  String get noCarsRightNow {
    return Intl.message(
      'No Cars Right Now',
      name: 'noCarsRightNow',
      desc: '',
      args: [],
    );
  }

  /// `No Payments Right Now`
  String get noPaymentsRightNow {
    return Intl.message(
      'No Payments Right Now',
      name: 'noPaymentsRightNow',
      desc: '',
      args: [],
    );
  }

  /// `This password should be different from the previous password`
  String get thisPasswordShouldBeDifferentFromThePreviousPassword {
    return Intl.message(
      'This password should be different from the previous password',
      name: 'thisPasswordShouldBeDifferentFromThePreviousPassword',
      desc: '',
      args: [],
    );
  }

  /// `Update Password`
  String get updatePassword {
    return Intl.message(
      'Update Password',
      name: 'updatePassword',
      desc: '',
      args: [],
    );
  }

  /// `Quantity`
  String get quantity {
    return Intl.message(
      'Quantity',
      name: 'quantity',
      desc: '',
      args: [],
    );
  }

  /// `Invoice From`
  String get invoiceForm {
    return Intl.message(
      'Invoice From',
      name: 'invoiceForm',
      desc: '',
      args: [],
    );
  }

  /// `Invoice #`
  String get invoice {
    return Intl.message(
      'Invoice #',
      name: 'invoice',
      desc: '',
      args: [],
    );
  }

  /// `Due Date`
  String get dueDate {
    return Intl.message(
      'Due Date',
      name: 'dueDate',
      desc: '',
      args: [],
    );
  }

  /// `Invoice Date`
  String get invoiceDate {
    return Intl.message(
      'Invoice Date',
      name: 'invoiceDate',
      desc: '',
      args: [],
    );
  }

  /// `Subtotal`
  String get subtotal {
    return Intl.message(
      'Subtotal',
      name: 'subtotal',
      desc: '',
      args: [],
    );
  }

  /// `Tax`
  String get tax21 {
    return Intl.message(
      'Tax',
      name: 'tax21',
      desc: '',
      args: [],
    );
  }

  /// `Vat`
  String get vat14 {
    return Intl.message(
      'Vat',
      name: 'vat14',
      desc: '',
      args: [],
    );
  }

  /// `Discount`
  String get discount {
    return Intl.message(
      'Discount',
      name: 'discount',
      desc: '',
      args: [],
    );
  }

  /// `Pay`
  String get pay {
    return Intl.message(
      'Pay',
      name: 'pay',
      desc: '',
      args: [],
    );
  }

  /// `Select Payment Method`
  String get selectPaymentMethod {
    return Intl.message(
      'Select Payment Method',
      name: 'selectPaymentMethod',
      desc: '',
      args: [],
    );
  }

  /// `Kindly complete at least one form above. Your input matters. Thank you!`
  String get toastMessage {
    return Intl.message(
      'Kindly complete at least one form above. Your input matters. Thank you!',
      name: 'toastMessage',
      desc: '',
      args: [],
    );
  }

  /// `Invoice Details`
  String get invoiceDetails {
    return Intl.message(
      'Invoice Details',
      name: 'invoiceDetails',
      desc: '',
      args: [],
    );
  }

  /// `Visit Time`
  String get visitTime {
    return Intl.message(
      'Visit Time',
      name: 'visitTime',
      desc: '',
      args: [],
    );
  }

  /// `Expire Date:`
  String get surveyExpireDate {
    return Intl.message(
      'Expire Date:',
      name: 'surveyExpireDate',
      desc: '',
      args: [],
    );
  }

  /// `?`
  String get questionMark {
    return Intl.message(
      '?',
      name: 'questionMark',
      desc: '',
      args: [],
    );
  }

  /// `Please note: Certain guest types cannot receive invitations on specific days. Thank you for your understanding and cooperation.`
  String get sorryThereAreNoAvailableTimesOnThisDayPleaseChoose {
    return Intl.message(
      'Please note: Certain guest types cannot receive invitations on specific days. Thank you for your understanding and cooperation.',
      name: 'sorryThereAreNoAvailableTimesOnThisDayPleaseChoose',
      desc: '',
      args: [],
    );
  }

  /// `Add the units you own or rent to this account.`
  String get addTheUnitsYouOwnOrRentToThisAccount {
    return Intl.message(
      'Add the units you own or rent to this account.',
      name: 'addTheUnitsYouOwnOrRentToThisAccount',
      desc: '',
      args: [],
    );
  }

  /// `Pre-register entrants using QR codes`
  String get preregisterEntrantsUsingQrCodes {
    return Intl.message(
      'Pre-register entrants using QR codes',
      name: 'preregisterEntrantsUsingQrCodes',
      desc: '',
      args: [],
    );
  }

  /// `All changes will be lost if you leave this page without saving.`
  String get allChangesWillBeLostIfYouLeaveThisPage {
    return Intl.message(
      'All changes will be lost if you leave this page without saving.',
      name: 'allChangesWillBeLostIfYouLeaveThisPage',
      desc: '',
      args: [],
    );
  }

  /// `Badge Identity`
  String get badgeIdentity {
    return Intl.message(
      'Badge Identity',
      name: 'badgeIdentity',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this account`
  String get areYouSureYouWantToDeleteThisUnit {
    return Intl.message(
      'Are you sure you want to delete this account',
      name: 'areYouSureYouWantToDeleteThisUnit',
      desc: '',
      args: [],
    );
  }

  /// `Type your message`
  String get typeYourMessage {
    return Intl.message(
      'Type your message',
      name: 'typeYourMessage',
      desc: '',
      args: [],
    );
  }

  /// `Pin Code`
  String get pinCode {
    return Intl.message(
      'Pin Code',
      name: 'pinCode',
      desc: '',
      args: [],
    );
  }

  /// `We regret to inform you that there are currently no units available. Please check back later or contact support for further assistance.`
  String get weRegretToInformYouThatThereAreCurrentlyNo {
    return Intl.message(
      'We regret to inform you that there are currently no units available. Please check back later or contact support for further assistance.',
      name: 'weRegretToInformYouThatThereAreCurrentlyNo',
      desc: '',
      args: [],
    );
  }

  /// `Keep`
  String get keep {
    return Intl.message(
      'Keep',
      name: 'keep',
      desc: '',
      args: [],
    );
  }

  /// `Keep it short and sweet! Videos are best at`
  String get keepItShortAndSweetVideosAreBestAt {
    return Intl.message(
      'Keep it short and sweet! Videos are best at',
      name: 'keepItShortAndSweetVideosAreBestAt',
      desc: '',
      args: [],
    );
  }

  /// `seconds or less. Thanks!`
  String get secondsOrLessThanks {
    return Intl.message(
      'seconds or less. Thanks!',
      name: 'secondsOrLessThanks',
      desc: '',
      args: [],
    );
  }

  /// `Failed to share image`
  String get failedToShareImage {
    return Intl.message(
      'Failed to share image',
      name: 'failedToShareImage',
      desc: '',
      args: [],
    );
  }

  /// `Maint`
  String get homeSupport {
    return Intl.message(
      'Maint',
      name: 'homeSupport',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `No Stuff Yet`
  String get noStuffYet {
    return Intl.message(
      'No Stuff Yet',
      name: 'noStuffYet',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, brokers' entry not allowed during community vacation. Kindly choose another date`
  String get cannotChooseWeekendDays {
    return Intl.message(
      'Sorry, brokers\' entry not allowed during community vacation. Kindly choose another date',
      name: 'cannotChooseWeekendDays',
      desc: '',
      args: [],
    );
  }

  /// `Day`
  String get day {
    return Intl.message(
      'Day',
      name: 'day',
      desc: '',
      args: [],
    );
  }

  /// `No files yet.`
  String get noFilesYet {
    return Intl.message(
      'No files yet.',
      name: 'noFilesYet',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, `
  String get sorry {
    return Intl.message(
      'Sorry, ',
      name: 'sorry',
      desc: '',
      args: [],
    );
  }

  /// `entry not allowed during community vacation. Kindly choose another date`
  String get entryNotAllowedDuringCommunityVacationKindlyChooseAnotherDate {
    return Intl.message(
      'entry not allowed during community vacation. Kindly choose another date',
      name: 'entryNotAllowedDuringCommunityVacationKindlyChooseAnotherDate',
      desc: '',
      args: [],
    );
  }

  /// `You have been switched to`
  String get youHaveBeenSwitchedTo {
    return Intl.message(
      'You have been switched to',
      name: 'youHaveBeenSwitchedTo',
      desc: '',
      args: [],
    );
  }

  /// `Payment Method`
  String get paymentMethod {
    return Intl.message(
      'Payment Method',
      name: 'paymentMethod',
      desc: '',
      args: [],
    );
  }

  /// `There is no services`
  String get thereIsNoServices {
    return Intl.message(
      'There is no services',
      name: 'thereIsNoServices',
      desc: '',
      args: [],
    );
  }

  /// `There is no maintenance`
  String get thereIsNoMaintenance {
    return Intl.message(
      'There is no maintenance',
      name: 'thereIsNoMaintenance',
      desc: '',
      args: [],
    );
  }

  /// `Downloading...`
  String get downloading {
    return Intl.message(
      'Downloading...',
      name: 'downloading',
      desc: '',
      args: [],
    );
  }

  /// `My Cart`
  String get myCart {
    return Intl.message(
      'My Cart',
      name: 'myCart',
      desc: '',
      args: [],
    );
  }

  /// `Total of services`
  String get totalOfServices {
    return Intl.message(
      'Total of services',
      name: 'totalOfServices',
      desc: '',
      args: [],
    );
  }

  /// `Delivery Fees`
  String get deliveryFees {
    return Intl.message(
      'Delivery Fees',
      name: 'deliveryFees',
      desc: '',
      args: [],
    );
  }

  /// `Check Now`
  String get checkNow {
    return Intl.message(
      'Check Now',
      name: 'checkNow',
      desc: '',
      args: [],
    );
  }

  /// `Get Discount`
  String get getDiscount {
    return Intl.message(
      'Get Discount',
      name: 'getDiscount',
      desc: '',
      args: [],
    );
  }

  /// `Payment Summery`
  String get paymentSummery {
    return Intl.message(
      'Payment Summery',
      name: 'paymentSummery',
      desc: '',
      args: [],
    );
  }

  /// `Apply`
  String get couponApply {
    return Intl.message(
      'Apply',
      name: 'couponApply',
      desc: '',
      args: [],
    );
  }

  /// `Vat`
  String get vat {
    return Intl.message(
      'Vat',
      name: 'vat',
      desc: '',
      args: [],
    );
  }

  /// `Tax`
  String get tax {
    return Intl.message(
      'Tax',
      name: 'tax',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a coupon code`
  String get pleaseEnterACouponCode {
    return Intl.message(
      'Please enter a coupon code',
      name: 'pleaseEnterACouponCode',
      desc: '',
      args: [],
    );
  }

  /// `Confirm replacing the old video with a new one?`
  String get confirmReplacingTheOldVideoWithANewOne {
    return Intl.message(
      'Confirm replacing the old video with a new one?',
      name: 'confirmReplacingTheOldVideoWithANewOne',
      desc: '',
      args: [],
    );
  }

  /// `Confirm replacing the old recording with a new one?`
  String get confirmReplacingTheOldRecordingWithANewOne {
    return Intl.message(
      'Confirm replacing the old recording with a new one?',
      name: 'confirmReplacingTheOldRecordingWithANewOne',
      desc: '',
      args: [],
    );
  }

  /// `Update Now`
  String get updateNow {
    return Intl.message(
      'Update Now',
      name: 'updateNow',
      desc: '',
      args: [],
    );
  }

  /// `The server responded with an unexpected error. Please try again later.`
  String get badResponse {
    return Intl.message(
      'The server responded with an unexpected error. Please try again later.',
      name: 'badResponse',
      desc: '',
      args: [],
    );
  }

  /// `Mobile Number must be 10 digits`
  String get mobileNumberMustBe10Digits {
    return Intl.message(
      'Mobile Number must be 10 digits',
      name: 'mobileNumberMustBe10Digits',
      desc: '',
      args: [],
    );
  }

  /// `Mobile number Should Start with 7`
  String get mobileNumberShouldStartWith7 {
    return Intl.message(
      'Mobile number Should Start with 7',
      name: 'mobileNumberShouldStartWith7',
      desc: '',
      args: [],
    );
  }

  /// `Mobile number Should Start with 10,11,12 or 15`
  String get mobileNumberShouldStartWith101112Or15 {
    return Intl.message(
      'Mobile number Should Start with 10,11,12 or 15',
      name: 'mobileNumberShouldStartWith101112Or15',
      desc: '',
      args: [],
    );
  }

  /// `Cheers! You're In for the Event`
  String get eventJoinMessage {
    return Intl.message(
      'Cheers! You\'re In for the Event',
      name: 'eventJoinMessage',
      desc: '',
      args: [],
    );
  }

  /// `We noticed you haven't joined yet. Why not give it a try? We'd love to have you with us!`
  String get eventNotJoinMessage {
    return Intl.message(
      'We noticed you haven\'t joined yet. Why not give it a try? We\'d love to have you with us!',
      name: 'eventNotJoinMessage',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
