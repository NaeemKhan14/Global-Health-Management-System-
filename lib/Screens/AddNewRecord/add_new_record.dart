import 'package:flutter/material.dart';
import 'package:ghms/Screens/HomePage/components/custom_drawer.dart';
import 'package:ghms/Screens/Login/components/TextFieldContainer.dart';
import 'package:ghms/Screens/WelcomeScreen/components/rounded_button.dart';
import 'package:ghms/constants.dart';

class AddNewRecord extends StatefulWidget {
  @override
  _AddNewRecordState createState() => _AddNewRecordState();
}

class _AddNewRecordState extends State<AddNewRecord> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomDrawer(
      child: Column(
        children: [
          RoundedButton(
            text: "Scan medical record",
            color: kPrimaryColor,
            press: () {},
          ),
        ],
      ),
    );
  }
}
