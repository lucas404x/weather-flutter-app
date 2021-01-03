import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'user.dart';

class FirebaseUserModel extends UserModel {
  final dynamic uid;
  final String name;
  final String email;

  FirebaseUserModel(
      {@required this.uid, @required this.email, @required this.name})
      : super(uid, email, name);

  factory FirebaseUserModel.fromFirebaseUser(User user) =>
      FirebaseUserModel(uid: user.uid, email: user.email, name: user.displayName);
}
