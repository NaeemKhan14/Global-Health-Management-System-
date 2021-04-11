import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;
  AuthenticationService(this._firebaseAuth);
  // Returns null if user is not logged in.
  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();
  // Sign in user
  Future<String> signIn({String email, String pass}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: pass);
      return "Signed in";
    } on FirebaseAuthException catch (e) {
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
  Future<String> signUp({String email, String pass}) async {
    try {
      final user = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: pass);
      return user.user.uid + ", Signed Up";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
  // Sign user out
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<String> forgotPassword({String email}) async
  {
      try {
        await _firebaseAuth.sendPasswordResetEmail(email: email);
        return "Password reset link sent. Please check your e-mail address.";
      } catch (e) {
        if(e.message.contains('There is no user record corresponding to this identifier.'))
          return "No user is registered with this e-mail address.";
        return e.message;
      }
  }
}
