import 'package:flutter/material.dart';

import 'app/home/home_page.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      scaffoldBackgroundColor: Colors.transparent
    ),
    debugShowCheckedModeBanner: false,
    home: HomePage()));
}
