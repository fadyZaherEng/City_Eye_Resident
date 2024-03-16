import 'package:city_eye/generated/l10n.dart';

String getMobileValidationErrorMessage({
  required String mobileNumber,
  required String regionCode,
}) {
  if ((regionCode == "EG" && mobileNumber.length == 3) ||
      (regionCode == "IQ" && mobileNumber.length == 4)) {
    return S.current.mobileNumberCantBeEmpty;
  } else if (regionCode == "EG" &&
      (!mobileNumber.startsWith("+2010") &&
          !mobileNumber.startsWith("+2011") &&
          !mobileNumber.startsWith("+2012") &&
          !mobileNumber.startsWith("+2015"))) {
    return S.current.mobileNumberShouldStartWith101112Or15;
  } else if (regionCode == "EG" && mobileNumber.length >= 4) {
    return S.current.mobileNumberMustBe10Digits;
  } else if (regionCode == "IQ" && !mobileNumber.startsWith("+9647")) {
    return S.current.mobileNumberShouldStartWith7;
  } else if (regionCode == "IQ" && mobileNumber.length >= 5) {
    return S.current.mobileNumberMustBe10Digits;
  } else {
    return S.current.invalidMobileNumber;
  }
}