import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ghms/Backend/Authentication/authentication_service.dart';
import 'package:ghms/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Backend/Authentication/authentication_wrapper.dart';
import 'dart:ui';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    double screenWidth = window.physicalSize.width;

    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
          initialData: null,
        )
      ],
      child: MaterialApp(
        title: "Global Health Management System",
        theme: ThemeData(
          primaryColor: colorWhite,
          accentColor: colorDarkBlue,
          // Display smaller fonts for smaller screens
          textTheme: screenWidth < 500 ? textThemeSmall : textThemeDefault,
          scaffoldBackgroundColor: Colors.white,
          fontFamily: "Montserrat",
        ),
        home: AuthenticationWrapper(),

      ),
    );
  }
}
