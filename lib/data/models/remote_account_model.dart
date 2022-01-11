import '../../domain/entities/account_entity.dart';

class RemoteAccountModel {
  final String accessToken;
  final String name;

  RemoteAccountModel(this.accessToken, this.name);

  factory RemoteAccountModel.fromJson(Map json) =>
      RemoteAccountModel(json['accessToken'], json['name']);

  AccountEntity toEntity() => AccountEntity(accessToken);
}
