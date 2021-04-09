import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ghms/Backend/Authentication/authentication_service.dart';
import 'package:ghms/Screens/ForgotPassword/forgot_password.dart';
import 'package:ghms/Screens/HomePage/homepage.dart';
import 'package:ghms/Screens/Login/components/login_form.dart';
import 'background.dart';
import 'extra_login_actions.dart';
import 'rounded_input_field.dart';
import 'rounded_password_field.dart';
import 'package:ghms/Screens/SignUp/signup_screen.dart';
import 'package:ghms/Screens/WelcomeScreen/components/rounded_button.dart';
import 'package:ghms/constants.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final TextEditingController unameController = TextEditingController();
    final TextEditingController passController = TextEditingController();

    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Login",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.015),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.015),
            LoginForm(),
            ExtraLoginActions(
              hintText: "Forgot your password? ",
              btnText: "Click here to reset.",
              onPress: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ForgotPasswordScreen();
                }));
              },
            ),
            SizedBox(height: size.height * 0.01),
            ExtraLoginActions(
              hintText: "Don't have an account? ",
              btnText: "Click here to sign up!",
              onPress: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SignUpScreen();
                }));
              },
            ),
          ],
        ),
      ),
    );
  }
}
