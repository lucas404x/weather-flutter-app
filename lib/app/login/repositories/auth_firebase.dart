import 'package:firebase_auth/firebase_auth.dart';
import '../../shared/errors/auth_exception.dart';

import '../../shared/models/firebase_user_model.dart';
import '../../shared/models/user.dart';
import 'auth_interface.dart';

class AuthFirebase implements IAuth {
  FirebaseAuth _firebaseAuth;

  AuthFirebase(this._firebaseAuth);

  @override
  Future<UserModel> signIn(Map<String, dynamic> credentials) async {
    UserCredential userCredential;

    try {
      userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: credentials["email"], password: credentials["password"]);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
        case 'user-disable':
          throw UserNotFoundException(e.code, e.message);
        case 'invalid-email':
        case 'wrong-password':
          throw WrongCredentialsException(e.code, e.message);
      }
    }

    return FirebaseUserModel.fromFirebaseUser(userCredential.user);
  }

  @override
  Future<UserModel> signUp(Map<String, dynamic> credentials) async {
    UserCredential userCredential;

    try {
      userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: credentials["email"], password: credentials["password"]);
    } on FirebaseAuthException catch (e) {
      throw PasswordIsTooWeak(e.code,
          "We tried to create your account but the password is too weak.");
    }

    return FirebaseUserModel.fromFirebaseUser(userCredential.user);
  }
}
