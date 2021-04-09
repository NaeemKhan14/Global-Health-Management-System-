import 'package:flutter/material.dart';
import 'package:ghms/Backend/Authentication/authentication_service.dart';
import 'package:ghms/Screens/WelcomeScreen/welcome_screen.dart';
import 'package:provider/provider.dart';

class HomePageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        child: Text("Signout"),
        onPressed: () {
          context.read<AuthenticationService>().signOut();
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return WelcomeScreen();
          }));
          },
      ),
      color: Colors.white,
    );
  }
}
