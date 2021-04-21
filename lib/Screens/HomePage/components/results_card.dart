import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable/expandable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ghms/Screens/WelcomeScreen/components/rounded_button.dart';
import 'package:ghms/constants.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class ResultsCard extends StatelessWidget {
  final String hospitalName, dateText, diagnosesText, medicineList, recordID;
  final bool btnEnabled;

  const ResultsCard({
    Key key,
    this.hospitalName,
    this.dateText,
    this.diagnosesText,
    this.medicineList,
    this.recordID,
    this.btnEnabled,
  }) : super(key: key);

  // Builds the popup dialog for sending e-mail messages.
  Widget _buildEmailPopupDialog(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    return AlertDialog(
      title: Text("Send this medical record."),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              validator: (value) {
                Pattern pattern =
                    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                    r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                    r"{0,253}[a-zA-Z0-9])?)*$";
                RegExp regex = new RegExp(pattern);
                if (!regex.hasMatch(value) || value == null)
                  return 'Enter a valid email address';
                else
                  return null;
              },
              controller: emailController,
              style: TextStyle(
                color: colorBlack,
                fontSize: Theme.of(context).textTheme.bodyText1.fontSize + 2,
              ),
              decoration: InputDecoration(
                hintText: "Recipient's e-mail",
              ),
            ),
          ],
        ),
      ),
      actions: [
        RoundedButton(
          text: "Send",
          color: kPrimaryColor,
          press: () async {
            if (_formKey.currentState.validate()) {
              print(emailController.text);
              var b = FirebaseFirestore.instance
                  .collection('users')
                  .doc(FirebaseAuth.instance.currentUser.uid)
                  .collection("medical_records")
                  .doc(recordID)
                  .snapshots();
              b.forEach((element) async {
                String medicinesList = element.data()['medicines'];
                String diagnosesList = element.data()['diagnoses'];
                final Email email = Email(
                  body:
                      'Hospital name: ${element.data()['hospital_name']}\nDate of visit: ${element.data()['date']}\ndiagnoses: ${diagnosesList.replaceAll("\\n", "\n")}\nMedicines List: ${medicinesList.replaceAll("\\n", "\n")}\n',
                  subject: 'My medical records.',
                  recipients: [emailController.text],
                  isHTML: false,
                );
                await FlutterEmailSender.send(email);
              });
            }
          },
        ),
        RoundedButton(
          color: kPrimaryColor,
          text: "Close",
          press: () => {Navigator.of(context).pop()},
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
        child: Padding(
      padding: EdgeInsets.all(10),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 30,
              child: Text(
                dateText,
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            ScrollOnExpand(
              scrollOnExpand: true,
              scrollOnCollapse: false,
              child: ExpandablePanel(
                theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToCollapse: true,
                ),
                header: Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        hospitalName,
                        style: Theme.of(context).textTheme.headline3,
                      ), btnEnabled ?
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  _buildEmailPopupDialog(context));
                        },
                        style: ElevatedButton.styleFrom(
                          primary: kPrimaryColor,
                        ),
                        child: Text("Send"),
                      ) : Text(""),
                    ],
                  ),
                ),
                collapsed: Text(
                  "Diagnoses: \n\n" + diagnosesText,
                  softWrap: true,
                  maxLines: 30,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline6,
                ),
                expanded: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text(
                          "Medicine List:\n\n" + medicineList,
                          softWrap: true,
                          overflow: TextOverflow.fade,
                          style: Theme.of(context).textTheme.headline6,
                        )),
                  ],
                ),
                builder: (_, collapsed, expanded) {
                  return Padding(
                    padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: Expandable(
                      collapsed: collapsed,
                      expanded: expanded,
                      theme: const ExpandableThemeData(crossFadePoint: 0),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
