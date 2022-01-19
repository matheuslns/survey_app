import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:survey_app/data/cache/cache.dart';
import 'package:survey_app/data/usecases/usecases.dart';
import 'package:survey_app/domain/entities/entities.dart';
import 'package:survey_app/domain/helpers/helpers.dart';
import 'package:survey_app/domain/usecases/usecases.dart';

class SaveSecureCacheStorageSpy extends Mock implements SaveSecureCacheStorage {
}

void main() {
  SaveCurrentAccount sut;
  AccountEntity account;
  SaveSecureCacheStorage saveSecureCacheStorage;

  setUp(() {
    saveSecureCacheStorage = SaveSecureCacheStorageSpy();
    sut =
        LocalSaveCurrentAccount(saveSecureCacheStorage: saveSecureCacheStorage);
    account = AccountEntity(faker.guid.guid());
  });

  test('Should call saveSecureCacheStorage with correct values', () async {
    await sut.save(account);

    verify(
        saveSecureCacheStorage.saveSecure(key: 'token', value: account.token));
  });

  test(
      'Should LocalSaveCurrentAccount throws UnexpectedError if saveSecureCacheStorage throws',
      () async {
    when(saveSecureCacheStorage.saveSecure(
      key: anyNamed('key'),
      value: anyNamed('value'),
    )).thenThrow(Exception());

    final future = sut.save(account);

    expect(future, throwsA(DomainError.unexpected));
  });
}
