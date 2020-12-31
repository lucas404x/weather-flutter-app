import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'user.dart';

class FirebaseUserModel extends UserModel {
  final dynamic uid;
  final String email;

  FirebaseUserModel({@required this.uid, @required this.email})
      : super(uid, email);

  factory FirebaseUserModel.fromFirebaseUser(User user) =>
      FirebaseUserModel(uid: user.uid, email: user.email);
}
