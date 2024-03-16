import 'package:city_eye/src/di/injector.dart';
import 'package:city_eye/src/domain/usecase/add_family_member_validation_use_case.dart';
import 'package:city_eye/src/domain/usecase/add_service_details_use_case.dart';
import 'package:city_eye/src/domain/usecase/add_user_family_member_use_case.dart';
import 'package:city_eye/src/domain/usecase/badge_identity/get_badge_identity_use_case.dart';
import 'package:city_eye/src/domain/usecase/change_password_use_case.dart';
import 'package:city_eye/src/domain/usecase/add_user_unit_car_use_case.dart';
import 'package:city_eye/src/domain/usecase/change_password_validation_use_case.dart';
import 'package:city_eye/src/domain/usecase/change_service_state_use_case.dart';
import 'package:city_eye/src/domain/usecase/community/community_validator_use_case.dart';
import 'package:city_eye/src/domain/usecase/community/submit_community_request_use_case.dart';
import 'package:city_eye/src/domain/usecase/complain/submit_complain_use_case.dart';
import 'package:city_eye/src/domain/usecase/contact_us/add_contact_us_use_case.dart';
import 'package:city_eye/src/domain/usecase/contact_us/contact_us_validation_use_case.dart';
import 'package:city_eye/src/domain/usecase/contact_us/get_countries_use_case.dart';
import 'package:city_eye/src/domain/usecase/contact_us/set_country_use_case.dart';
import 'package:city_eye/src/domain/usecase/contact_us/validate_country_use_case.dart';
import 'package:city_eye/src/domain/usecase/contact_us/validate_email_use_case.dart';
import 'package:city_eye/src/domain/usecase/contact_us/validate_message_use_case.dart';
import 'package:city_eye/src/domain/usecase/contact_us/validate_mobile_number_use_case.dart';
import 'package:city_eye/src/domain/usecase/contact_us/validate_name_use_case.dart';
import 'package:city_eye/src/domain/usecase/create_qr_code_use_case.dart';
import 'package:city_eye/src/domain/usecase/delegated/authorized_widget/authorized_widget_validation_use_case.dart';
import 'package:city_eye/src/domain/usecase/delegated/authorized_widget/validate_authorized_mobile_number_use_case.dart';
import 'package:city_eye/src/domain/usecase/delegated/authorized_widget/validate_authorized_name_use_case.dart';
import 'package:city_eye/src/domain/usecase/delegated/delete_delegated_use_case.dart';
import 'package:city_eye/src/domain/usecase/delegated/get_delegated_data_use_case.dart';
import 'package:city_eye/src/domain/usecase/delegated/owner_widget/get_owner_information_use_case.dart';
import 'package:city_eye/src/domain/usecase/delegated/owner_widget/owner_widget_validation_use_case.dart';
import 'package:city_eye/src/domain/usecase/delegated/owner_widget/validate_date_use_case.dart';
import 'package:city_eye/src/domain/usecase/delegated/owner_widget/validate_id_use_case.dart';
import 'package:city_eye/src/domain/usecase/delegated/owner_widget/validate_image_selection_use_case.dart';
import 'package:city_eye/src/domain/usecase/delegated/owner_widget/validate_owner_message_use_case.dart';
import 'package:city_eye/src/domain/usecase/delegated/owner_widget/validate_questions_use_case.dart';
import 'package:city_eye/src/domain/usecase/delegated/submit_delegation_use_case.dart';
import 'package:city_eye/src/domain/usecase/delegated/validate_signature_use_case.dart';
import 'package:city_eye/src/domain/usecase/delete_account_use_case.dart';
import 'package:city_eye/src/domain/usecase/delete_car_use_case.dart';
import 'package:city_eye/src/domain/usecase/delete_unit_use_case.dart';
import 'package:city_eye/src/domain/usecase/delete_user_unit_car_use_case.dart';
import 'package:city_eye/src/domain/usecase/describe_problem_validation_use_case.dart';
import 'package:city_eye/src/domain/usecase/dynamic_question_validation_use_case.dart';
import 'package:city_eye/src/domain/usecase/edit_mobile_number_use_case.dart';
import 'package:city_eye/src/domain/usecase/forget_password_validation_use_case.dart';
import 'package:city_eye/src/domain/usecase/forgot_password_use_case.dart';
import 'package:city_eye/src/domain/usecase/gallery_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_can_navigate_to_badge_screen_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_city_compounds_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_compound_configuration_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_compound_units_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_current_country_code_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_event_details_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_events_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_family_relation_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_firebase_notification_token_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_is_app_language_changed_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_qr_code_index_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_support_index_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_switch_logo_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_landing_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_language_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_languages_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_local_compound_configuration_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_lookup_data_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_my_order_payment_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_my_orders_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_no_internet_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_notifications_switch_button_value_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_offers_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_order_comments_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_page_fields_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_qr_code_question_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_remember_me_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_support_service_index_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_total_price_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_user_information_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_user_profile_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_user_unit_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_user_units_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_wall_item_id_use_case.dart';
import 'package:city_eye/src/domain/usecase/home/filter_home_services_for_specific_service_usecase.dart';
import 'package:city_eye/src/domain/usecase/home/filter_home_services_usecase.dart';
import 'package:city_eye/src/domain/usecase/home/get_home_compound_use_case.dart';
import 'package:city_eye/src/domain/usecase/home/get_notifications_count_use_case.dart';
import 'package:city_eye/src/domain/usecase/is_there_items_in_cart_use_case.dart';
import 'package:city_eye/src/domain/usecase/login_use_case.dart';
import 'package:city_eye/src/domain/usecase/minus_service_details_use_case.dart';
import 'package:city_eye/src/domain/usecase/my_order_cancel_use_case.dart';
import 'package:city_eye/src/domain/usecase/my_subscription/get_my_subscription_data_use_case.dart';
import 'package:city_eye/src/domain/usecase/notifications/enable_disable_notifications_use_case.dart';
import 'package:city_eye/src/domain/usecase/notifications/get_notification_details_use_case.dart';
import 'package:city_eye/src/domain/usecase/notifications/get_notifications_use_case.dart';
import 'package:city_eye/src/domain/usecase/notifications/update_notification_seen_use_case.dart';
import 'package:city_eye/src/domain/usecase/otp_validation_use_case.dart';
import 'package:city_eye/src/domain/usecase/delete_user_family_member_use_case.dart';
import 'package:city_eye/src/domain/usecase/payment/get_payment_details_use_case.dart';
import 'package:city_eye/src/domain/usecase/payment/get_payment_url_use_case.dart';
import 'package:city_eye/src/domain/usecase/payment/get_payments_use_case.dart';
import 'package:city_eye/src/domain/usecase/qr/change_qr_activation_state_usecase.dart';
import 'package:city_eye/src/domain/usecase/qr/get_qr_configuration_usecase.dart';
import 'package:city_eye/src/domain/usecase/qr/search_qr_history_usecase.dart';
import 'package:city_eye/src/domain/usecase/qr_history/change_enabled_status_qr_item_use_case.dart';
import 'package:city_eye/src/domain/usecase/qr_history/get_qr_details_history_usecase.dart';
import 'package:city_eye/src/domain/usecase/qr/get_qr_history_usecase.dart';
import 'package:city_eye/src/domain/usecase/register_validate_mobile_use_case.dart';
import 'package:city_eye/src/domain/usecase/remove_user_information_use_case.dart';
import 'package:city_eye/src/domain/usecase/remove_user_unit_use_case.dart';
import 'package:city_eye/src/domain/usecase/request_otp_use_case.dart';
import 'package:city_eye/src/domain/usecase/invitation_reset_password_use_case.dart';
import 'package:city_eye/src/domain/usecase/save_compound_configuration_use_case.dart';
import 'package:city_eye/src/domain/usecase/save_current_country_code_use_case.dart';
import 'package:city_eye/src/domain/usecase/save_firebase_notification_token_use_case.dart';
import 'package:city_eye/src/domain/usecase/send_order_comment_use_case.dart';
import 'package:city_eye/src/domain/usecase/send_order_rating_use_case.dart';
import 'package:city_eye/src/domain/usecase/service_details_cart_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_staff_use_case.dart';
import 'package:city_eye/src/domain/usecase/set_can_navigate_to_badge_screen_use_case.dart';
import 'package:city_eye/src/domain/usecase/set_is_app_language_changed_use_case.dart';
import 'package:city_eye/src/domain/usecase/set_qr_code_index_use_case.dart';
import 'package:city_eye/src/domain/usecase/set_support_index_use_case.dart';
import 'package:city_eye/src/domain/usecase/set_switch_logo_use_case.dart';
import 'package:city_eye/src/domain/usecase/set_no_internet_use_case.dart';
import 'package:city_eye/src/domain/usecase/set_wall_item_id_use_case.dart';
import 'package:city_eye/src/domain/usecase/submit_event_use_case.dart';
import 'package:city_eye/src/domain/usecase/submit_service_details_cart_usecase.dart';
import 'package:city_eye/src/domain/usecase/submit_survey_use_case.dart';
import 'package:city_eye/src/domain/usecase/support_details/get_support_compound_configration_use_case.dart';
import 'package:city_eye/src/domain/usecase/support_details/get_support_details_date_use_case.dart';
import 'package:city_eye/src/domain/usecase/support_details/submit_support_use_case.dart';
import 'package:city_eye/src/domain/usecase/switch_language_use_case.dart';
import 'package:city_eye/src/domain/usecase/update_user_documents_use_case.dart';
import 'package:city_eye/src/domain/usecase/update_user_family_member_use_case.dart';
import 'package:city_eye/src/domain/usecase/qr_details/get_qr_details_use_case.dart';
import 'package:city_eye/src/domain/usecase/profile_info_form_validation_use_case.dart';
import 'package:city_eye/src/domain/usecase/register_use_case.dart';
import 'package:city_eye/src/domain/usecase/register_validation_use_case.dart';
import 'package:city_eye/src/domain/usecase/save_user_information_use_case.dart';
import 'package:city_eye/src/domain/usecase/search_compounds_use_case.dart';
import 'package:city_eye/src/domain/usecase/select_compound_use_case.dart';
import 'package:city_eye/src/domain/usecase/select_family_relation_use_case.dart';
import 'package:city_eye/src/domain/usecase/select_prepared_visit_time_use_case.dart';
import 'package:city_eye/src/domain/usecase/select_region_filters_use_case.dart';
import 'package:city_eye/src/domain/usecase/select_region_use_case.dart';
import 'package:city_eye/src/domain/usecase/set_language_use_case.dart';
import 'package:city_eye/src/domain/usecase/set_notifications_switch_button_value_use_case.dart';
import 'package:city_eye/src/domain/usecase/set_remember_me_use_case.dart';
import 'package:city_eye/src/domain/usecase/set_user_unit_use_case.dart';
import 'package:city_eye/src/domain/usecase/sign_in_validation_use_case.dart';
import 'package:city_eye/src/domain/usecase/sort_events_use_case.dart';
import 'package:city_eye/src/domain/usecase/un_select_region_filters_use_case.dart';
import 'package:city_eye/src/domain/usecase/update_user_image_use_case.dart';
import 'package:city_eye/src/domain/usecase/update_user_info_use_case.dart';
import 'package:city_eye/src/domain/usecase/update_user_unit_car_use_case.dart';
import 'package:city_eye/src/domain/usecase/update_user_unit_use_case.dart';
import 'package:city_eye/src/domain/usecase/verify_otp_use_case.dart';
import 'package:city_eye/src/domain/usecase/wall/get_surveys_use_case.dart';
import 'package:city_eye/src/domain/usecase/wall/get_wall_details_use_case.dart';
import 'package:city_eye/src/domain/usecase/wall/get_wall_list_use_case.dart';

