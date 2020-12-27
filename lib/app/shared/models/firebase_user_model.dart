import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'user.dart';

class FirebaseUserModel extends UserModel {
  final String uid;
  final String email;

  FirebaseUserModel({@required this.uid, @required this.email});

  factory FirebaseUserModel.fromFirebaseUser(User user) =>
      FirebaseUserModel(uid: user.uid, email: user.email);
}
