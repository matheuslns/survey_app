import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:meta/meta.dart';

import 'package:survey_app/ui/pages/pages.dart';

class StreamLoginPresenter implements LoginPresenter {
  final Validation validation;

  StreamLoginPresenter({@required this.validation});
  @override
  // TODO: implement emailErrorStream
  Stream<String> get emailErrorStream => throw UnimplementedError();

  @override
  // TODO: implement isFormValidStream
  Stream<bool> get isFormValidStream => throw UnimplementedError();

  @override
  // TODO: implement isLoadingStream
  Stream<bool> get isLoadingStream => throw UnimplementedError();

  @override
  // TODO: implement mainErrorStream
  Stream<String> get mainErrorStream => throw UnimplementedError();

  @override
  // TODO: implement passwordErrorStream
  Stream<String> get passwordErrorStream => throw UnimplementedError();

  @override
  void validateEmail(String email) {
    validation.validate(field: 'email', value: email);
  }

  @override
  void validatePassword(String password) {
    // TODO: implement validatePassword
  }

  @override
  Future<void> auth() {
    // TODO: implement auth
    throw UnimplementedError();
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
}

abstract class Validation {
  String validate({@required String field, @required String value});
}

class ValidationSpy extends Mock implements Validation {}

void main() {
  test('Should call validation with correct email', () {
    final validation = ValidationSpy();
    final sut = StreamLoginPresenter(validation: validation);
    final email = faker.internet.email();

    sut.validateEmail(email);

    verify(validation.validate(field: 'email', value: email)).called(1);
  });
}
