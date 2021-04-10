import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ghms/Screens/HomePage/homepage.dart';
import 'package:ghms/Screens/Login/components/TextFieldContainer.dart';
import 'background.dart';
import 'package:ghms/Screens/WelcomeScreen/components/rounded_button.dart';
import 'package:ghms/constants.dart';
import 'package:provider/provider.dart';
import 'package:ghms/Backend/Authentication/authentication_service.dart';

class Body extends StatefulWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailFieldController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();
  final TextEditingController phoneNumController = TextEditingController();
  final TextEditingController personalIDController = TextEditingController();
  String errorMsg = '';
  bool errorVisibility = false;
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
              child: Form(
                key: _formKey,
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
                      ),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty)
                          return 'Confirm password field is required.';
                        return null;
                      },
                      obscureText: !_confirmPasswordVisible,
                      controller: confirmPassController,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.lock,
                          color: kPrimaryColor,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _confirmPasswordVisible ? Icons.visibility_off : Icons.visibility,
                            color: kPrimaryColor,
                          ),
                          onPressed: () {
                            setState(() {
                              _confirmPasswordVisible = !_confirmPasswordVisible;
                            });
                          },
                        ),
                        hintText: "Confirm password",
                      ),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty)
                          return 'Phone number field is required.';
                        return null;
                      },
                      controller: phoneNumController,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.phone,
                          color: kPrimaryColor,
                        ),
                        hintText: "Phone Number",
                      ),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty)
                          return 'Personal ID field is required.';
                        return null;
                      },
                      controller: personalIDController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(
                          Icons.perm_identity,
                          color: kPrimaryColor,
                        ),
                        hintText: "Personal ID number",
                      ),
                    ),
                  ],
                ),
              ),
            ),
            RoundedButton(
              text: "Sign Up",
              color: kPrimaryColor,
              press: () async {
                // Remove any error msgs from Firebase.
                setState(() {
                  errorVisibility = false;
                });
                if (_formKey.currentState.validate() &&
                    (emailFieldController.text != null &&
                        passController.text != null)) {
                  // Check if both password fields match.
                  if (passController.text == confirmPassController.text) {
                    String signUp =
                        await context.read<AuthenticationService>().signUp(
                              email: emailFieldController.text,
                              pass: passController.text,
                            );

                    if (signUp.contains("Signed Up")) {
                      // Redirect to homepage.
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return HomePageScreen();
                      }));
                    } else {
                      // If there are any errors from Firebase, we will show it using
                      // this in the main page.
                      setState(() {
                        errorVisibility = true;
                        errorMsg = signUp;
                      });
                    }
                  } else {
                    setState(() {
                      errorVisibility = true;
                      errorMsg = 'Passwords do not match.';
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
