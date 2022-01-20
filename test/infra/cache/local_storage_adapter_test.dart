import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:survey_app/infra/cache/cache.dart';

class FlutterSecureStorageSpy extends Mock implements FlutterSecureStorage {}

void main() {
  LocalStorageAdapter sut;
  FlutterSecureStorageSpy secureStorage;

  setUp(() {
    secureStorage = FlutterSecureStorageSpy();
    sut = LocalStorageAdapter(secureStorage: secureStorage);
  });

  group('Save secure', () {
    test('Should call save secure with correct values', () async {
      await sut.saveSecure(key: 'any_key', value: 'any_value');

      verify(secureStorage.write(key: 'any_key', value: 'any_value'));
    });

    test('Should throw if  save secure throws', () async {
      when(secureStorage.write(
        key: anyNamed('key'),
        value: anyNamed('value'),
      )).thenThrow(Exception());

      final future = sut.saveSecure(key: 'any_key', value: 'any_value');

      expect(future, throwsA(TypeMatcher<Exception>()));
    });
  });

  group('Fetch secure', () {
    test('Should call fetch secure with correct value', () async {
      await sut.fetchSecure('any_key');

      verify(secureStorage.read(key: 'any_key'));
    });

    test('Should fetch secure return correct value', () async {
      when(secureStorage.read(
        key: anyNamed('key'),
      )).thenAnswer((_) async => 'any_value');

      final value = await sut.fetchSecure('any_key');

      expect(value, 'any_value');
    });

    test('Should throw if fetch secure throws', () async {
      when(secureStorage.read(
        key: anyNamed('key'),
      )).thenThrow(Exception());

      final future = sut.fetchSecure('any_key');

      expect(future, throwsA(TypeMatcher<Exception>()));
    });
  });
}
