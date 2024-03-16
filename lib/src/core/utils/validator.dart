class Validator {

  static bool isEmailValid(String email) {
    const String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    var regExp = RegExp(pattern);

    return regExp.hasMatch(email.trim());
  }

  static bool isFullNameValid(String fullName) {
    const String pattern =
        r"([a-zA-Z]{2,}\s[a-zA-Z]{1,}'?-?[a-zA-Z]{1,}\s?([a-zA-Z]{1,})?)";

    const String patternAR =
        r"([أ-ي]{2,}\s[أ-ي]{1,}'?-?[أ-ي]{1,}\s?([أ-ي]{1,})?)";

    var regExp = RegExp(pattern);
    var regExpAR = RegExp(patternAR);

    return regExp.hasMatch(fullName.trim()) || regExpAR.hasMatch(fullName.trim());
  }
}
