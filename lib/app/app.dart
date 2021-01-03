import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'home/home_page.dart';
import 'login/login_page.dart';
import 'shared/models/firebase_user_model.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(
                theme: ThemeData(scaffoldBackgroundColor: Colors.transparent),
                debugShowCheckedModeBanner: false,
                home: FirebaseAuth.instance.currentUser == null
                    ? LoginPage()
                    : HomePage(
                        userModel: FirebaseUserModel.fromFirebaseUser(
                            FirebaseAuth.instance.currentUser)));
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
        future: Firebase.initializeApp());
  }
}
