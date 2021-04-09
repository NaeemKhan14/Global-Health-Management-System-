import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ghms/Screens/Login/components/rounded_input_field.dart';
import 'package:ghms/Screens/Login/components/rounded_password_field.dart';
import 'background.dart';
import 'package:ghms/Screens/WelcomeScreen/components/rounded_button.dart';
import 'package:ghms/constants.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passController = TextEditingController();
    final TextEditingController confirmPassController = TextEditingController();

    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Sign Up",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SvgPicture.asset(
              "assets/icons/signup.svg",
              height: size.width * 0.35,
            ),
            RoundedInputField(
              controller: emailController,
              hintText: "E-mail",
              icon: Icons.person,
            ),
            RoundedPasswordField(
              controller: passController,
              hintText: "Password",

            ),
            RoundedPasswordField(
              controller: confirmPassController,
              hintText: "Confirm password",
            ),
            RoundedButton(
              text: "Sign Up",
              press: () {},
              color: kPrimaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
