import 'package:meta/meta.dart';

import '../../models/models.dart';
import '../../../domain/entities/entities.dart';
import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/usecases.dart';
import '../../http/http.dart';

class RemoteAddAccount implements AddAccount {
  final HttpClient httpClient;
  final String url;

  RemoteAddAccount({@required this.httpClient, @required this.url});

  Future<AccountEntity> add(AddAccountParams params) async {
    try {
      final response = await httpClient.request(
        url: url,
        method: 'post',
        body: RemoteAddAccountParams.fromDomain(params).toJson(),
      );

      return RemoteAccountModel.fromJson(response).toEntity();
    } on HttpError catch (error) {
      switch (error) {
        case HttpError.forbidden:
          throw DomainError.emailInUse;
          break;
        default:
          throw DomainError.unexpected;
      }
    }
  }
}

class RemoteAddAccountParams {
  final String email;
  final String name;
  final String password;
  final String passwordConfirmation;

  RemoteAddAccountParams({
    @required this.email,
    @required this.name,
    @required this.password,
    @required this.passwordConfirmation,
  });

  factory RemoteAddAccountParams.fromDomain(AddAccountParams entity) =>
      RemoteAddAccountParams(
        email: entity.email,
        name: entity.name,
        password: entity.password,
        passwordConfirmation: entity.passwordConfirmation,
      );

  Map toJson() => {
        'email': email,
        'name': name,
        'password': password,
        'passwordConfirmation': passwordConfirmation,
      };
}
