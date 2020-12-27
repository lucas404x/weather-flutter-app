import '../../shared/models/user.dart';

abstract class IAuth {
  Future<UserModel> signUp(Map<String, dynamic> credentials);
  Future<UserModel> signIn(Map<String, dynamic> credentials);
}