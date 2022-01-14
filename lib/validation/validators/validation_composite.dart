import 'package:meta/meta.dart';

import '../protocols/protocols.dart';
import '../../presentation/protocols/protocols.dart';

class ValidationComposite implements Validation {
  final List<FieldValidation> validations;

  ValidationComposite(this.validations);

  @override
  String validate({
    @required String field,
    @required String value,
  }) {
    for (final validation in validations) {
      if (validation.field == field) {
        final error = validation.validate(value);
        if (error?.isNotEmpty == true) return error;
      }
    }
    return null;
  }
}