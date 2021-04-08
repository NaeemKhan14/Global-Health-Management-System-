import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService
{
  final FirebaseAuth _firebaseAuth;
  AuthenticationService(this._firebaseAuth);
  // Returns null if user is not logged in.
  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  // Sign in user
  Future<String> signIn({String email, String password}) async
  {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return "Signed in";
    } on FirebaseAuthException catch(e) {
      return e.message;
    }
  }
  // Sign up user
  Future<String> signUp({String email, String password}) async
  {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return "Signed in";
    } on FirebaseAuthException catch(e) {
      return e.message;
    }
  }
}