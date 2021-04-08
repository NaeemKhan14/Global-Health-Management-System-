import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ghms/Screens/ForgotPassword/forgot_password.dart';
import 'background.dart';
import 'extra_login_actions.dart';
import 'rounded_input_field.dart';
import 'rounded_password_field.dart';
import 'package:ghms/Screens/SignUp/signup_screen.dart';
import 'package:ghms/Screens/WelcomeScreen/components/rounded_button.dart';
import 'package:ghms/constants.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
            RoundedInputField(
              hintText: "Username",
              icon: Icons.person,
            ),
            RoundedPasswordField(
              hintText: "Password",
            ),
            RoundedButton(
              text: "Login",
              press: () {},
              color: kPrimaryColor,
            ),
            ExtraLoginActions(
              hintText: "Forgot your password? ",
              btnText: "Click here to reset.",
              onPress: () {Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ForgotPasswordScreen();
              }));},
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
