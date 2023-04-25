import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authStateProvider =
    StreamProvider<User?>((ref) => ref.watch(authProvider).authStateChanges);

final authProvider =
    Provider<AuthRepository>((ref) => AuthRepository(FirebaseAuth.instance));

final authStateNotifierProvider =
    StateNotifierProvider<AuthStateNotifier, User?>((ref) {
  final user = ref.watch(authStateProvider);

  return user.when(
    data: (user) => AuthStateNotifier(user),
    loading: () => AuthStateNotifier(null),
    error: (error, stack) => AuthStateNotifier(null),
  );
});

class AuthStateNotifier extends StateNotifier<User?> {
  final User? user;

  AuthStateNotifier(this.user) : super(null) {
    _init();
    print('from auth state notifier: $user');
  }

  Future<void> _init() async {
    state = user;
  }
}

class AuthRepository {
  AuthRepository(this._firebaseAuth);

  final FirebaseAuth _firebaseAuth;

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
