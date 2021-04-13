import 'package:flutter/material.dart';
import 'package:ghms/Screens/AddNewRecord/add_new_record.dart';
import 'package:ghms/Screens/WelcomeScreen/components/rounded_button.dart';
import 'package:ghms/constants.dart';
import 'components/custom_drawer.dart';
import 'components/results_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePageScreen extends StatefulWidget {
  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<Widget> makeResults(List<QueryDocumentSnapshot> data) {
    List<Widget> results = [];

    if(data.isNotEmpty)
    {
      data.forEach((element) {
        String medicinesList = element.data()['medicines'];
        String diagnosesList = element.data()['diagnoses'];

        results.add(ResultsCard(
          dateText: element.data()['date'],
          medicineList: medicinesList.replaceAll("\\n", "\n"),
          diagnosesText: diagnosesList.replaceAll("\\n", "\n"),
          hospitalName: element.data()['hospital_name'],
        ));
      });
      return results;
    }

    return [Text("No records found.")];
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return CustomDrawer(
      child: Column(
        children: <Widget>[
          RoundedButton(
            text: "Add new record",
            color: kPrimaryColor,
            press: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return AddNewRecord();
              }));
            },
          ),
          SingleChildScrollView(
            child: FutureBuilder<QuerySnapshot>(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .doc(context.watch<User>().uid)
                    .collection("medical_records")
                    .get(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  List<Widget> children;
                  if (snapshot.hasData) {
                    //print(snapshot.data.docs.map((e) => e.data()));
                    children = makeResults(snapshot.data.docs);
                  } else {
                    children = const <Widget>[
                      SizedBox(
                        child: CircularProgressIndicator(),
                        width: 60,
                        height: 60,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: Text('Awaiting result...'),
                      )
                    ];
                  }
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: children,
                    ),
                  );
                }),
          ),

        ],
      ),
    );
  }
}
