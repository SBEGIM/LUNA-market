import 'package:haji_market/src/core/constant/localization/localization.dart';
import 'package:haji_market/src/core/utils/extensions/string_extension.dart';

class ValidatorUtil {
  const ValidatorUtil._();

  // static String? emailValidator(
  //   String? value, {
  //   String? errorLabel,
  // }) {
  //   if (value == null || value.isEmpty) {
  //     return errorLabel ?? L10n.current.requiredToFillInTheField;
  //   }
  //   if (!value.emailValidator()) {
  //     return L10n.current.incorrectEmail;
  //   }

  //   return null;
  // }

  // static String? phoneCountryValidator(
  //   String? value, {
  //   required Country contry,
  //   String? errorMessage,
  // }) {
  //   if (errorMessage != null) {
  //     return errorMessage;
  //   }

  //   if (value == null || value.isEmpty) {
  //     return L10n.current.requiredToFillInTheField;
  //   }

  //   if (value.length > contry.example.length) {
  //     if (value.isNumeric()) {
  //       return L10n.current.theMaximumNumberOfDigits(contry.example.length);
  //     } else {
  //       return L10n.current.incorrectFormat;
  //     }
  //   } else if (value.length < contry.example.length) {
  //     if (value.isNumeric()) {
  //       return L10n.current.theMinimumNumberOfDigits(contry.example.length);
  //     } else {
  //       return L10n.current.incorrectFormat;
  //     }
  //   } else {
  //     if (value.isNumeric()) {
  //       return null;
  //     } else {
  //       return L10n.current.incorrectFormat;
  //     }
  //   }
  // }

  static String? phone(
    String? value, {
    String? errorMessage,
  }) {
    if (errorMessage != null) {
      return errorMessage;
    }

    if (value == null || value.isEmpty) {
      return Localization.currentLocalizations.requiredFillIn;
    }
    if (value.length != 10) {
      return Localization.currentLocalizations.incorrectNumberFormat;
    }

    return null;
  }

  static String? passwordValidator(
    String? value, {
    String? errorMessage,
  }) {
    if (errorMessage != null) {
      return errorMessage;
    }

    if (value == null || value.isEmpty) {
      return Localization.currentLocalizations.requiredFillIn;
    }
    if (value.length < 4) {
      return Localization.currentLocalizations.theMinimumPasswordLengthIs4;
    }
    return null;
  }

  static String? notEmptyFieldValidator(
    String? value, {
    String? errorLabel,
  }) {
    if (value == null || value.isEmpty) {
      return errorLabel ?? Localization.currentLocalizations.requiredFillIn;
    }
    return null;
  }

  // static String? fullNameFieldValidator(
  //   String? value, {
  //   String? errorLabel,
  // }) {
  //   if (value == null || value.isEmpty) {
  //     return L10n.current.requiredToFillInTheField;
  //   }
  //   if (!value.trim().contains(' ')) {
  //     return errorLabel ?? L10n.current.enterTheFullName;
  //   }
  //   return null;
  // }

  static bool? showTips(
    String? value,
  ) {
    if (value == null || value.isEmpty) {
      return false;
    }

    if (value.isNumeric()) {
      return true;
    }
    if (value == '+') return true;

    if (value.startsWith('+') && value.isNotEmpty) {
      final str = value.substring(1, value.length);
      if (str.isOnlyDigits() || str.isNumeric()) {
        return true;
      } else {
        return false;
      }
    }

    return null;
  }
}
