import '../../shared/models/user.dart';

abstract class IAuth {
  Future<UserModel> signIn(Map<String, dynamic> credentials);
}