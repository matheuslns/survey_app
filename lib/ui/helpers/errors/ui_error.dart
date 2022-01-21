import '../../helpers/i18n/i18n.dart';

enum UIError {
  requiredField,
  invalidField,
  unexpected,
  invalidCredentials,
}

extension UIErrorExtension on UIError {
  String get description {
    switch (this) {
      case UIError.invalidCredentials:
        return R.strings.invalidCredentials;
      case UIError.invalidField:
        return R.strings.invalidField;
      case UIError.requiredField:
        return R.strings.requiredField;
      default:
        return R.strings.unexpected;
    }
  }
}
