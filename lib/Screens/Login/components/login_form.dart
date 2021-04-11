import 'package:flutter/material.dart';
import 'package:ghms/Backend/Authentication/authentication_wrapper.dart';
import 'package:ghms/Screens/WelcomeScreen/components/rounded_button.dart';
import 'TextFieldContainer.dart';
import 'package:ghms/constants.dart';
import 'package:provider/provider.dart';
import 'package:ghms/Backend/Authentication/authentication_service.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailFieldController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  String errorMsg = '';
  bool errorVisibility = false;
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Visibility(
              visible: errorVisibility,
              child: Text(
                errorMsg,
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
            TextFieldContainer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty) return 'E-mail field is required.';
                      return null;
                    },
                    controller: emailFieldController,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.email,
                        color: kPrimaryColor,
                      ),
                      hintText: "E-Mail address",
                    ),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty) return 'Password field is required.';
                      return null;
                    },
                    obscureText: !_passwordVisible,
                    controller: passController,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.lock,
                        color: kPrimaryColor,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible ? Icons.visibility_off : Icons.visibility,
                          color: kPrimaryColor,
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                      hintText: "Password",
                      border: InputBorder.none,
                    ),
                  ),
                ],
              ),
            ),
            RoundedButton(
              text: "Login",
              color: kPrimaryColor,
              press: () async {
                // Remove any error msgs from Firebase.
                setState(() {
                  errorVisibility = false;
                });
                String login;
                // If form is valid.
                if (_formKey.currentState.validate() &&
                    (emailFieldController.text != null &&
                        passController.text != null)) {
                  // Try and login and get the output from Authentication class.
                  login = await context.read<AuthenticationService>().signIn(
                        email: emailFieldController.text,
                        pass: passController.text,
                      );
                  if (login.contains("Signed in")) {
                    // Redirect to homepage.
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return AuthenticationWrapper();
                    }));
                  } else {
                    // If there are any errors from Firebase, we will show it using
                    // this in the main page.
                    setState(() {
                      errorVisibility = true;
                      errorMsg = login;
                    });
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
