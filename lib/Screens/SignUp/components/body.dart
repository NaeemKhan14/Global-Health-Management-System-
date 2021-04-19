import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ghms/Backend/Authentication/authentication_wrapper.dart';
import 'package:ghms/Screens/Login/components/TextFieldContainer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'background.dart';
import 'package:ghms/Screens/WelcomeScreen/components/rounded_button.dart';
import 'package:ghms/constants.dart';
import 'package:provider/provider.dart';
import 'package:ghms/Backend/Authentication/authentication_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

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
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();
  final TextEditingController phoneNumController = TextEditingController();
  final TextEditingController personalIDController = TextEditingController();
  final TextEditingController documentController = TextEditingController();
  String errorMsg = '';
  bool errorVisibility = false;
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;
  bool _altUser = false;
  File _image;
  String _date = "";
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;

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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Account Type: "),
                Switch(
                    activeColor: kPrimaryColor,
                    value: _altUser,
                    onChanged: (value) {
                      setState(() {
                        _altUser = !_altUser;
                      });
                    }),
                Text(
                  !_altUser ? "Normal User" : "Medical Practitioner",
                ),
              ],
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
                            _passwordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
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
                            _confirmPasswordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: kPrimaryColor,
                          ),
                          onPressed: () {
                            setState(() {
                              _confirmPasswordVisible =
                              !_confirmPasswordVisible;
                            });
                          },
                        ),
                        hintText: "Confirm password",
                      ),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) return 'Full name field is required';
                        return null;
                      },
                      controller: fullNameController,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.perm_identity,
                          color: kPrimaryColor,
                        ),
                        hintText: "Full name",
                      ),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty && _date.isEmpty) {
                          return 'DOB name field is required';
                        }
                        return null;
                      },
                      onTap: () {
                        FocusScope.of(context).requestFocus(new FocusNode());

                        showDatePicker(context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        ).then((value) {
                          if(value != null)
                          {
                            setState(() {
                              _date = value.day.toString() + "-" + value.month.toString() + "-" + value.year.toString();
                            });
                          }
                        });
                      },
                      controller: dobController,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.date_range,
                          color: kPrimaryColor,
                        ),
                        hintText: (_date == '') ? "Date of birth" : _date,
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
                        border: !_altUser
                            ? InputBorder.none
                            : UnderlineInputBorder(),
                        icon: Icon(
                          Icons.person,
                          color: kPrimaryColor,
                        ),
                        hintText: "Personal ID number",
                      ),
                    ),
                    // If slider button is pressed, then show an extra input field
                    // at the end.
                    _altUser
                        ? TextFormField(
                      readOnly: true,
                      validator: (value) {
                        if (value.isEmpty && _image == null)
                          return 'Document field is required.';
                        return null;
                      },
                      controller: documentController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(
                          Icons.description,
                          color: kPrimaryColor,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.file_upload,
                            color: kPrimaryColor,
                          ),
                          onPressed: getImage,
                        ),
                        hintText: (_image == null)
                            ? "Upload your document"
                            : _image.path
                            .split("/")
                            .last,
                      ),
                    )
                        : Visibility(
                      child: Text(""),
                      visible: false,
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

                    User user = FirebaseAuth.instance.currentUser;
                    user.updateProfile(displayName: fullNameController.text);

                    if (signUp.contains("Signed Up")) {
                      DocumentReference users = FirebaseFirestore.instance
                          .doc('users/' + signUp.split(",")[0]);
                      users.set({
                        'phone_num': phoneNumController.text,
                        'personal_id': personalIDController.text,
                        'full_name': fullNameController.text,
                        'dob': _date,
                        'account_type': !_altUser
                            ? 'Normal User'
                            : 'Practitioner',
                      });

                      if (!user.emailVerified) {
                        await user.sendEmailVerification();
                      }
                      // Redirect to AuthenticationWrapper class.
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return AuthenticationWrapper();
                          }));
                    } else {
                      // If there are any errors from Firebase, we will show it using
                      // this in the main page.
                      setState(() {
                        errorVisibility = true;
                        errorMsg = signUp;
                      });
                    }
                  }
                  // If passwords do not match.
                  else {
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

  // Selects and retrieves image from gallery.
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
        return _image;
      }
    });
  }

}
