import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ghms/Backend/Authentication/authentication_service.dart';
import 'package:ghms/Screens/Login/components/TextFieldContainer.dart';
import 'package:ghms/Screens/WelcomeScreen/components/rounded_button.dart';
import 'package:ghms/Screens/WelcomeScreen/welcome_screen.dart';
import 'package:ghms/constants.dart';
import 'background.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailFieldController = TextEditingController();
  String errorMsg = '';
  bool errorVisibility = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
                text: "Reset Password",
                color: kPrimaryColor,
                press: () async {
                  setState(() {
                    errorVisibility = false;
                  });
                  if (_formKey.currentState.validate()) {
                    String forgotPass = await context
                        .read<AuthenticationService>()
                        .forgotPassword(
                          email: emailFieldController.text,
                        );
                    setState(() {
                      errorVisibility = true;
                      errorMsg = forgotPass;
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
