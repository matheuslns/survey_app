import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../infra/cache/cache.dart';

LocalStorageAdapter makeLocalStorageAdapter() {
  return LocalStorageAdapter(secureStorage: FlutterSecureStorage());
}
