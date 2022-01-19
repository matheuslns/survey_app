import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_app/data/cache/save_secure_cache_storage.dart';
import 'package:survey_app/domain/helpers/helpers.dart';
import 'package:test/test.dart';
import 'package:meta/meta.dart';

class LocalStorageAdapter implements SaveSecureCacheStorage {
  final FlutterSecureStorage secureStorage;

  LocalStorageAdapter({@required this.secureStorage});

  @override
  Future<void> saveSecure(
      {@required String key, @required String value}) async {
    await secureStorage.write(key: 'any_key', value: 'any_value');
  }
}

class FlutterSecureStorageSpy extends Mock implements FlutterSecureStorage {}

void main() {
  LocalStorageAdapter sut;
  FlutterSecureStorageSpy secureStorage;

  setUp(() {
    secureStorage = FlutterSecureStorageSpy();
    sut = LocalStorageAdapter(secureStorage: secureStorage);
  });

  test('Should call save secure with correct values', () async {
    await sut.saveSecure(key: 'any_key', value: 'any_value');

    verify(secureStorage.write(key: 'any_key', value: 'any_value'));
  });

  test('Should throw UnexpactedError if  save secure throws', () async {
    when(secureStorage.write(
      key: anyNamed('key'),
      value: anyNamed('value'),
    )).thenThrow(Exception());

    final future = sut.saveSecure(key: 'any_key', value: 'any_value');

    expect(future, throwsA(TypeMatcher<Exception>()));
  });
}
