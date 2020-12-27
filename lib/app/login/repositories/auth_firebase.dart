import 'package:firebase_auth/firebase_auth.dart';

import '../../shared/models/user.dart';
import 'auth_interface.dart';

class AuthFirebase implements IAuth {
  FirebaseAuth _firebaseAuth;

  AuthFirebase(this._firebaseAuth);

  @override
  Future<UserModel> signIn(Map<String, dynamic> credentials) {
    // TODO: implement signIn
    throw UnimplementedError();
  }
}
