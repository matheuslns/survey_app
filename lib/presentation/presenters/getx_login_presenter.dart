import 'package:meta/meta.dart';
import 'package:get/get.dart';

import '../protocols/protocols.dart';
import '../../domain/helpers/helpers.dart';
import '../../domain/usecases/usecases.dart';
import '../../ui/pages/pages.dart';

class GetxLoginPresenter extends GetxController implements LoginPresenter {
  final Validation validation;
  final Authentication authentication;
  final SaveCurrentAccount saveCurrentAccount;

  String _email;
  String _password;
  var _emailError = RxString();
  var _passwordError = RxString();
  var _mainError = RxString();
  var _navigateTo = RxString();
  var _isFormValid = false.obs;
  var _isLoading = false.obs;

  GetxLoginPresenter({
    @required this.validation,
    @required this.authentication,
    @required this.saveCurrentAccount,
  });

  @override
  Stream<String> get emailErrorStream => _emailError.stream;

  @override
  Stream<String> get mainErrorStream => _mainError.stream;

  @override
  Stream<String> get passwordErrorStream => _passwordError.stream;

  @override
  Stream<String> get navigateToStream => _navigateTo.stream;

  @override
  Stream<bool> get isFormValidStream => _isFormValid.stream;

  @override
  Stream<bool> get isLoadingStream => _isLoading.stream;

  @override
  void validateEmail(String email) {
    _email = email;
    _emailError.value = validation.validate(field: 'email', value: email);
    _validateForm();
  }

  @override
  void validatePassword(String password) {
    _password = password;
    _passwordError.value =
        validation.validate(field: 'password', value: password);
    _validateForm();
  }

  @override
  Future<void> auth() async {
    try {
      _isLoading.value = true;

      final account = await authentication.auth(AuthenticationParams(
        email: _email,
        secret: _password,
      ));
      await saveCurrentAccount.save(account);
      _navigateTo.value = '/surveys';
    } on DomainError catch (error) {
      _mainError.value = error.description;
      _isLoading.value = false;
    }
  }

  @override
  void dispose() {}

  void _validateForm() {
    _isFormValid.value = _emailError.value == null &&
        _passwordError.value == null &&
        _email != null &&
        _password != null;
  }
}
