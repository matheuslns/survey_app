import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:survey_app/data/cache/cache.dart';
import 'package:survey_app/data/usecases/usecases.dart';
import 'package:survey_app/domain/entities/account_entity.dart';
import 'package:survey_app/domain/helpers/helpers.dart';

class FetchSecureCacheStorageSpy extends Mock
    implements FetchSecureCacheStorage {}

void main() {
  LocalLoadCurrentAccount sut;
  FetchSecureCacheStorage fetchSecureCacheStorage;
  String token;

  setUp(() {
    fetchSecureCacheStorage = FetchSecureCacheStorageSpy();
    sut = LocalLoadCurrentAccount(
      fetchSecureCacheStorage: fetchSecureCacheStorage,
    );

    token = faker.guid.guid();
  });

  test('Should call FetchSecureCacheStorage with correct value', () async {
    await sut.load();

    verify(fetchSecureCacheStorage.fetchSecure('token'));
  });

  test('Should return an AccountEntity', () async {
    when(fetchSecureCacheStorage.fetchSecure(any))
        .thenAnswer((realInvocation) async => token);

    final account = await sut.load();

    expect(account, AccountEntity(token));
  });

  test('Should throw UnexpectedError if fetchSecureCacheStorage throws',
      () async {
    when(fetchSecureCacheStorage.fetchSecure(any)).thenThrow(Exception());

    final future = sut.load();

    expect(future, throwsA(DomainError.unexpected));
  });
}
