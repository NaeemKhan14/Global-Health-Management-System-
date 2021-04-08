import 'package:flutter/material.dart';
import 'package:ghms/constants.dart';

class ExtraLoginActions extends StatelessWidget {
  final Function onPress;
  final String hintText;
  final String btnText;

  const ExtraLoginActions({
    Key key,
    this.onPress,
    this.hintText,
    this.btnText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          hintText,
          style: TextStyle(color: kPrimaryColor),
        ),
        GestureDetector(
          onTap: onPress,
          child: Text(
            btnText,
            style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
