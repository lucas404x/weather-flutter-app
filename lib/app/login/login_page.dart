import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../shared/enums/sign_enum.dart';
import 'login_controller.dart';
import 'repositories/auth_firebase.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> _formKey;
  LoginController _loginController;

  TextEditingController _emailController;
  TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    _formKey = GlobalKey<FormState>();
    _loginController = LoginController(AuthFirebase(FirebaseAuth.instance),
        _formKey, _emailController, _passwordController);
  }

  @override
  void dispose() {
    _loginController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        padding: const EdgeInsets.all(18),
        width: _size.width,
        height: _size.height,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          const SizedBox(
            height: 50,
          ),
          FlutterLogo(
            size: 80,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "I have no idea about a nice name yet =(",
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(color: Colors.white, fontSize: 24),
          ),
          SizedBox(
            height: 40,
          ),
          Expanded(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _emailController,
                    validator: _loginController.validateEmail,
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: Colors.white,
                    style: GoogleFonts.openSans(color: Colors.white),
                    decoration: InputDecoration(
                        hintStyle: GoogleFonts.montserrat(color: Colors.white),
                        focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        hintText: 'Email'),
                  ),
                  const SizedBox(height: 18),
                  TextFormField(
                    controller: _passwordController,
                    validator: _loginController.validatePassword,
                    keyboardType: TextInputType.visiblePassword,
                    cursorColor: Colors.white,
                    style: GoogleFonts.openSans(color: Colors.white),
                    decoration: InputDecoration(
                        hintStyle: GoogleFonts.montserrat(color: Colors.white),
                        focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        hintText: 'Password'),
                  ),
                  const SizedBox(height: 40),
                  Container(
                    width: _size.width,
                    child: StreamBuilder<Sign>(
                      stream: _loginController.isSigningIn,
                      initialData: Sign.IS_NOT_SIGNING,
                      builder: (context, snapshot) => OutlineButton(
                        borderSide: BorderSide(color: Colors.purple),
                        highlightedBorderColor: Colors.white,
                        splashColor: Colors.white.withOpacity(.1),
                        onPressed: snapshot.data == Sign.IS_NOT_SIGNING
                            ? () =>
                                _loginController.doAuth(Scaffold.of(context))
                            : null,
                        child: snapshot.data == Sign.IS_NOT_SIGNING
                            ? Text(
                                'Sign in',
                                style:
                                    GoogleFonts.openSans(color: Colors.white),
                              )
                            : Center(
                                child: CircularProgressIndicator(),
                              ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ]),
      ),
    ));
  }
}
