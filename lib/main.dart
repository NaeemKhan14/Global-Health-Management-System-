import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ghms/Backend/Authentication/authentication_service.dart';
import 'package:ghms/Screens/HomePage/homepage.dart';
import 'package:ghms/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Screens/WelcomeScreen/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<AuthenticationService>().authStateChanges,
          initialData: null,
        )
      ],
      child: MaterialApp(
        title: "Global Health Management System",
        theme: ThemeData(
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: Colors.white,
        ),
        home: AuthenticationWrapper(),
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    // Show welcome screen if user is not logged in.
    if(firebaseUser != null)
    {
      return HomePageScreen();
    }
    // Take to homepage if user is logged in.
    return WelcomeScreen();
  }
}
