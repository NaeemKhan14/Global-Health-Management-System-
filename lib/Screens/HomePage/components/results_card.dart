import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class ResultsCard extends StatelessWidget {
  final String hospitalName, dateText, diagnosesText, medicineList;

  const ResultsCard({
    Key key,
    this.hospitalName,
    this.dateText,
    this.diagnosesText,
    this.medicineList,
  }) : super(key: key);

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
                    child: Text(
                      hospitalName,
                      style: Theme.of(context).textTheme.headline3,
                    )),
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
