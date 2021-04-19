import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ghms/Screens/HomePage/components/custom_drawer.dart';
import 'package:ghms/Screens/WelcomeScreen/components/rounded_button.dart';
import 'package:ghms/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _enabled = false;
  Map data;
  String _date = "";

  _getData() {
    if (data == null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(context.watch<User>().uid)
          .snapshots()
          .listen((snaps) {
        setState(() {
          data = snaps.data();
        });
      });
    }
  }

  Widget _buildPopupDialog(BuildContext context) {
    return AlertDialog(
      title: Text("Success!"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Your profile has been updated!"),
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
  void dispose() {
    data = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _getData();

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Personal Information",
                    style: Theme.of(context).textTheme.headline2
                    ,
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      setState(() {
                        _enabled = !_enabled;
                      });
                    },
                  ),
                ],
              ),
              Divider(
                thickness: 1,
              ),
              (data == null)
                  ? Column(
                      children: [
                        SizedBox(
                          child: CircularProgressIndicator(),
                          width: 60,
                          height: 60,
                        ),
                        Padding(
                          padding: EdgeInsets.all(30.0),
                          child: Text(
                            'Awaiting results...',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                      ],
                    )
                  : Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Full Name:",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          TextFormField(
                            controller: nameController,
                            style: TextStyle(
                              color: colorBlack,
                              fontSize: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .fontSize +
                                  2,
                            ),
                            enabled: _enabled,
                            decoration: InputDecoration(
                              hintText: data['full_name'],
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          Text(
                            "DOB:",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          TextFormField(
                            onTap: () {
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());

                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now(),
                              ).then((value) {
                                if (value != null) {
                                  setState(() {
                                    _date = value.day.toString() +
                                        "-" +
                                        value.month.toString() +
                                        "-" +
                                        value.year.toString();
                                  });
                                }
                              });
                            },
                            controller: dobController,
                            style: TextStyle(
                              color: colorBlack,
                              fontSize: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .fontSize +
                                  2,
                            ),
                            enabled: _enabled,
                            decoration: InputDecoration(
                              hintText: (_date == '') ? data['dob'] : _date,
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          Text(
                            "Phone Number:",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          TextFormField(
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            keyboardType: TextInputType.number,
                            controller: phoneNumController,
                            style: TextStyle(
                              color: colorBlack,
                              fontSize: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .fontSize +
                                  2,
                            ),
                            enabled: _enabled,
                            decoration: InputDecoration(
                              hintText: data['phone_num'],
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          Text(
                            "ID Number:",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          TextFormField(
                            controller: idController,
                            style: TextStyle(
                              color: colorBlack,
                              fontSize: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .fontSize +
                                  2,
                            ),
                            enabled: _enabled,
                            decoration: InputDecoration(
                              hintText: data['personal_id'],
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          Text(
                            "E-mail: ",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          TextFormField(
                            style: TextStyle(
                              color: colorBlack,
                              fontSize: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .fontSize +
                                  2,
                            ),
                            enabled: false,
                            decoration: InputDecoration(
                              hintText: (context.watch<User>() != null &&
                                  context.watch<User>().email != null) ? context.watch<User>().email : "",
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          _enabled
                              ? RoundedButton(
                                  text: "Save",
                                  color: kPrimaryColor,
                                  press: () async {
                                    if (_formKey.currentState.validate()) {
                                      DocumentReference user = FirebaseFirestore
                                          .instance
                                          .doc('users/' +
                                              FirebaseAuth
                                                  .instance.currentUser.uid);

                                      user.set({
                                        'full_name': nameController.text.isEmpty
                                            ? data['full_name']
                                            : nameController.text,
                                        'phone_num':
                                            phoneNumController.text.isEmpty
                                                ? data['phone_num']
                                                : phoneNumController.text,
                                        'personal_id': idController.text.isEmpty
                                            ? data['personal_id']
                                            : idController.text,
                                        'dob':
                                            (_date == '') ? data['dob'] : _date,
                                      });

                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              _buildPopupDialog(context));
                                      setState(() {
                                        _enabled = !_enabled;
                                      });
                                    }
                                  },
                                )
                              : Text(''),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
