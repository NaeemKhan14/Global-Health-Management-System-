import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ghms/Screens/Login/components/rounded_input_field.dart';
import 'package:ghms/Screens/WelcomeScreen/components/rounded_button.dart';
import 'package:ghms/constants.dart';
import 'background.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Forgot Password",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            RoundedInputField(
              hintText: "E-Mail Address",
              icon: Icons.email,
            ),
            RoundedButton(
              text: "Reset Password",
              press: () {},
              color: kPrimaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
