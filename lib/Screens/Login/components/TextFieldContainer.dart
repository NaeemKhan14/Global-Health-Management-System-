import 'package:flutter/material.dart';
import 'package:ghms/constants.dart';

class TextFieldContainer extends StatelessWidget {
  // Properties.
  final Widget child;
  // Constructor.
  const TextFieldContainer({Key key, this.child}) : super(key: key);
  // Build method that is called every time the page is loaded.
  @override
  Widget build(BuildContext context) {
    // Get device screen size.
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      // Background color and border for the widget.
      decoration: BoxDecoration(
        color: kPrimaryLightColor,
        borderRadius: BorderRadius.circular(29),
      ),
      // Child widget passed to this class.
      child: child,
    );
  }
}
