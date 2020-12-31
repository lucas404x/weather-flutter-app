import 'dart:async';

import 'package:flutter/material.dart';
import 'package:weather_app/app/home/home_page.dart';

import '../shared/enums/sign_enum.dart';
import '../shared/errors/auth_exception.dart';
import '../shared/models/user.dart';
import 'repositories/auth_interface.dart';

class LoginController {
  IAuth _auth;
  GlobalKey<FormState> _formKey;

  TextEditingController _emailController;
  TextEditingController _passwordController;

  final _stateButtonController = StreamController<Sign>();
  Stream<Sign> get isSigningIn => _stateButtonController.stream;

  LoginController(this._auth, this._formKey, this._emailController,
      this._passwordController);

  Future<void> doAuth(ScaffoldState scaffoldState) async {
    if (!_formKey.currentState.validate()) return;
    // changing button to circular progress
    _stateButtonController.add(Sign.IS_SIGNING);

    Map<String, dynamic> credentials = {
      'email': _emailController.text,
      'password': _passwordController.text
    };

    UserModel userModel;

    try {
      userModel = await _auth.signIn(credentials);
    } on AuthException catch (e) {
      if (e.runtimeType == WrongCredentialsException) {
        _stateButtonController.add(Sign.IS_NOT_SIGNING);
        var snackbar = SnackBar(content: Text(e.description));
        scaffoldState.showSnackBar(snackbar);

        return;
      }

      try {
        userModel = await _auth.signUp(credentials);
      } on PasswordIsTooWeak catch (e) {
        _stateButtonController.add(Sign.IS_NOT_SIGNING);
        var snackbar = SnackBar(content: Text(e.description));
        scaffoldState.showSnackBar(snackbar);

        return;
      }
    }

    _stateButtonController.add(Sign.IS_NOT_SIGNING);

    // sending userModel to HomePage
    Navigator.of(scaffoldState.context).push(MaterialPageRoute(
        builder: (_) => HomePage(
              userModel: userModel,
            )));
  }

  String validateEmail(String email) {
    var emailValidator = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

    if (emailValidator.hasMatch(email)) return null;
    return "Invalid email";
  }

  String validatePassword(String password) =>
      password.isNotEmpty ? null : "Invalid password";

  void dispose() {
    _stateButtonController.close();
  }
}
