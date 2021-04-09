import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  // Returns null if user is not logged in.
  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  // Sign in user
  Future<String> signIn({String uname, String pass}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: uname, password: pass);
      return "Signed in";
    } on FirebaseAuthException catch (e) {
      print(e.message);
      if (e.message.contains("The email address is badly formatted."))
      {
        return "Please enter a valid e-mail address.";
      } else
        {
          return "Invalid username/password.";
        }
    }
  }

  // Sign up user
  Future<String> signUp({String email, String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return "Signed Up";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
