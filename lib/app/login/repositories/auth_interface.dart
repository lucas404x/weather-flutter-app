import '../../shared/models/user.dart';

abstract class IAuth {
  Future<void> signUp(Map<String, dynamic> credentials);
  Future<UserModel> signIn(Map<String, dynamic> credentials);
}