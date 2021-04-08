import 'package:flutter/material.dart';
import 'TextFieldContainer.dart';
import 'package:ghms/constants.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged onChange;
  final String hintText;

  const RoundedPasswordField({
    Key key,
    this.onChange,
    this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: true,
        onChanged: onChange,
        decoration: InputDecoration(
          hintText: hintText,
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: kPrimaryColor,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
