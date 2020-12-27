import 'dart:async';

import 'package:flutter/material.dart';

class LoginController {
  GlobalKey<FormState> _formKey;
  GlobalKey<FormState> get formKey => _formKey;

  final _stateButtonController = StreamController<bool>();
  Stream<bool> get isSigningIn => _stateButtonController.stream;

  LoginController(this._formKey);

  Future<void> doAuth() async {
    if (!_formKey.currentState.validate()) return;

    _stateButtonController.add(true);
    // simulating an authentication
    await Future.delayed(Duration(seconds: 3));
    _stateButtonController.add(false);
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
