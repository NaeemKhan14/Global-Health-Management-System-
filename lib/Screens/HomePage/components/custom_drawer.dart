import 'package:flutter/material.dart';
import 'package:ghms/Backend/Authentication/authentication_service.dart';
import 'package:ghms/Screens/WelcomeScreen/welcome_screen.dart';
import 'package:ghms/constants.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  final Widget child;

  const CustomDrawer({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final scaffoldKey = GlobalKey<ScaffoldState>();
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final padding = EdgeInsets.all(20.0);

    return Scaffold(
      key: scaffoldKey,
      drawer: ClipRRect(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(7), bottomRight: Radius.circular(7)),
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Padding(
                padding: padding,
                child: CircleAvatar(
                  child: ClipOval(
                    child: Image.asset("assets/images/avatar.png"),
                  ),
                  radius: 60,
                  // backgroundImage: ExactAssetImage("assets/images/avatar.png"),
                  backgroundColor: Colors.transparent,
                ),
              ),
              Padding(
                padding: padding,
                child: Stack(
                  children: <Widget>[
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      "Welcome Bruh",
                      style: theme.textTheme.headline1,
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                  ],
                ),
              ),
              Divider(
                height: 1,
                thickness: 1,
              ),
              ListTile(
                leading: Icon(Icons.edit),
                title: Text('Edit Profile'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.receipt),
                title: Text('Medical Records'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.help),
                title: Text('About'),
                onTap: () {},
              ),
              Divider(
                height: 1,
                thickness: 1,
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text("Sign out"),
                onTap: () {
                  context.read<AuthenticationService>().signOut();
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return WelcomeScreen();
                  }));
                },
              ),
            ],
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: padding,
                  child: Material(
                    color: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: colorBlack),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.menu),
                      onPressed: () => scaffoldKey.currentState.openDrawer(),
                    ),
                  ),
                ),
              ),
              child,
            ],
          ),
        ),
      ),
    );
  }
}
