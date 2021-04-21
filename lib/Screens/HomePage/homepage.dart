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
  bool isNormalUser = false;
  bool isSearch = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController searchFieldController = TextEditingController();
  String docID;
  Map userData;

  ///////////////////
  // Custom functions
  ///////////////////

  // Gets provided user's data from firebase and sets it
  // in userData Map for later use.
  getUserInfo() async
  {
    await FirebaseFirestore.instance.collection('users').doc(docID).get().then((value) {
      setState(() {
        userData = value.data();
      });
    });
  }
  // Gets the user id for the next function to use it for.
  getDocumentID(personalID) async
  {
    QuerySnapshot userID = await FirebaseFirestore.instance.collection('users').where("personal_id", isEqualTo: personalID).get();

    setState(() {
      if(userID.docs.isNotEmpty)
        docID = userID.docs.first.id;
    });
  }
  // Populates the ResultsCard widget on screen for each entry found in DB.
  List<Widget> makeResults(List<QueryDocumentSnapshot> data) {
    List<Widget> results = [];

    if (data.isNotEmpty) {
      data.forEach((element) {
        if(!isNormalUser && results.length == 0)
        {
          // Error handling condition to avoid null error.
          if(userData == null)
            getUserInfo();
          if(userData != null)
          {
            var textStyle = textThemeDefault.headline4;
            // When practitioner searched for a patient using personal_id,
            // this shows the patient details before results.
            results.add(Container(
              margin: EdgeInsets.all(25),
              padding: EdgeInsets.all(25),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: kPrimaryLightColor,
                  border: Border.all(
                    color: colorBlack,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Column(
                children: [
                  Text("Patient's name: ${userData['full_name']}", style: textStyle),
                  Text("Patient's phone #: ${userData['phone_num']}", style: textStyle),
                  Text("Patient's DOB: ${userData['dob']}", style: textStyle),
                ],
              ),
            ));
          }

        }
        // Populate the results card.
        String medicinesList = element.data()['medicines'];
        String diagnosesList = element.data()['diagnoses'];
        //print(element.reference.id);
        results.add(ResultsCard(
          dateText: element.data()['date'],
          medicineList: medicinesList.replaceAll("\\n", "\n"),
          diagnosesText: diagnosesList.replaceAll("\\n", "\n"),
          hospitalName: element.data()['hospital_name'],
          recordID: element.reference.id,
          btnEnabled: isNormalUser ? true : false,
        ));
      });
      return results;
    }
    return [Text("No records found.")];
  }

  Widget searchResults() {

    return Column(children: [
      SingleChildScrollView(
        child: FutureBuilder<QuerySnapshot>(
            future: FirebaseFirestore.instance
                .collection('users')
                .doc(docID)
                .collection("medical_records")
                .get(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshot) {
              List<Widget> children;
              if (snapshot.hasData) {
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
                    child: Text('Awaiting results...'),
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
    ]);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String userID = (FirebaseAuth.instance.currentUser != null)
        ? context.watch<User>().uid
        : ".";
    FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .snapshots()
        .listen((snaps) {
      if (snaps.data()['account_type'] == "Normal User") {
        setState(() {
          isNormalUser = true;
        });
      }
    });

    return CustomDrawer(
      child: (isNormalUser)
          ? Column(
              children: <Widget>[
                RoundedButton(
                  text: "Add new record",
                  color: kPrimaryColor,
                  press: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return AddNewRecord();
                    }));
                  },
                ),
                SingleChildScrollView(
                  child: FutureBuilder<QuerySnapshot>(
                      future: FirebaseFirestore.instance
                          .collection('users')
                          .doc(userID)
                          .collection("medical_records")
                          .get(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        List<Widget> children;
                        if (snapshot.hasData) {
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
                              child: Text('Awaiting results...'),
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
            )
          : Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty) return 'This field cannot be empty';
                        return null;
                      },
                      controller: searchFieldController,
                      decoration: InputDecoration(
                        hintText: "Search using patient's ID number",
                      ),
                    ),
                  ),
                  RoundedButton(
                    text: "Search",
                    color: kPrimaryColor,
                    press: () {
                      setState(() {
                        userData = null;
                        isSearch = true;
                      });
                      getDocumentID(searchFieldController.text);
                    },
                  ),
                  isSearch ? searchResults() : Text(""),
                ],
              ),
            ),
    );
  }
}
