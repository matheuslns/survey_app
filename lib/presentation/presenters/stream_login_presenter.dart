import 'dart:async';

import 'package:meta/meta.dart';

import '../protocols/protocols.dart';
import '../../ui/pages/pages.dart';

class LoginState {
  bool get isFormValid => false;
  bool isLoading;
  String emailError;
  String mainError;
  String passwordError;
}

class StreamLoginPresenter implements LoginPresenter {
  final Validation validation;
  final _controller = StreamController<LoginState>.broadcast();
  var _state = LoginState();

  StreamLoginPresenter({@required this.validation});

  @override
  Stream<String> get emailErrorStream =>
      _controller.stream.map((state) => state.emailError).distinct();

  @override
  Stream<bool> get isFormValidStream =>
      _controller.stream.map((state) => state.isFormValid).distinct();

  @override
  Stream<bool> get isLoadingStream =>
      _controller.stream.map((state) => state.isLoading).distinct();

  @override
  Stream<String> get mainErrorStream =>
      _controller.stream.map((state) => state.mainError).distinct();

  @override
  Stream<String> get passwordErrorStream =>
      _controller.stream.map((state) => state.passwordError).distinct();

  @override
  void validateEmail(String email) {
    _state.emailError = validation.validate(field: 'email', value: email);
    _update();
  }

  @override
  void validatePassword(String password) {
    _state.passwordError =
        validation.validate(field: 'password', value: password);
    _update();
  }

  void _update() => _controller.add(_state);

  @override
  Future<void> auth() {
    // TODO: implement auth
    throw UnimplementedError();
  }

  @override
  void dispose() {
    _controller.close();
  }
}
