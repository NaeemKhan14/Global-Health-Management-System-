import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ghms/Screens/Login/components/TextFieldContainer.dart';
import 'package:ghms/Screens/Login/components/rounded_input_field.dart';
import 'package:ghms/Screens/WelcomeScreen/components/rounded_button.dart';
import 'package:ghms/constants.dart';
import 'background.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final _formKey = GlobalKey<FormState>();
    final TextEditingController emailFieldController = TextEditingController();

    return Background(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
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
              TextFieldContainer(
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) return 'E-mail field is required.';
                    return null;
                  },
                  controller: emailFieldController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    icon: Icon(
                      Icons.email,
                      color: kPrimaryColor,
                    ),
                    hintText: "E-Mail address",
                  ),
                ),
              ),
              RoundedButton(
                text: "Login",
                color: kPrimaryColor,
                press: () {
                  if (_formKey.currentState.validate()) {}
                  }
                ,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
