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
    final account = await loadCurrentAccount.load();
    _navigateTo.value = account.isNull ? '/login' : '/surveys';
  }

  @override
  Stream<String> get navigateToStream => _navigateTo.stream;
}

class LoadCurrentAccountSpy extends Mock implements LoadCurrentAccount {}

void main() {
  GetxSplashPresenter sut;
  LoadCurrentAccount loadCurrentAccount;
  String token;

  mockLoadCurrentAccount({AccountEntity account}) {
    when(loadCurrentAccount.load()).thenAnswer((_) async => account);
  }

  setUp(() {
    token = faker.guid.guid();
    loadCurrentAccount = LoadCurrentAccountSpy();
    sut = GetxSplashPresenter(loadCurrentAccount);
    mockLoadCurrentAccount(account: AccountEntity(token));
  });

  test('Should call loadCurrentAccount', () async {
    await sut.checkAccount();

    verify(loadCurrentAccount.load()).called(1);
  });

  test('Should go to surveys page on success', () async {
    sut.navigateToStream
        .listen(expectAsync1((page) => expect(page, '/surveys')));

    await sut.checkAccount();
  });

  test('Should go to login page on null result', () async {
    mockLoadCurrentAccount(account: null);

    sut.navigateToStream.listen(expectAsync1((page) => expect(page, '/login')));

    await sut.checkAccount();
  });
}
