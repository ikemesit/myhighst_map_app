import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myhighst_map_app/features/authentication/data/auth.dart';

import '../../models/user.model.dart' as model;

final usersStreamProvider = StreamProvider<List<model.User>>((ref) {
  final service = UserService();
  service._init();
  return service._stream;
});

final userServiceProvider = Provider<UserService>((ref) {
  final service = UserService();
  service._init();
  return service;
});

final firebaseUserProvider = StateProvider<User?>((ref) {
  final firebaseUser = ref.watch(authStateProvider);

  return firebaseUser.asData?.value;
});

class UserService {
  late Stream<List<model.User>> _stream;

  Future<void> _init() async {
    final Query query = FirebaseFirestore.instance.collection('users');
    final Stream<QuerySnapshot> snapshots = query.snapshots();
    _stream = snapshots.map((snapshot) {
      final result = snapshot.docs
          .map((element) => model.User.fromFirestore(
                element.data() as Map<String, dynamic>,
              ))
          .toList();
      return result;
    });
  }

  Stream<List<model.User>> stream() {
    return _stream;
  }

  Future<List<model.User>> getUsers() async {
    final Query query = FirebaseFirestore.instance.collection('users');
    final snapshots = query.get();
    List<model.User> results = [];

    await snapshots.then((snapshots) {
      for (final doc in snapshots.docs) {
        results.add(model.User.fromFirestore(
          doc.data() as Map<String, dynamic>,
        ));
      }
    });
    return results;
  }

  Future<model.User?> getUserById(String? userId) async {
    if (userId == null) return null;

    final DocumentReference<Map<String, dynamic>> docRef =
        FirebaseFirestore.instance.doc('users/$userId');
    final DocumentSnapshot<Map<String, dynamic>> snapshot = await docRef.get();
    final result =
        model.User.fromFirestore(snapshot.data() as Map<String, dynamic>);

    return result;

    // final Query query = FirebaseFirestore.instance
    //     .collection('users')
    //     .where('uid', isEqualTo: userId);
    // final snapshot = query.get();
    // List<model.User> result = [];
    //
    // await snapshot.then((snapshots) {
    //   for (final doc in snapshots.docs) {
    //     result.add(model.User.fromFirestore(
    //       doc.data() as Map<String, dynamic>,
    //     ));
    //   }
    // });
  }
}
