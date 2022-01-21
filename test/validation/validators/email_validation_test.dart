import 'package:faker/faker.dart';
import 'package:test/test.dart';

import 'package:survey_app/presentation/protocols/protocols.dart';
import 'package:survey_app/validation/validators/validators.dart';

void main() {
  EmailValidation sut;

  setUp(() {
    sut = EmailValidation('any_field');
  });

  test('Should return null if email is empty', () {
    expect(sut.validate(''), null);
  });

  test('Should return null if email is null', () {
    expect(sut.validate(null), null);
  });

  test('Should return Email inválido if email is invalid', () {
    expect(sut.validate('invalid_email'), ValidationError.invalidField);
  });

  test('Should return null if email is valid', () {
    expect(sut.validate(faker.internet.email()), null);
  });
}
