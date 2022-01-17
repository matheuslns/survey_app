import 'package:survey_app/validation/validators/validators.dart';
import 'package:test/test.dart';

import 'package:survey_app/main/factories/factories.dart';

void main() {
  test('Should return the correct validation', () {
    final validations = makeLoginValidations();

    expect(validations, [
      RequiredFieldValidation('email'),
      EmailValidation('email'),
      RequiredFieldValidation('password'),
    ]);
  });
}
