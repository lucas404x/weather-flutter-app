import 'package:flutter/material.dart';

import 'app/login/login_page.dart';

void main() {
  runApp(MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Colors.transparent),
      debugShowCheckedModeBanner: false,
      home: LoginPage()));
}
