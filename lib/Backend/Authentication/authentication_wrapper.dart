import 'package:flutter/material.dart';
import 'package:ghms/Screens/SignUp/verify_email_screen.dart';
import 'package:ghms/Screens/WelcomeScreen/welcome_screen.dart';
import 'package:provider/provider.dart';
import 'package:ghms/Screens/HomePage/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    // Show welcome screen if user is not logged in.
    if(firebaseUser != null)
    {
      if(!firebaseUser.emailVerified)
      {
        return VerifyEmailScreen();
      } else {
        return HomePageScreen();
      }

    }
    // Take to homepage if user is logged in.
    return WelcomeScreen();
  }
}
