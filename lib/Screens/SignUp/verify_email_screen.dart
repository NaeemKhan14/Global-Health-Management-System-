import 'package:flutter/material.dart';
import 'package:ghms/Backend/Authentication/authentication_service.dart';
import 'package:ghms/Backend/Authentication/authentication_wrapper.dart';
import 'package:ghms/Screens/ForgotPassword/components/background.dart';
import 'package:ghms/Screens/WelcomeScreen/components/rounded_button.dart';
import 'package:ghms/Screens/WelcomeScreen/welcome_screen.dart';
import 'package:ghms/constants.dart';
import 'package:provider/provider.dart';

class VerifyEmailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                "A verification e-mail has been sent to provided address.\nPlease verify your email address to gain access to the application."
                    "\nIf you have verified your email address, then click on refresh button."),
            RoundedButton(
              text: "Refresh",
              color: kPrimaryColor,
              press: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return AuthenticationWrapper();
                }));
              },
            ),
            RoundedButton(
              text: "Sign out",
              color: kPrimaryColor,
              press: () {
                context.read<AuthenticationService>().signOut();
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return WelcomeScreen();
                }));
              },
            ),
          ],
        ),
      ),
    );
  }
}
