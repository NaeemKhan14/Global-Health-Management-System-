import 'package:flutter/material.dart';
import 'package:ghms/Screens/HomePage/components/custom_drawer.dart';
import 'package:ghms/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return CustomDrawer(
      child: Container(
        decoration: BoxDecoration(
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
              FutureBuilder<DocumentSnapshot>(
                future: users.doc(context.watch<User>().uid).get(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text("Something went wrong");
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    Map<String, dynamic> data = snapshot.data.data();
                    return Text("Full Name: ${data['full_name']}\n" +
                        "DOB: ${data['dob']}\n" +
                        "Phone Number: ${data['phone_num']}\n" +
                        "Identification Document Number: ${data['personal_id']}\n" +
                        "E-mail: " + context.watch<User>().email
                    );
                  } else {
                    return Column(
                      children: <Widget>[
                        SizedBox(
                          child: CircularProgressIndicator(),
                          width: 60,
                          height: 60,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 16),
                          child: Text('Awaiting results...'),
                        ),
                      ],
                    );
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
