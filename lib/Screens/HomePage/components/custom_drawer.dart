import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ghms/Backend/Authentication/authentication_service.dart';
import 'package:ghms/Screens/HomePage/homepage.dart';
import 'package:ghms/Screens/Profile/profile_screen.dart';
import 'package:ghms/Screens/WelcomeScreen/welcome_screen.dart';
import 'package:ghms/constants.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CustomDrawer extends StatefulWidget {
  final Widget child;

  const CustomDrawer({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final padding = EdgeInsets.all(20.0);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

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
                      (context.watch<User>() != null &&
                              context.watch<User>().displayName != null)
                          ? "Welcome\n" + context.watch<User>().displayName
                          : "Welcome ",
                      style: theme.textTheme.headline2,
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
                leading: Icon(Icons.person),
                title: Text('Profile'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ProfileScreen();
                  }));
                },
              ),
              ListTile(
                leading: Icon(Icons.receipt),
                title: Text('Medical Records'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return HomePageScreen();
                  }));
                },
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
                    color: kPrimaryLightColor,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: colorBlack),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Icon(Icons.menu),
                            onPressed: () =>
                                scaffoldKey.currentState.openDrawer(),
                          ),
                          IconButton(
                            icon: Icon(Icons.settings),
                            onPressed: () {},
                          ),
                        ]),
                  ),
                ),
              ),
              widget.child,
            ],
          ),
        ),
      ),
    );
  }
}
