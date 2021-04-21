import 'package:flutter/material.dart';
import 'package:ghms/Screens/HomePage/components/custom_drawer.dart';
import 'package:ghms/Screens/WelcomeScreen/components/rounded_button.dart';
import 'package:ghms/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:ui' as UI;

class AddNewRecord extends StatefulWidget {
  @override
  _AddNewRecordState createState() => _AddNewRecordState();
}

class _AddNewRecordState extends State<AddNewRecord> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController hospitalNameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController diagnosesController = TextEditingController();
  final TextEditingController medicinesController = TextEditingController();

  Widget _buildPopupDialog(BuildContext context) {
    return AlertDialog(
      title: Text("Success"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Records have been updated successfully!"),
        ],
      ),
      actions: [
        RoundedButton(
          color: kPrimaryColor,
          text: "Close",
          press: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    UI.Size size = MediaQuery.of(context).size;

    return CustomDrawer(
      child: Container(
        decoration: BoxDecoration(
            color: kPrimaryLightColor,
            border: Border.all(
              color: colorBlack,
            ),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        height: size.height - 100,
        width: size.width - 39,
        child: Padding(
          padding: EdgeInsets.all(30.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ElevatedButton(
                //   onPressed: () {},
                //   child: Text("Scan"),
                // ),
                TextFormField(
                  controller: hospitalNameController,
                  validator: (value) =>
                      (value.isEmpty) ? "This field is required." : null,
                  style: TextStyle(
                    color: colorBlack,
                    fontSize:
                        Theme.of(context).textTheme.bodyText1.fontSize + 2,
                  ),
                  decoration: InputDecoration(
                    hintText: "Hospital name",
                  ),
                ),
                TextFormField(
                  controller: dateController,
                  validator: (value) =>
                      (value.isEmpty) ? "This field is required." : null,
                  style: TextStyle(
                    color: colorBlack,
                    fontSize:
                        Theme.of(context).textTheme.bodyText1.fontSize + 2,
                  ),
                  decoration: InputDecoration(
                    hintText: "Date of visit",
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  reverse: true,
                  child: TextFormField(
                    controller: diagnosesController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 6,
                    validator: (value) =>
                        (value.isEmpty) ? "This field is required." : null,
                    style: TextStyle(
                      color: colorBlack,
                      fontSize:
                          Theme.of(context).textTheme.bodyText1.fontSize + 2,
                    ),
                    decoration: InputDecoration(
                      hintText: "Diagnoses",
                    ),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  reverse: true,
                  child: TextFormField(
                    controller: medicinesController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 6,
                    validator: (value) =>
                        (value.isEmpty) ? "This field is required." : null,
                    style: TextStyle(
                      color: colorBlack,
                      fontSize:
                          Theme.of(context).textTheme.bodyText1.fontSize + 2,
                    ),
                    decoration: InputDecoration(
                      hintText: "Medicines prescribed",
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: RoundedButton(
                        text: "Add",
                        color: kPrimaryColor,
                        press: () {
                          if (_formKey.currentState.validate()) {
                            CollectionReference medicalRecords =
                                FirebaseFirestore.instance
                                    .doc('users/' +
                                        FirebaseAuth.instance.currentUser.uid)
                                    .collection('medical_records');

                            medicalRecords.add({
                              'date': dateController.text,
                              'hospital_name': hospitalNameController.text,
                              'diagnoses': diagnosesController.text,
                              'medicines': medicinesController.text,
                            });

                            medicinesController.clear();
                            dateController.clear();
                            diagnosesController.clear();
                            hospitalNameController.clear();
                            showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    _buildPopupDialog(context));
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
