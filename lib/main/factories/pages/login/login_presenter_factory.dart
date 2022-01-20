import '../../factories.dart';
import '../../../../presentation/presenters/presenters.dart';
import '../../../../ui/pages/pages.dart';

LoginPresenter makeStreamLoginPresenter() => StreamLoginPresenter(
      validation: makeLoginValidation(),
      authentication: makeRemoteAuthentication(),
    );

LoginPresenter makeGetxLoginPresenter() => GetxLoginPresenter(
      validation: makeLoginValidation(),
      authentication: makeRemoteAuthentication(),
      saveCurrentAccount: makeLocalSaveCurrentAccount(),
    );
