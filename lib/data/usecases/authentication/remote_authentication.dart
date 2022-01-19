import 'package:meta/meta.dart';

import '../../models/models.dart';
import '../../../domain/entities/entities.dart';
import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/usecases.dart';
import '../../http/http.dart';

class RemoteAuthentication implements Authentication {
  final HttpClient httpClient;
  final String url;

  RemoteAuthentication({@required this.httpClient, @required this.url});

  Future<AccountEntity> auth(AuthenticationParams params) async {
    try {
      final response = await httpClient.request(
        url: url,
        method: 'post',
        body: RemoteAuthenticationParams.fromDomain(params).toJson(),
      );

      return RemoteAccountModel.fromJson(response).toEntity();
    } on HttpError catch (error) {
      switch (error) {
        case HttpError.unauthorized:
          throw DomainError.invalidCredentials;
          break;
        default:
          throw DomainError.unexpected;
      }
    }
  }
}

class RemoteAuthenticationParams {
  final String email;
  final String password;

  RemoteAuthenticationParams({
    @required this.email,
    @required this.password,
  });

  factory RemoteAuthenticationParams.fromDomain(AuthenticationParams entity) =>
      RemoteAuthenticationParams(
        email: entity.email,
        password: entity.secret,
      );

  Map toJson() => {'email': email, 'password': password};
}
