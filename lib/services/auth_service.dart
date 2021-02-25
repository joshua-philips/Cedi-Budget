import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<String> get onAuthStateChanged => _firebaseAuth.authStateChanges().map(
        (user) => user?.uid,
      );

  /// Get uid of current user
  String getCurrentUID() {
    return _firebaseAuth.currentUser.uid;
  }

  /// Get the current user
  User getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  /// Sign Up With email and password
  Future<String> createUserWithEmailAndPassword(
      String email, String password, String name) async {
    final currentUser = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);

    if (name != null || name != '') {
      await currentUser.user.updateProfile(displayName: name);
    }

    return currentUser.user.uid;
  }

  /// Sign in with email and password
  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    return (await _firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password))
        .user
        .uid;
  }

  Future<void> signOut() {
    return _firebaseAuth.signOut();
  }
}
