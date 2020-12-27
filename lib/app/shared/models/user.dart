import 'package:flutter/foundation.dart';

class UserModel {
  final String uuid;
  final String email;
  final String password;

  UserModel(
      {@required this.uuid, @required this.email, @required this.password});

  factory UserModel.fromMap(Map<String, dynamic> data) => UserModel(
      uuid: data["uuid"], email: data["email"], password: data["password"]);

  Map<String, dynamic> toMap() =>
      {'uuid': uuid, 'email': email, 'password': password};
}
