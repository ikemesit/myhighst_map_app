import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authStateProvider =
    StreamProvider<User?>((ref) => Auth().authStateChanges);

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      String? errorMessage;

      switch (e.code) {
        case "firebase_auth/invalid-email":
        case "wrong-password":
        case "user-not-found":
          {
            errorMessage = "Wrong email address or password.";
            break;
          }
        case "auth/user-disabled":
        case "user-disabled":
          {
            errorMessage = "This account is disabled";
            break;
          }
      }

      if (errorMessage != null) {
        throw errorMessage;
      }
    }
  }

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
