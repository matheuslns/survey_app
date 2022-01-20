import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_app/domain/entities/entities.dart';
import 'package:survey_app/domain/helpers/helpers.dart';

import 'package:survey_app/domain/usecases/usecases.dart';
import 'package:survey_app/presentation/presenters/presenters.dart';
import 'package:survey_app/presentation/protocols/protocols.dart';
import 'package:survey_app/ui/pages/pages.dart';

class GetxSplashPresenter implements SplashPresenter {
  final LoadCurrentAccount loadCurrentAccount;

  var _navigateTo = RxString();

  GetxSplashPresenter(this.loadCurrentAccount);

  @override
  Future<void> checkAccount() async {
    await loadCurrentAccount.load();
  }

  @override
  Stream<String> get navigateToStream => _navigateTo.stream;
}

class LoadCurrentAccountSpy extends Mock implements LoadCurrentAccount {}

void main() {
  GetxSplashPresenter sut;
  LoadCurrentAccount loadCurrentAccount;

  setUp(() {
    loadCurrentAccount = LoadCurrentAccountSpy();
    sut = GetxSplashPresenter(loadCurrentAccount);
  });

  test('Should call loadCurrentAccount', () {
    sut.checkAccount();

    verify(loadCurrentAccount.load()).called(1);
  });
}
