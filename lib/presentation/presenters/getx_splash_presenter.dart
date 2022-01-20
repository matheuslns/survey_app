import 'package:get/get.dart';

import '../../domain/usecases/usecases.dart';
import '../../ui/pages/pages.dart';

class GetxSplashPresenter implements SplashPresenter {
  final LoadCurrentAccount loadCurrentAccount;

  var _navigateTo = RxString();

  GetxSplashPresenter({this.loadCurrentAccount});

  @override
  Future<void> checkAccount() async {
    try {
      final account = await loadCurrentAccount.load();
      _navigateTo.value = account.isNull ? '/login' : '/surveys';
    } catch (error) {
      _navigateTo.value = '/login';
    }
  }

  @override
  Stream<String> get navigateToStream => _navigateTo.stream;
}
