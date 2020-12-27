import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'login/login_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(
                theme: ThemeData(scaffoldBackgroundColor: Colors.transparent),
                debugShowCheckedModeBanner: false,
                home: LoginPage());
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
        future: Firebase.initializeApp());
  }
}
