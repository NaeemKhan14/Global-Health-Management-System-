import 'package:flutter/material.dart';
import 'TextFieldContainer.dart';
import 'package:ghms/constants.dart';

class RoundedInputField extends StatefulWidget {
  final String hintText;
  final IconData icon;
  final TextEditingController controller;

  const RoundedInputField({
    Key key,
    this.hintText,
    this.icon,
    this.controller,
  }) : super(key: key);

  @override
  _RoundedInputFieldState createState() => _RoundedInputFieldState();

}

class _RoundedInputFieldState extends State<RoundedInputField> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: TextFieldContainer(
        child: TextFormField(
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
          controller: widget.controller,
          decoration: InputDecoration(
            icon: Icon(
              widget.icon,
              color: kPrimaryColor,
            ),
            hintText: widget.hintText,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
