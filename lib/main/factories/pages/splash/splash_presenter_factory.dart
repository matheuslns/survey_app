import '../../usecases/usecases.dart';
import '../../../../presentation/presenters/presenters.dart';
import '../../../../ui/pages/pages.dart';

SplashPresenter makeGetxSplashPresenter() =>
    GetxSplashPresenter(loadCurrentAccount: makeLocalLoadCurrentAccount());