Future<void> initializeUseCaseDependencies() async {
  injector.registerFactory<SetLanguageUseCase>(
      () => SetLanguageUseCase(injector()));

  injector.registerFactory<GetLanguageUseCase>(
      () => GetLanguageUseCase(injector()));

  injector.registerFactory<LoginUseCase>(() => LoginUseCase(injector()));

  injector.registerFactory<ChangePasswordValidationUseCase>(
      () => ChangePasswordValidationUseCase());

  injector.registerFactory<GetNotificationsSwitchButtonValueUseCase>(
      () => GetNotificationsSwitchButtonValueUseCase(injector()));

  injector.registerFactory<SetNotificationsSwitchButtonValueUseCase>(
      () => SetNotificationsSwitchButtonValueUseCase(injector()));
  injector.registerFactory<ForgetPasswordValidationUseCase>(
    () => ForgetPasswordValidationUseCase(),
  );

  injector.registerFactory<LoginValidationUseCase>(
    () => LoginValidationUseCase(),
  );
  injector.registerFactory<GetRememberMeUseCase>(() => GetRememberMeUseCase(
        injector(),
      ));

  injector.registerFactory<SetRememberMeUseCase>(() => SetRememberMeUseCase(
        injector(),
      ));
  injector.registerFactory<OTPValidationUseCase>(
    () => OTPValidationUseCase(),
  );

  injector.registerFactory<SaveUserInformationUseCase>(
      () => SaveUserInformationUseCase(
            injector(),
          ));

  injector.registerFactory<GetUserInformationUseCase>(
      () => GetUserInformationUseCase(
            injector(),
          ));

  injector.registerFactory<GetSupportServiceIndexUseCase>(
      () => GetSupportServiceIndexUseCase());

  injector.registerFactory<SelectPreparedVisitTimeUseCase>(
      () => SelectPreparedVisitTimeUseCase());

  injector.registerFactory<DescribeProblemValidationUseCase>(
      () => DescribeProblemValidationUseCase());

  injector.registerFactory<ChangeServiceStateUseCase>(
      () => ChangeServiceStateUseCase());

  injector.registerFactory<AddServiceDetailsUseCase>(
      () => AddServiceDetailsUseCase());

  injector.registerFactory<MinusServiceDetailsUseCase>(
      () => MinusServiceDetailsUseCase());

  injector.registerFactory<GetTotalPriceUseCase>(() => GetTotalPriceUseCase());

  injector.registerFactory<RegisterValidationUseCase>(
    () => RegisterValidationUseCase(),
  );

  injector.registerFactory<SelectRegionFiltersUseCase>(
    () => SelectRegionFiltersUseCase(),
  );

  injector.registerFactory<SelectRegionUseCase>(
    () => SelectRegionUseCase(),
  );

  injector.registerFactory<UnSelectRegionFiltersUseCase>(
    () => UnSelectRegionFiltersUseCase(),
  );

  injector.registerFactory<SearchCompoundsUseCase>(
    () => SearchCompoundsUseCase(),
  );

  injector.registerFactory<GetQrDetailsUseCase>(() => GetQrDetailsUseCase());
  injector.registerFactory<GetMySubscriptionDataUseCase>(
      () => GetMySubscriptionDataUseCase(injector()));

  injector.registerFactory<SortEventsUseCase>(() => SortEventsUseCase());

  injector.registerFactory<GetNotificationsUseCase>(
      () => GetNotificationsUseCase(injector()));

  injector.registerFactory<GetNotificationDetailsUseCase>(
      () => GetNotificationDetailsUseCase(injector()));

  injector.registerFactory<SetCountryUseCase>(() => SetCountryUseCase(
        injector(),
      ));

  injector.registerFactory<ValidateNameUseCase>(() => ValidateNameUseCase());
  injector.registerFactory<ValidateEmailUseCase>(() => ValidateEmailUseCase());
  injector.registerFactory<ValidateMobileNumberUseCase>(
      () => ValidateMobileNumberUseCase());
  injector
      .registerFactory<ValidateCountryUseCase>(() => ValidateCountryUseCase());
  injector
      .registerFactory<ValidateMessageUseCase>(() => ValidateMessageUseCase());

  injector.registerFactory<ContactUsValidationUseCase>(
      () => ContactUsValidationUseCase(
            injector(),
            injector(),
            injector(),
            injector(),
            injector(),
          ));
  injector.registerFactory<GetCountriesUseCase>(
      () => GetCountriesUseCase(injector()));
  injector.registerFactory<AddContactUsUseCase>(
      () => AddContactUsUseCase(injector()));

  injector.registerFactory<GetFamilyRelationUseCase>(
      () => GetFamilyRelationUseCase());
  injector.registerFactory<SelectFamilyRelationUseCase>(
      () => SelectFamilyRelationUseCase());

  injector.registerFactory<AddFamilyMemberValidationUseCase>(
      () => AddFamilyMemberValidationUseCase());

  injector.registerFactory<DeleteCarUseCase>(() => DeleteCarUseCase());

  injector.registerFactory<ProfileInfoFormValidationUseCase>(
      () => ProfileInfoFormValidationUseCase());

  injector.registerFactory<IsThereItemsInCartUseCase>(
      () => IsThereItemsInCartUseCase());

  injector
      .registerFactory<SelectCompoundUseCase>(() => SelectCompoundUseCase());

  injector.registerFactory<ValidateOwnerMessageUseCase>(
      () => ValidateOwnerMessageUseCase());

  injector.registerFactory<ValidateIdUseCase>(() => ValidateIdUseCase());

  injector.registerFactory<ValidateDateUseCase>(() => ValidateDateUseCase());
  injector.registerFactory<ValidateImageSelectionUseCase>(
      () => ValidateImageSelectionUseCase());

  injector.registerFactory<ValidateQuestionsUseCase>(
      () => ValidateQuestionsUseCase());

  injector.registerFactory<OwnerWidgetValidationUseCase>(
      () => OwnerWidgetValidationUseCase(
            injector(),
            injector(),
            injector(),
            injector(),
            injector(),
            injector(),
          ));

  injector.registerFactory<GetOwnerInformationUseCase>(
      () => GetOwnerInformationUseCase());

  injector.registerFactory<ValidateAuthorizedNameUseCase>(
      () => ValidateAuthorizedNameUseCase());
  injector.registerFactory<ValidateAuthorizedMobileNumberUseCase>(
      () => ValidateAuthorizedMobileNumberUseCase());

  injector.registerFactory<ValidateSignatureUseCase>(
      () => ValidateSignatureUseCase());

  injector.registerFactory<AuthorizedWidgetValidationUseCase>(
      () => AuthorizedWidgetValidationUseCase(
            injector(),
            injector(),
            injector(),
            injector(),
            injector(),
          ));
  injector.registerFactory<CommunityValidateQuestionsUseCase>(
      () => CommunityValidateQuestionsUseCase());

  injector.registerFactory<GetUserUnitUseCase>(() => GetUserUnitUseCase(
        injector(),
      ));

  injector.registerFactory<SetUserUnitUseCase>(() => SetUserUnitUseCase(
        injector(),
      ));

  injector.registerFactory<ChangePasswordUseCase>(() => ChangePasswordUseCase(
        injector(),
      ));

  injector.registerFactory<ForgotPasswordUseCase>(() => ForgotPasswordUseCase(
        injector(),
      ));

  injector.registerFactory<GetLanguagesUseCase>(() => GetLanguagesUseCase(
        injector(),
      ));

  injector
      .registerFactory<GetCityCompoundsUseCase>(() => GetCityCompoundsUseCase(
            injector(),
          ));
  injector
      .registerFactory<GetCompoundUnitsUseCase>(() => GetCompoundUnitsUseCase(
            injector(),
          ));
  injector.registerFactory<GetPageFieldsUseCase>(() => GetPageFieldsUseCase(
        injector(),
      ));

  injector.registerFactory<RegisterUseCase>(() => RegisterUseCase(
        injector(),
      ));

  injector.registerFactory<UpdateUserUnitUseCase>(() => UpdateUserUnitUseCase(
        injector(),
      ));

  injector.registerFactory<AddUserFamilyMemberUseCase>(
      () => AddUserFamilyMemberUseCase(
            injector(),
          ));

  injector.registerFactory<UpdateUserFamilyMemberUseCase>(
      () => UpdateUserFamilyMemberUseCase(
            injector(),
          ));

  injector.registerFactory<DeleteUserFamilyMemberUseCase>(
      () => DeleteUserFamilyMemberUseCase(
            injector(),
          ));

  injector
      .registerFactory<UpdateUserUnitCarUseCase>(() => UpdateUserUnitCarUseCase(
            injector(),
          ));

  injector.registerFactory<AddUserUnitCarUseCase>(() => AddUserUnitCarUseCase(
        injector(),
      ));

  injector
      .registerFactory<DeleteUserUnitCarUseCase>(() => DeleteUserUnitCarUseCase(
            injector(),
          ));

  injector.registerFactory<GetUserProfileUseCase>(() => GetUserProfileUseCase(
        injector(),
      ));

  injector.registerFactory<GetLookupDataUseCase>(() => GetLookupDataUseCase(
        injector(),
      ));

  injector.registerFactory<VerifyOTPUseCase>(() => VerifyOTPUseCase(
        injector(),
      ));

  injector.registerFactory<RequestOTPUseCase>(() => RequestOTPUseCase(
        injector(),
      ));

  injector.registerFactory<GetCompoundConfigurationUseCase>(
      () => GetCompoundConfigurationUseCase(
            injector(),
          ));
  injector.registerFactory<GetHomeCompoundUseCase>(() => GetHomeCompoundUseCase(
        injector(),
      ));

  injector.registerFactory<GetLandingUseCase>(() => GetLandingUseCase(
        injector(),
      ));

  injector.registerFactory<GetOffersUseCase>(() => GetOffersUseCase(
        injector(),
      ));

  injector.registerFactory<GetPaymentsUseCase>(() => GetPaymentsUseCase(
        injector(),
      ));

  injector.registerFactory<GetPaymentUrlUseCase>(() => GetPaymentUrlUseCase(
        injector(),
      ));

  injector.registerFactory<GetStaffUseCase>(() => GetStaffUseCase(
        injector(),
      ));

  injector.registerFactory<GalleryUseCase>(() => GalleryUseCase(
        injector(),
      ));

  injector.registerFactory<UpdateUserDocumentsUseCase>(
      () => UpdateUserDocumentsUseCase(
            injector(),
          ));
  injector.registerFactory<UpdateUserInfoUseCase>(() => UpdateUserInfoUseCase(
        injector(),
      ));
  injector.registerFactory<RemoveUserInformationUseCase>(
      () => RemoveUserInformationUseCase(
            injector(),
          ));
  injector.registerFactory<RemoveUserUnitsUseCase>(() => RemoveUserUnitsUseCase(
        injector(),
      ));

  injector.registerFactory<GetEventsUseCase>(() => GetEventsUseCase(
        injector(),
      ));

  injector.registerFactory<GetWallListUseCase>(() => GetWallListUseCase(
        injector(),
      ));

  injector.registerFactory<GetWallDetailsUseCase>(() => GetWallDetailsUseCase(
        injector(),
      ));
  injector.registerFactory<FilterHomeServicesUseCase>(
      () => FilterHomeServicesUseCase());

  injector.registerFactory<FilterHomeServicesForSpecificServiceUseCase>(
      () => FilterHomeServicesForSpecificServiceUseCase());

  injector.registerFactory<ServiceDetailsCartUseCase>(
      () => ServiceDetailsCartUseCase(
            injector(),
          ));

  injector.registerFactory<GetSurveysUseCase>(() => GetSurveysUseCase(
        injector(),
      ));

  injector.registerFactory<SubmitEventUseCase>(() => SubmitEventUseCase(
        injector(),
      ));

  injector.registerFactory<SubmitServiceDetailsCartUseCase>(
      () => SubmitServiceDetailsCartUseCase(injector()));

  injector.registerFactory<SubmitSurveyUseCase>(() => SubmitSurveyUseCase(
        injector(),
      ));

  injector
      .registerFactory<GetQrCodeQuestionUseCase>(() => GetQrCodeQuestionUseCase(
            injector(),
          ));
  injector.registerFactory<CreateQrCodeUseCase>(() => CreateQrCodeUseCase(
        injector(),
      ));
  injector.registerFactory<GetQrHistoryUseCase>(() => GetQrHistoryUseCase(
        injector(),
      ));

  injector.registerFactory<GetQrDetailsHistoryUseCase>(
      () => GetQrDetailsHistoryUseCase(
            injector(),
          ));
  injector.registerFactory<ChangeEnabledStatusQrItemUseCase>(
      () => ChangeEnabledStatusQrItemUseCase());

  injector.registerFactory<SaveCompoundConfigurationUseCase>(
      () => SaveCompoundConfigurationUseCase(
            injector(),
          ));

  injector.registerFactory<GetLocalCompoundConfigurationUseCase>(
      () => GetLocalCompoundConfigurationUseCase(
            injector(),
          ));

  injector.registerFactory<GetSupportDetailsDateUseCase>(
      () => GetSupportDetailsDateUseCase(
            injector(),
          ));
  injector.registerFactory<SupportDetailsConfigurationUseCase>(
      () => SupportDetailsConfigurationUseCase());

  injector.registerFactory<SubmitSupportUseCase>(
      () => SubmitSupportUseCase(injector()));

  injector.registerFactory<MyOrderCancelUseCase>(() => MyOrderCancelUseCase(
        injector(),
      ));

  injector.registerFactory<GetMyOrdersUseCase>(() => GetMyOrdersUseCase(
        injector(),
      ));

  injector.registerFactory<GetMyOrdersPaymentUseCase>(
      () => GetMyOrdersPaymentUseCase(
            injector(),
          ));

  injector.registerFactory<SendOrderRatingUseCase>(() => SendOrderRatingUseCase(
        injector(),
      ));

  injector
      .registerFactory<GetOrderCommentsUseCase>(() => GetOrderCommentsUseCase(
            injector(),
          ));

  injector
      .registerFactory<SendOrderCommentUseCase>(() => SendOrderCommentUseCase(
            injector(),
          ));

  injector.registerFactory<GetUserUnitsUseCase>(() => GetUserUnitsUseCase(
        injector(),
      ));

  injector.registerFactory<UpdateUserImageUseCase>(() => UpdateUserImageUseCase(
        injector(),
      ));

  injector.registerFactory<SubmitCommunityRequestUseCase>(
      () => SubmitCommunityRequestUseCase(
            injector(),
          ));

  injector.registerFactory<SubmitComplainUseCase>(() => SubmitComplainUseCase(
        injector(),
      ));

  injector
      .registerFactory<GetDelegatedDataUseCase>(() => GetDelegatedDataUseCase(
            injector(),
          ));

  injector.registerFactory<DeleteDelegatedUseCase>(() => DeleteDelegatedUseCase(
        injector(),
      ));

  injector
      .registerFactory<SubmitDelegationUseCase>(() => SubmitDelegationUseCase(
            injector(),
          ));

  injector.registerFactory<DeleteUnitUseCase>(() => DeleteUnitUseCase(
        injector(),
      ));

  injector.registerSingleton<EditMobileNumberUseCase>(
      EditMobileNumberUseCase(injector()));

  injector.registerSingleton<GetEventDetailsUseCase>(
      GetEventDetailsUseCase(injector()));

  injector.registerFactory<SaveFirebaseNotificationTokenUseCase>(
      () => SaveFirebaseNotificationTokenUseCase(
            injector(),
          ));

  injector.registerFactory<GetFirebaseNotificationTokenUseCase>(
      () => GetFirebaseNotificationTokenUseCase(
            injector(),
          ));

  injector.registerFactory<SetNoInternetUseCase>(() => SetNoInternetUseCase(
        injector(),
      ));

  injector.registerFactory<GetNoInternetUseCase>(() => GetNoInternetUseCase(
        injector(),
      ));

  injector.registerFactory<SetSwitchLogoUseCase>(() => SetSwitchLogoUseCase(
        injector(),
      ));

  injector.registerFactory<GetSwitchLogoUseCase>(() => GetSwitchLogoUseCase(
        injector(),
      ));

  injector.registerFactory<InvitationResetPasswordUseCase>(
      () => InvitationResetPasswordUseCase(
            injector(),
          ));

  injector.registerFactory<SetSupportIndexUseCase>(() => SetSupportIndexUseCase(
        injector(),
      ));

  injector.registerFactory<GetSupportIndexUseCase>(() => GetSupportIndexUseCase(
        injector(),
      ));

  injector.registerFactory<GetWallItemIdUseCase>(() => GetWallItemIdUseCase(
        injector(),
      ));

  injector.registerFactory<SetWallItemIdUseCase>(() => SetWallItemIdUseCase(
        injector(),
      ));

  injector.registerFactory<GetQrConfigurationUseCase>(
      () => GetQrConfigurationUseCase(
            injector(),
          ));

  injector
      .registerFactory<SearchQrHistoryUseCase>(() => SearchQrHistoryUseCase());

  injector.registerFactory<ChangeQrActivationStatusUseCase>(
      () => ChangeQrActivationStatusUseCase(
            injector(),
          ));

  injector
      .registerFactory<GetPaymentDetailsUseCase>(() => GetPaymentDetailsUseCase(
            injector(),
          ));

  injector.registerFactory<EnableDisableNotificationsUseCase>(
      () => EnableDisableNotificationsUseCase(injector()));

  injector.registerFactory<RegisterValidateMobileUseCase>(
      () => RegisterValidateMobileUseCase(
            injector(),
          ));

  injector
      .registerFactory<GetBadgeIdentityUseCase>(() => GetBadgeIdentityUseCase(
            injector(),
          ));

  injector.registerFactory<DeleteAccountUseCase>(() => DeleteAccountUseCase(
        injector(),
      ));

  injector.registerFactory<DynamicQuestionValidationUseCase>(
      () => DynamicQuestionValidationUseCase());

  injector.registerFactory<GetCanNavigateToBadgeScreenUseCase>(
      () => GetCanNavigateToBadgeScreenUseCase(
            injector(),
          ));

  injector.registerFactory<SetCanNavigateToBadgeScreenUseCase>(
      () => SetCanNavigateToBadgeScreenUseCase(
            injector(),
          ));

  injector.registerFactory<UpdateNotificationSeenUseCase>(
      () => UpdateNotificationSeenUseCase(injector()));

  injector.registerFactory<GetNotificationsCountUseCase>(
      () => GetNotificationsCountUseCase(
            injector(),
          ));

  injector.registerFactory<SaveCurrentCountryCodeUseCase>(
      () => SaveCurrentCountryCodeUseCase(
            injector(),
          ));

  injector.registerFactory<GetCurrentCountryCodeUseCase>(
      () => GetCurrentCountryCodeUseCase(
            injector(),
          ));

  injector.registerFactory<SetQrCodeIndexUseCase>(() => SetQrCodeIndexUseCase(
        injector(),
      ));

  injector.registerFactory<GetQrCodeIndexUseCase>(() => GetQrCodeIndexUseCase(
        injector(),
      ));

  injector.registerFactory<SwitchLanguageUseCase>(() => SwitchLanguageUseCase(
        injector(),
      ));

  injector.registerFactory<SetIsAppLanguageChangedUseCase>(() => SetIsAppLanguageChangedUseCase(
        injector(),
      ));

  injector.registerFactory<GetIsAppLanguageChangedUseCase>(() => GetIsAppLanguageChangedUseCase(
        injector(),
      ));
}
